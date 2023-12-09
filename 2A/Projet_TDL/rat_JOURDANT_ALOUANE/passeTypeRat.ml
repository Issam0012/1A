

open Tds
open Ast
open Exceptions
open Type 

type t1 = Ast.AstTds.programme
type t2 = Ast.AstType.programme


(* let rec analyse_type_affectable (a) =
  match a with
  | AstTds.Deref af -> 
  begin
    let vale, t = analyse_type_affectable a in
    (AstType.Deref vale, t)
  end
  | AstTds.Ident info -> 
  begin
    match info_ast_to_info info with
    | InfoConst _ -> (AstType.Ident info, Int)
    | InfoVar (_,t,_,_) -> (AstType.Ident info, t)
    |  _ -> failwith "internal error"
  end *)
  

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
  | AstTds.Conditionnelleternaire (c,e1,e2) ->
      begin
        (* On analyse l'expression et on s'assure qu'elle est de type bool*)
        let (ne,t)= analyse_type_expression c in
        if (est_compatible t Bool) then 
          (* on analyse les 2 expressions et on s'assure qu'ils sont du même type*)
          let (b1,t1) = analyse_type_expression e1 in 
          let (b2,t2) = analyse_type_expression e2 in 
          if (est_compatible t1 t2) then (AstType.Conditionnelleternaire(ne,b1,b2), t1)
          else raise (TypeInattendu (t1, t2))
        else raise (TypeInattendu (t, Bool))
      end
  (* | AstTds.Null ->  (AstType.Null, Undefined)
  | AstTds.Affectable(aff) ->  
    let a,t = (analyse_type_affectable aff) in
    (AstType.Affectable a,t)
  | AstTds.New(t) -> (AstType.New t, t)
  | AstTds.Adresse(info) -> 
   begin
      match info_ast_to_info info with
         | InfoVar (_,t,_,_) -> (AstType.Adresse(info), t)
         |  _ -> failwith "internal error"
   end *)


    
let rec analyse_type_instruction i =
  match i with
  | AstTds.Conditionnelle (e, b1, b2) ->
      let (ne,t)= analyse_type_expression e in
        if t = Bool then AstType.Conditionnelle (ne, analyse_type_bloc b1, analyse_type_bloc b2)
        else raise (TypeInattendu (t, Bool))
  | AstTds.ConditionnelleOptionnel (e, b) ->
        begin
          (* on analyse l'expression et on s'assure qu'elle est de type bool*)
          let (ne,t)= analyse_type_expression e in
          if t = Bool then AstType.ConditionnelleOptionnel (ne, analyse_type_bloc b)
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
      let (r_expr, t_expr) = analyse_type_expression c in
      let bast = analyse_type_bloc b in
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
  (* Pas de traitement particulier dans cette étape *)
  | AstTds.Loop (b) -> AstType.Loop(analyse_type_bloc b)
  | AstTds.Break -> AstType.Break
  | AstTds.Continue -> AstType.Continue
  | AstTds.LoopNom (n,b) -> AstType.LoopNom(n, analyse_type_bloc b)
  | AstTds.BreakNom(n) -> AstType.BreakNom(n)
  | AstTds.ContinueNom(n) -> AstType.ContinueNom(n)
  (* | AstTds.AffectationPointeur(a, e) ->  
    begin 
        let (ne,te) = analyse_type_expression e in
        let (na,ta) = analyse_type_affectable a in
        if (te == ta) then AstType.AffectationPointeur(na,ne)
        else raise (TypeInattendu (te, ta))
    end  *)
    
  
and analyse_type_bloc li =
   let nli = List.map (analyse_type_instruction) li in
   nli


   
let analyse_type_fonction (AstTds.Fonction(typ,info,lp,li))  =
begin
let (lt,lb)= List.fold_right (fun (t, i) (acc1, acc2) -> modifier_type_variable t i; (t::acc1, i::acc2)) lp ([], []) in
modifier_type_fonction typ lt info;
AstType.Fonction(info,lb,analyse_type_bloc li )
end



let analyser (AstTds.Programme (fonctions,prog)) =
  let nf = List.map (analyse_type_fonction) fonctions in
  let nb = analyse_type_bloc prog in
  AstType.Programme (nf,nb)
