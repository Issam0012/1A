(****** Algorithmes combinatoires et listes ********)


(*** Code binaires de Gray ***)

(*CONTRAT
Fonction qui génère un code de Gray
Paramètre n : la taille du code
Resultat : le code sous forme de int list list
*)


let rec gray_code n = if n=0 then [[]] else let resultat = gray_code (n-1) in
  (List.fold_right (fun t q -> [0::t]@q) resultat []) @ (List.fold_left (fun q t -> [1::t]@q) [] resultat)

(* TESTS *)
let%test _ = gray_code 0 = [[]]
let%test _ = gray_code 1 = [[0]; [1]]
let%test _ = gray_code 2=  [[0; 0]; [0; 1]; [1; 1]; [1; 0]]
let%test _ = gray_code 3 = [[0; 0; 0]; [0; 0; 1]; [0; 1; 1]; [0; 1; 0]; [1; 1; 0]; [1; 1; 1]; [1; 0; 1];
 [1; 0; 0]]
 let%test _ = gray_code 4 = [[0; 0; 0; 0]; [0; 0; 0; 1]; [0; 0; 1; 1]; [0; 0; 1; 0]; [0; 1; 1; 0];
  [0; 1; 1; 1]; [0; 1; 0; 1]; [0; 1; 0; 0]; [1; 1; 0; 0]; [1; 1; 0; 1];
  [1; 1; 1; 1]; [1; 1; 1; 0]; [1; 0; 1; 0]; [1; 0; 1; 1]; [1; 0; 0; 1];
  [1; 0; 0; 0]]


(*** Combinaisons d'une liste ***)

(* CONTRAT
Fonction prend en paramètre une liste l et un entier k qui renvoie toutes les combinaisons possibles de k éléments de l (tout en respectant l'ordre des éléments dans l)
Pamaètre k : (int) le nombre des éléments dans chaque combinaison
Paramètre l : ('a list) la liste des éléments
précondition : 0 <= k <= taille(l)
Reesultat : la liste des listes avec toutes les combinaisons possibles de k éléments dans l
*)
let rec combinaison k l = 
  match (k,l) with
  | (0,_) -> [[]]
  | (_,[]) -> [[]]
  | (_,t::q) -> if k=(List.length l) then [l] else
      (combinaison k q) @ (List.fold_right (fun e lq -> [t::e]@lq) (combinaison (k-1) q) [])

(* TESTS *)
let%test _ = combinaison 0 [1] = [[]]
let%test _ = combinaison 2 [] = [[]]
let%test _ = combinaison 4 [1;2;3;4] = [[1;2;3;4]]
let%test _ = combinaison 3 [1;2;3;4] = [[2; 3; 4]; [1; 3; 4]; [1; 2; 4]; [1; 2; 3]]



(*** Permutations d'une liste ***)

(* CONTRAT
Fonction prend en paramètre un élément e et une liste l et qui insére e à toutes les possitions possibles dans l
Pamaètre e : ('a) l'élément à insérer
Paramètre l : ('a list) la liste initiale dans laquelle insérer e
Reesultat : la liste des listes avec toutes les insertions possible de e dans l
*)

let rec insertion e l = match l with
| [] -> [[e]]
| t::q -> [e::l] @ (List.fold_right (fun lt lq -> ([t]@lt)::lq) (insertion e q) [])

(* TESTS *)
let%test _ = insertion 0 [1;2] = [[0;1;2];[1;0;2];[1;2;0]]
let%test _ = insertion 0 [] = [[0]]
let%test _ = insertion 3 [1;2] = [[3;1;2];[1;3;2];[1;2;3]]
let%test _ = insertion 3 [] = [[3]]
let%test _ = insertion 5 [12;54;0;3;78] =
[[5; 12; 54; 0; 3; 78]; [12; 5; 54; 0; 3; 78]; [12; 54; 5; 0; 3; 78];
 [12; 54; 0; 5; 3; 78]; [12; 54; 0; 3; 5; 78]; [12; 54; 0; 3; 78; 5]]
 let%test _ = insertion 'x' ['a';'b';'c']=
 [['x'; 'a'; 'b'; 'c']; ['a'; 'x'; 'b'; 'c']; ['a'; 'b'; 'x'; 'c'];
  ['a'; 'b'; 'c'; 'x']]


(* CONTRAT
Fonction qui renvoie la liste des permutations d'une liste
Paramètre l : une liste
Résultat : la liste des permutatiions de l (toutes différentes si les élements de l sont différents deux à deux 
*)

let rec permutations l = match l with
| [] -> [[]]
| t::q -> List.fold_right (fun lt lq ->(insertion t lt)@lq) (permutations q) []


(* TESTS *)

let l1 = permutations [1;2;3]
let%test _ = List.length l1 = 6
let%test _ = List.mem [1; 2; 3] l1 
let%test _ = List.mem [2; 1; 3] l1 
let%test _ = List.mem [2; 3; 1] l1 
let%test _ = List.mem [1; 3; 2] l1 
let%test _ = List.mem [3; 1; 2] l1 
let%test _ = List.mem [3; 2; 1] l1 
let%test _ = permutations [] =[[]]
let l2 = permutations ['a';'b']
let%test _ = List.length l2 = 2
let%test _ = List.mem ['a';'b'] l2 
let%test _ = List.mem ['b';'a'] l2 



(*** Partition d'un entier ***)

(* partition int -> int list
Fonction qui calcule toutes les partitions possibles d'un entier n
Paramètre n : un entier dont on veut calculer les partitions
Préconditions : n >0
Retour : les partitions de n
*)
  
let partition n =
  let rec partitions_aux m t =
    if      t > m then []
    else if t = m then [[t]]
    else (List.fold_right (fun lt lq -> [t::lt]@lq) (partitions_aux (m-t) t) []) @ (partitions_aux m (t+1))
  in partitions_aux n 1 


(* TEST *)
let%test _ = partition 1 = [[1]]
let%test _ = partition 2 = [[1;1];[2]]
let%test _ = partition 3 = [[1; 1; 1]; [1; 2]; [3]]
let%test _ = partition 4 = [[1; 1; 1; 1]; [1; 1; 2]; [1; 3]; [2; 2]; [4]]

