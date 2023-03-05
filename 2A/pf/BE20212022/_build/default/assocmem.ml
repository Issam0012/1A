open Util
open Mem

(* get_assoc: 'a->('a*'b)list->'b->'b
Retourner la valeur associée à la clef e dans la liste l, ou la valeur fournie def si la clef n’existe pas
Paramètres : e : ('a) la clef cible
l : ('a*'b) la liste cible
def : ('b) le cas de base (si la clef n'existe pas)
resultat : la valeur associée à e ou def si e n'existe pas dans l
 *)
let rec get_assoc e l def =
    match l with 
    | [] -> def
    | t::q -> let (a,b)=t in if a=e then b else get_assoc e q def

(* Tests unitaires : TODO *)
let%test _ = get_assoc 1 [] 0 = 0
let%test _ = get_assoc 1 [(-1,2); (1,5)] 0 = 5
let%test _ = get_assoc 1 [(1,4);(2,10);(15,255)] 0 = 4

(* set_assoc : 'a->('a*'a)list->'a->('a*'a)list
Remplacer la valeur associée à la clef e dans la liste l par x, ou ajouter le couple (e, x) si la clef n’existe pas déjà
Paramètres : e : ('a) la clef cible
l : ('a*'b) la liste cible
x : ('a) la valeur à associer à x s'elle n'existe pas
resultat : liste dont la valeur associée à e est x
 *)
let rec set_assoc e l x =
    match l with 
    | [] -> [e,x]
    | t::q -> let (a,_)=t in if (a=e||a=(-1)) then [(e,x)]@q else t::(set_assoc e q x)

(* Tests unitaires : TODO *)
let%test _ = set_assoc 1 [] 0 = [1,0] 
let%test _ = set_assoc 1 [(-1,2); (3,5)] 4 = [(1,4); (3,5)]
let%test _ = set_assoc 3 [(1,4);(2,10);(15,255)] 0 = [(1,4);(2,10);(15,255);(3,0)]


module AssocMemory : Memory =
struct
    (* Type = liste qui associe des adresses (entiers) à des valeurs (caractères) *)
    type mem_type = (int*char) list

    (* Un type qui contient la mémoire + la taille de son bus d'adressage *)
    type mem = int * mem_type

    (* Nom de l'implémentation *)
    let name = "assoc"

    (* Taille du bus d'adressage *)
    let bussize (bs, _) = bs

    (* Taille maximale de la mémoire *)
    let size (bs, _) = pow2 bs

    (* Taille de la mémoire en mémoire *)
    let allocsize (_, m) = 2*List.length m

    (* Nombre de cases utilisées *)
    let busyness (_, m) = List.fold_right (fun (_,a) acc-> if a=_0 then acc else acc+1) m 0

    (* Construire une mémoire vide *)
    let rec generate n x =
        if n <= 0 then []
        else x::(generate (n - 1) x)
    let clear bs = (bs, generate (pow2 (bs-1)) (-1,_0))

    (* Lire une valeur *)
    let read (bs, m) addr = let rslt = (get_assoc addr m _0) in if (addr > (pow2 bs)) then (raise OutOfBound) else rslt

    (* Écrire une valeur *)
    let write (bs, m) addr x = let liste = (set_assoc addr m x) in if (addr > (pow2 bs)) then (raise OutOfBound) else (bs, liste)
end
