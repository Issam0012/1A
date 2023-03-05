
open Tds
open Ast
open Type 

type t1 = Ast.AstType.programme
type t2 = Ast.AstPlacement.programme


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


  
and analyse_placement_bloc li depl reg =
   match li with
   | [] -> ([], 0)
   | i :: l -> let (ni, taille_i) = (analyse_placement_instruction i depl reg) in
              let (nli, tli) = analyse_placement_bloc l (depl+ taille_i) reg in
              (ni::nli, taille_i+tli)


              
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
  
  
let analyser (AstType.Programme (fonctions,prog)) =
  let (nf,_) = List.split (List.map (analyse_placement_fonction) fonctions) in
  let nb = analyse_placement_bloc prog 0 "SB" in
  AstPlacement.Programme (nf,nb)