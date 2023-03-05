(* Module de la passe de gestion des identifiants *)
(* doit être conforme à l'interface Passe *)
open Tds
open Ast
open Exceptions
open Type 

type t1 = Ast.AstTds.programme
type t2 = Ast.AstType.programme

(* analyse_tds_expression : tds -> AstSyntax.expression -> AstTds.expression *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre e : l'expression à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'expression
en une expression de type AstTds.expression *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_type_expression e =
  match e with
  | AstTds.Ident info ->
  begin
    match info_ast_to_info info with
    | InfoConst (_,x) -> (AstType.Entier x, Int)
    | InfoVar (_,t,_,_) -> (AstType.Ident info, t)
    |  _ -> failwith "internal error"
  end
  | AstTds.Booleen a -> (AstType.Booleen a, Bool)
  | AstTds.Entier c -> (AstType.Entier c, Int)
  | AstTds.Unaire (u,e) -> 
    let (ne,t) = analyse_type_expression e in
                                  begin
                                    match (u, t) with
                                    | (Numerateur, Rat) -> (AstType.Unaire(Numerateur, ne), Int)
                                    | (Denominateur, Rat) -> (AstType.Unaire(Denominateur, ne), Int)
                                    | _ -> raise (TypeInattendu (t, Rat))
                                  end
  | AstTds.Binaire (b,e1,e2) -> let (ne1,t1) = analyse_type_expression e1 in
                                  let (ne2,t2) = analyse_type_expression e2 in
                                  begin
                                    match (b, t1, t2) with
                                    | (Fraction, Int, Int) -> (AstType.Binaire(Fraction, ne1, ne2), Rat)
                                    | (Plus, Int, Int) -> (AstType.Binaire(PlusInt, ne1, ne2), Int)
                                    | (Mult, Int, Int) -> (AstType.Binaire(MultInt, ne1, ne2), Int)
                                    | (Equ, Int, Int) -> (AstType.Binaire(EquInt, ne1, ne2), Bool)
                                    | (Inf, Int, Int) -> (AstType.Binaire(Inf, ne1, ne2), Bool)
                                    | (Plus, Rat, Rat) -> (AstType.Binaire(PlusRat, ne1, ne2), Rat)
                                    | (Mult, Rat, Rat) -> (AstType.Binaire(MultRat, ne1, ne2), Rat)
                                    | (Equ, Bool, Bool) -> (AstType.Binaire(EquBool, ne1, ne2), Bool)
                                    (*Cas d'Erreurs*)
                                    | _ -> raise (TypeBinaireInattendu (b, t1, t2))
                                  end
  | AstTds.AppelFonction (info, l) ->
    begin
      let l1 = List.map analyse_type_expression l in
        let (le, lt) = List.split l1 in
        begin
          match info_ast_to_info info with
          | InfoFun (_, tr, ltp) ->
            begin
              if lt = ltp then (AstType.AppelFonction (info,le), tr)
              else raise (TypesParametresInattendus (lt, ltp))
            end
          |  _ -> failwith "internal error"
        end
    end


(* analyse_tds_instruction : tds -> info_ast option -> AstSyntax.instruction -> AstTds.instruction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si l'instruction i est dans le bloc principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est l'instruction i sinon *)
(* Paramètre i : l'instruction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'instruction
en une instruction de type AstTds.instruction *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_type_instruction i =
  match i with
  | AstTds.Conditionnelle (e, b1, b2) ->
      begin
        let (ne,t)= analyse_type_expression e in
        if t = Bool then AstType.Conditionnelle (ne, analyse_type_bloc b1, analyse_type_bloc b2)
        else raise (TypeInattendu (t, Bool))
      end
  | AstTds.Declaration (t, info, e) ->
      begin
        let (r_expr, t_expr) = analyse_type_expression e in 
          if est_compatible t t_expr then
            (modifier_type_variable t_expr info;
            AstType.Declaration(info, r_expr))
          else raise (TypeInattendu (t_expr, t))
        end
  | AstTds.Affichage e ->
      begin
        match analyse_type_expression e with
        | (x,Int) -> AstType.AffichageInt x
        | (x,Rat) -> AstType.AffichageRat x
        | (x,Bool) -> AstType.AffichageBool x
        | _ -> failwith "Internal Error"
      end
  | AstTds.Affectation (info, e) ->
      let (ne,t) = analyse_type_expression e in
      begin
       match info_ast_to_info info with
        | InfoVar (_, t2, _, _) -> if t2=t then AstType.Affectation(info,ne)
        else raise (TypeInattendu (t, t2))
        | _ -> failwith "Internal Error"
      end
  | AstTds.TantQue (c,b) ->
    begin
      (* Analyse de la condition *)
      let (r_expr, t_expr) = analyse_type_expression c in
      (* Analyse du bloc *)
      let bast = analyse_type_bloc b in
      (* Renvoie la nouvelle structure de la boucle *)
      match t_expr with
      | Bool -> AstType.TantQue (r_expr, bast)
      | _ -> raise (TypeInattendu (t_expr, Bool))
    end
  | AstTds.Retour (e,info) ->
      begin
        let (r_expr, t_expr) = analyse_type_expression e in
        match info_ast_to_info info with
        | InfoFun (_, t, _) -> if t = t_expr then AstType.Retour (r_expr,info)
        else raise (TypeInattendu (t_expr, t))
        | _ -> failwith "Internal Error"
      end
  | AstTds.Empty -> AstType.Empty


(* analyse_tds_bloc : tds -> info_ast option -> AstSyntax.bloc -> AstTds.bloc *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si le bloc li est dans le programme principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est le bloc li sinon *)
(* Paramètre li : liste d'instructions à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le bloc en un bloc de type AstTds.bloc *)
(* Erreur si mauvaise utilisation des identifiants *)
and analyse_type_bloc li =
   let nli = List.map (analyse_type_instruction) li in
   nli


(* analyse_tds_fonction : tds -> AstSyntax.fonction -> AstTds.fonction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre : la fonction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme la fonction
en une fonction de type AstTds.fonction *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyse_type_fonction (AstTds.Fonction(typ,info,lp,li))  =
begin
let (lt,lb)= List.fold_right (fun (t, i) (acc1, acc2) -> modifier_type_variable t i; (t::acc1, i::acc2)) lp ([], []) in
modifier_type_fonction typ lt info;
AstType.Fonction(info,lb,analyse_type_bloc li )
end


(* analyser : AstSyntax.programme -> AstTds.programme *)
(* Paramètre : le programme à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le programme
en un programme de type AstTds.programme *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyser (AstTds.Programme (fonctions,prog)) =
  let nf = List.map (analyse_type_fonction) fonctions in
  let nb = analyse_type_bloc prog in
  AstType.Programme (nf,nb)
