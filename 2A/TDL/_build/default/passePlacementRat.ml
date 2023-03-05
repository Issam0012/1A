(* Module de la passe de gestion des identifiants *)
(* doit être conforme à l'interface Passe *)
open Tds
open Ast
open Type 

type t1 = Ast.AstType.programme
type t2 = Ast.AstPlacement.programme

(* analyse_tds_instruction : tds -> info_ast option -> AstSyntax.instruction -> AstTds.instruction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si l'instruction i est dans le bloc principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est l'instruction i sinon *)
(* Paramètre i : l'instruction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme l'instruction
en une instruction de type AstTds.instruction *)
(* Erreur si mauvaise utilisation des identifiants *)
let rec analyse_placement_instruction i depl reg =
  match i with
  | AstType.Declaration (info, e) ->
    begin
    match info_ast_to_info info with
    | InfoVar(_,t,_,_) -> modifier_adresse_variable depl reg info ;
      (AstPlacement.Declaration (info, e), getTaille t)
    | _ -> failwith "internal error" 
    end
  | AstType.TantQue (c,b) ->
    let nb = analyse_placement_bloc b depl reg in
    (AstPlacement.TantQue(c,nb), 0)
  | AstType.Retour (e,ia) ->
    begin
      match info_ast_to_info ia with
      | InfoFun(_,t,lp) -> (AstPlacement.Retour(e, getTaille t, somme_liste (List.map getTaille lp)),0)
      | _ -> failwith "internal error" 
    end
  | AstType.Affectation (n,e) -> (AstPlacement.Affectation (n, e), 0)
  | AstType.AffichageInt e -> (AstPlacement.AffichageInt e, 0)
  | AstType.AffichageRat e -> (AstPlacement.AffichageRat e, 0)
  | AstType.AffichageBool e -> (AstPlacement.AffichageBool e, 0)
  | AstType.Conditionnelle (c,b1,b2) -> 
    let bp1 = (analyse_placement_bloc b1 depl reg) in
    let bp2 = (analyse_placement_bloc b2 depl reg) in
    (AstPlacement.Conditionnelle (c, bp1, bp2), 0)
  | AstType.Empty -> (AstPlacement.Empty, 0)
    

  and somme_liste l = List.fold_right (fun t q -> t+q) l 0


(* analyse_tds_bloc : tds -> info_ast option -> AstSyntax.bloc -> AstTds.bloc *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre oia : None si le bloc li est dans le programme principal,
                   Some ia où ia est l'information associée à la fonction dans laquelle est le bloc li sinon *)
(* Paramètre li : liste d'instructions à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le bloc en un bloc de type AstTds.bloc *)
(* Erreur si mauvaise utilisation des identifiants *)
and analyse_placement_bloc li depl reg =
   match li with
   | [] -> ([], 0)
   | i :: l -> let (ni, taille_i) = (analyse_placement_instruction i depl reg) in
              let (nli, tli) = analyse_placement_bloc l (depl+ taille_i) reg in
              (ni::nli, taille_i+tli)


(* analyse_tds_fonction : tds -> AstSyntax.fonction -> AstTds.fonction *)
(* Paramètre tds : la table des symboles courante *)
(* Paramètre : la fonction à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme la fonction
en une fonction de type AstTds.fonction *)
(* Erreur si mauvaise utilisation des identifiants *)
let getTailleListe l = 
  List.fold_right (fun info q -> match info_ast_to_info info with
                                                | InfoVar (_,t,_,_) -> q + getTaille t
                                                | _ -> failwith "Internal error" ) l 0
 let analyse_placement_fonction (AstType.Fonction(i,li,b)) =
  begin
    let rec analyse_parametres params n =
      match params with
        | [] -> ()
        | t::q ->
          begin
            match info_ast_to_info t with
              | InfoVar(_, typ, _, _) ->
                modifier_adresse_variable (n - getTaille typ) "LB" t;
                analyse_parametres q (n - getTaille typ)
              | _ -> failwith "Internal error" 
          end
    in
    analyse_parametres (List.rev li) 0;
    let (v, w) = analyse_placement_bloc b 3 "LB" in
      begin
      match info_ast_to_info i with
        | InfoFun (_,t,_) ->
           (AstPlacement.Fonction(i,li, (v,w)), w + (getTaille t) + getTailleListe li)
        | _ -> failwith "Internal error"
      end
  end

(* analyser : AstSyntax.programme -> AstTds.programme *)
(* Paramètre : le programme à analyser *)
(* Vérifie la bonne utilisation des identifiants et tranforme le programme
en un programme de type AstTds.programme *)
(* Erreur si mauvaise utilisation des identifiants *)
let analyser (AstType.Programme (fonctions,prog)) =
  let (nf,_) = List.split (List.map (analyse_placement_fonction) fonctions) in
  let nb = analyse_placement_bloc prog 0 "SB" in
  AstPlacement.Programme (nf,nb)