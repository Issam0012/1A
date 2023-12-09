open Tds
open Ast
open Code
open Type
open Tam

type t1 = Ast.AstPlacement.programme
type t2 = string


(*let rec analyse_type_affectable (a) =
  match a with
  | AstTds.Deref af -> 
  begin
  end
  | AstTds.Ident info -> 
  begin
      match info_ast_to_info info with
      | InfoVar (_, t, dep, reg) -> load (getTaille t) dep reg
      | InfoConst (_,i) -> loadl_int i
      | _ -> failwith "internal error"
    end
*)

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
  | AstType.Conditionnelleternaire (c, e1, e2) ->
    (* Un traitement semblable à la conditionnelle normale *)
      begin
        let sinonL = getEtiquette() in
        let finL = getEtiquette() in
        analyse_code_expression c
        ^ jumpif 0 sinonL
        ^ analyse_code_expression e1
        ^ jump finL 
        ^ sinonL ^ "\n"
        ^ analyse_code_expression e2
        ^ finL ^ "\n"
      end
  (* | Null  -> "SUBR MVoid\n"
  | New t -> "LOADL " ^ (string_of_int (getTaille t)) ^ "\n" ^ "SUBR MAlloc\n"
  | Adresse info ->
    begin
      match info_ast_to_info info with 
      | InfoVar(_, _, dep, reg) -> "LOADA " ^ (string_of_int dep) ^ " [" ^ reg ^ "]\n"
      | _ -> failwith "internal error" 
    end *)
  (* | Affectable a -> (analyse_code_affectable a) *)



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
    
  | AstPlacement.ConditionnelleOptionnel (c,t) ->
    (* un traitement semblable à la conditionnelle normale sans l'étiquette du else *)
      begin
        let finL = getEtiquette() in
        analyse_code_expression c
        ^ jumpif 0 finL
        ^ analyse_code_bloc t
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
  | AstPlacement.Loop (b) -> 
    (* un traitement semblable au boucle tantque, sans condition bien sûr, et on passe le nom et les étiquettes en paramètres *)
    begin 
      let loopL = getEtiquette() in
      let finLoop = getEtiquette() in
      loopL ^ "\n" ^
      analyse_code_bloc_loop b ["",loopL,finLoop] ^
      jump loopL ^
      finLoop ^ "\n"
    end
  | AstPlacement.LoopNom (n,b) -> 
    (* un traitement semblable au boucle tantque, sans condition bien sûr, et on passe le nom et les étiquettes en paramètres *)
    let loopL = getEtiquette() in
    let finLoop = getEtiquette() in
    loopL ^ "\n" ^
    analyse_code_bloc_loop b [n,loopL,finLoop] ^
    jump loopL ^
    finLoop ^ "\n"
  | _ -> failwith "internal error" (* pas de break ou continue ici car ils n'ont du sens qu'à l'intérieur du loop *)
  (*| AstPlacement.AffectationPointeur(a, e) ->
    begin
     match a with
    | AstTds.Deref af -> 
      begin
      match af with
      | Pointeur t, n -> let ne = (analyse_code_expression e) in ne ^ store (getTaille t) d r (*comment récupérer d et r ?*)
      | _ -> failwith "internal error"
      end
    | AstTds.Ident n -> 
      begin
      match info_ast_to_info info with
      | InfoVar(_,t,d,r) -> let ne = (analyse_code_expression e) in ne ^ store (getTaille t) d r
      | _ -> failwith "internal error"
      end
    end
    *)


  and analyse_code_bloc (li, taillevarlocales) =
    String.concat "" (List.map analyse_code_instruction li)
    ^ (pop 0 taillevarlocales)


  and analyse_code_instruction_loop l i =
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
        ^ analyse_code_bloc_loop t l
        ^ jump finL 
        ^ sinonL ^ "\n"
        ^ analyse_code_bloc_loop e l
        ^ finL ^ "\n"
      end
    | AstPlacement.ConditionnelleOptionnel (c,t) ->
        begin
          let finL = getEtiquette() in
          analyse_code_expression c
          ^ jumpif 0 finL
          ^ analyse_code_bloc_loop t l
          ^ finL ^ "\n"
        end
    | AstPlacement.TantQue (c,b) ->
      begin
        let whileL = getEtiquette() in
        let endwhileL = getEtiquette() in
        whileL ^ "\n"
        ^analyse_code_expression c
        ^ jumpif 0 endwhileL
        ^ analyse_code_bloc_loop b l
        ^ jump whileL
        ^ endwhileL ^ "\n"
      end
    | AstPlacement.Retour (e,tr, tp) -> 
      let ne = (analyse_code_expression e) in
      ne ^ return tr tp
    | AstPlacement.Empty -> ""
    | AstPlacement.Loop (b) -> 
      (* une loop dans une loop, le même traitement*)
      begin 
        let loopL = getEtiquette() in
        let finLoop = getEtiquette() in
        loopL ^ "\n" ^
        analyse_code_bloc_loop b (("",loopL,finLoop)::l) ^
        jump loopL ^
        finLoop ^ "\n"
      end
    | AstPlacement.Break -> finir "" l
    | AstPlacement.Continue -> continuer "" l
    | AstPlacement.LoopNom (n,b) ->
      (* le même traitement *)
      begin
        let loopL = getEtiquette() in
        let finLoop = getEtiquette() in
        loopL ^ "\n" ^
        analyse_code_bloc_loop b ((n,loopL,finLoop)::l) ^
        jump loopL ^
        finLoop ^ "\n"
      end 
    | AstPlacement.BreakNom(n) -> finir n l
    | AstPlacement.ContinueNom(n) -> continuer n l

    
and finir nom ((n, _,fin)::q) = if n=nom then jump fin else finir nom q
and continuer nom ((n, debut,_)::q) = if n=nom then jump debut else finir nom q

and analyse_code_bloc_loop (li, taillevarlocales) l =
String.concat "" (List.map (analyse_code_instruction_loop l) li)
^ (pop 0 taillevarlocales)



let analyse_code_fonction (AstPlacement.Fonction(info, _, (li, _))) =
  match info_ast_to_info info with
    | InfoFun(n, _, _) ->
      n ^ "\n"
      ^ String.concat "" (List.map (analyse_code_instruction) li)
      ^ halt
    | _ -> failwith "Internal error"



let analyser (AstPlacement.Programme(fonctions, bloc)) =
  getEntete()
  ^ String.concat "" (List.map analyse_code_fonction fonctions)
  ^ "main \n"
  ^ analyse_code_bloc bloc
  ^ halt
