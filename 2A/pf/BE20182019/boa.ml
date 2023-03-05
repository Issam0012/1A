
module type Regle =
sig
  type tid = int
  type td

  (*construire une règle*)
  val id : tid
  
  (*appliquer une règle*)
  val appliquer : td -> td list
end

module Regle1 : Regle with type td=char list =
struct
  type tid = int
  type td = char list
  let id = 1
  let rec appliquer terme = match terme with | [] -> [[]]
    | t::q -> if t = 'O' && q=[] then [['A']] else [[t] @ List.flatten (appliquer q)]
end

module Regle2 : Regle with type td=char list =
struct
  type tid = int
  type td = char list
  let id = 2
  let appliquer terme = match terme with | [] -> [[]]
  | t::q -> if t = 'B' then [terme@q] else [terme]
end

module Regle3 : Regle with type td=char list =
struct
  type tid = int
  type td = char list
  let id = 3
  let rec appliquer terma = 
    let rec appliquer_aux terme acc =
    match terme with | [] -> acc
  | [_] -> [terme]
  | [_;_] -> [terme]
  | a::b::c::q -> if ([a;b;c] = ['O';'O';'O'] || [a;b;c] = ['A';'O';'A']) then [['A']@List.flatten (appliquer_aux q acc)]@acc else [[a]@List.flatten (appliquer_aux q acc)]
    in appliquer_aux terma []
end

module Regle4 : Regle with type td=char list =
struct
  type tid = int
  type td = char list
  let id = 4
  let appliquer terma = 
      let rec appliquer_aux terme acc =
      match terme with | [] -> acc
    | [_] -> [terme]
    | a::b::q -> if ([a;b] = ['A';'A']) then [q] else [[a]@List.flatten (appliquer_aux q acc)]
      in appliquer_aux terma []
end

module type ArbreReecriture =
sig
  type tid = int
  type td
  type arbre_reecriture = Noeud of td * (tid * arbre_reecriture) list

  val creer_noeud : td -> (tid * arbre_reecriture) list -> arbre_reecriture

  val racine : arbre_reecriture -> td
  val fils : tid -> arbre_reecriture -> arbre_reecriture

  val appartient : td -> arbre_reecriture -> bool
end

module ArbreReecritureBOA : ArbreReecriture with type td = char list =
struct
  type tid = int
  type td = char list
  type arbre_reecriture = Noeud of td * (tid * arbre_reecriture) list

  let creer_noeud terme acc = Noeud(terme,acc)
  let racine arbre = let Noeud(liste, _)=arbre in liste
  let fils i arbre = failwith "" 
  let appartient l arbre = failwith ""
end