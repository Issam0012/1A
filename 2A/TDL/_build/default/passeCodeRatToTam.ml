
open Tds
open Ast
open Code
open Type
open Tam

type t1 = Ast.AstPlacement.programme
type t2 = string


let rec analyse_code_expression e =
  match e with
  | AstType.Ident info ->
    begin
      match info_ast_to_info info with
      | InfoVar (_, t, dep, reg) -> load (getTaille t) dep reg
      | InfoConst (_,i) -> loadl_int i
      | _ -> failwith "internal error"
    end
  | AstType.Booleen b ->
    begin
      if b then loadl_int 1
      else loadl_int 0
    end 
  | AstType.Entier i -> 
      loadl_int i
  | AstType.Unaire (op,e1) -> 
    begin
      let c = (analyse_code_expression e1) in
      c^(match op with
      | Numerateur -> pop 0 1
      | Denominateur -> pop 1 1
      )
    end
  | AstType.Binaire (op,e1,e2) -> 
    begin
      let c1 = (analyse_code_expression e1) in
      let c2 = (analyse_code_expression e2) in
      c1^c2^(match op with
      | Fraction -> ""
      | PlusInt -> subr "iadd"
      | PlusRat -> call "ST" "radd"
      | MultInt -> subr "imul"
      | MultRat -> call "ST" "rmul"
      | EquInt -> subr "ieq"
      | EquBool -> subr "ieq"
      | Inf -> subr "ilss"
      )
    end
  | AstType.AppelFonction (info, le) ->
    begin
      let c = (String.concat "" (List.map analyse_code_expression le)) in
      match info_ast_to_info info with
      | InfoFun(f, _ , _) -> c^(call "ST" f) 
      | _ -> failwith "internal error"
    end



let rec analyse_code_instruction i =
  match i with
  | AstPlacement.Declaration (info, e) ->
    begin
    match info_ast_to_info info with
    | InfoVar(_,t,d,r) -> push (getTaille t)
    ^(analyse_code_expression e)
     ^ (store (getTaille t) d r)
    | _ -> failwith "internal error"
    end
  | AstPlacement.Affectation (info,e) ->
    begin
      match info_ast_to_info info with
      | InfoVar(_,t,d,r) -> let ne = (analyse_code_expression e) in ne ^ store (getTaille t) d r
      | _ -> failwith "internal error"
    end
  | AstPlacement.AffichageInt e ->
    begin
    let ne = (analyse_code_expression e) in
    ne ^ subr "iout"
    end
  | AstPlacement.AffichageRat e ->
    begin
      let ne = (analyse_code_expression e) in
      ne^ call "ST" "rout"
      end
  | AstPlacement.AffichageBool e ->
      begin
        let ne = (analyse_code_expression e) in
        ne^subr "bout"
       end
  | AstPlacement.Conditionnelle (c,t,e) ->
    begin
      let sinonL = getEtiquette() in
      let finL = getEtiquette() in
      analyse_code_expression c
      ^ jumpif 0 sinonL
      ^ analyse_code_bloc t
      ^ jump finL 
      ^ sinonL ^ "\n"
      ^ analyse_code_bloc e
      ^ finL ^ "\n"
    end
  | AstPlacement.TantQue (c,b) ->
    begin
      let whileL = getEtiquette() in
      let endwhileL = getEtiquette() in
      whileL ^ "\n"
      ^analyse_code_expression c
      ^ jumpif 0 endwhileL
      ^ analyse_code_bloc b
      ^ jump whileL
      ^ endwhileL ^ "\n"
    end
  | AstPlacement.Retour (e,tr, tp) -> 
    let ne = (analyse_code_expression e) in
    ne ^ return tr tp
  | AstPlacement.Empty -> ""



and analyse_code_bloc (li, taillevarlocales) =
String.concat "" (List.map analyse_code_instruction li)
^ (pop 0 taillevarlocales)




let analyse_code_fonction (AstPlacement.Fonction(info, _, (li, _))) =
  match info_ast_to_info info with
    | InfoFun(n, _, _) ->
      n ^ "\n"
      ^ String.concat "" (List.map analyse_code_instruction li)
      ^ halt
    | _ -> failwith "Internal error"



let analyser (AstPlacement.Programme(fonctions, bloc)) =
  getEntete()
  ^ String.concat "" (List.map analyse_code_fonction fonctions)
  ^ "main \n"
  ^ analyse_code_bloc bloc
  ^ halt