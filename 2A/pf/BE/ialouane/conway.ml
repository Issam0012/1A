(* Exercice 1*)

(* max : int list -> int  *)
(* Paramètre : liste dont on cherche le maximum *)
(* Précondition : la liste n'est pas vide *)
(* Résultat :  l'élément le plus grand de la liste *)
let max liste = match liste with
| [] -> failwith "" (* On sera jamais ici car la liste n'est pas vide mais juste pour le matching exhaustive*) 
| t::_ -> List.fold_right (fun a q -> if a>q then a else q) liste t

(* TO DO : copier / coller les tests depuis conwayTests.txt *)
let%test _ = max [ 1 ] = 1
let%test _ = max [ 1; 2 ] = 2
let%test _ = max [ 2; 1 ] = 2
let%test _ = max [ 1; 2; 3; 4; 3; 2; 1 ] = 4

(* max_max : int list list -> int  *)
(* Paramètre : la liste de listes dont on cherche le maximum *)
(* Précondition : il y a au moins un élement dans une des listes *)
(* Résultat :  l'élément le plus grand de la liste *)
let max_max liste = max (List.flatten liste)

(* TO DO : copier / coller les tests depuis conwayTests.txt *)
let%test _ = max_max [ [ 1 ] ] = 1
let%test _ = max_max [ [ 1 ]; [ 2 ] ] = 2
let%test _ = max_max [ [ 2 ]; [ 2 ]; [ 1; 1; 2; 1; 2 ] ] = 2
let%test _ = max_max [ [ 2 ]; [ 1 ] ] = 2
let%test _ = max_max [ [ 1; 1; 2; 1 ]; [ 1; 2; 2 ] ] = 2

let%test _ =
  max_max [ [ 1; 1; 1 ]; [ 2; 1; 2 ]; [ 3; 2; 1; 4; 2 ]; [ 1; 3; 2 ] ] = 4


(* Exercice 2*)
(* compteur : int -> int list -> int -> int list *)
(* Compte le nombre d'occurences d'un élément dès sa première apparition *)
(* Paramètre n : (int) le nombre dont on veut calculer le nombre d'occurences*)
(* Paramètre liste : (int list) la liste cible*)
(* Paramètre acc : (int) l'accumulateur de nombre d'occurences*)
(* Retour : (int list) une liste du nombre d'occurences d'un élément dès sa première apparition avec l'élément n *)
let rec compteur n liste acc = match liste with
  | [] -> [acc;n]
  | t::q -> if (t=n) then compteur n q (acc+1) else 
    (if acc= 0 then compteur n q acc else [acc;n])

(* suivant_aux : int list -> int -> int list *)
(* calcule le terme suivant dans une suite de conway en ayant le premier élément de la liste original *)
(* Paramètre liste : (int list) la liste cible*)
(* Paramètre e : (int) l'élément du début de la liste*)
(* Retour : (int list) le terme suivant dans une suite de conway *)
let rec suivant_aux liste e = match liste with
| [] -> []
| t::q -> if t!=e then (compteur t liste 0)@(suivant_aux q t)
          else suivant_aux q e

(* suivant : int list -> int list *)
(* Calcule le terme suivant dans une suite de Conway *)
(* Paramètre : le terme dont on cherche le suivant *)
(* Précondition : paramètre différent de la liste vide *)
(* Retour : le terme suivant *)

let suivant liste = match liste with
| [] -> []
| t::q -> (compteur t liste 0) @ (suivant_aux q t)
  

(* TO DO : copier / coller les tests depuis conwayTests.txt *)
let%test _ = suivant [ 1 ] = [ 1; 1 ]
let%test _ = suivant [ 2 ] = [ 1; 2 ]
let%test _ = suivant [ 3 ] = [ 1; 3 ]
let%test _ = suivant [ 1; 1 ] = [ 2; 1 ]
let%test _ = suivant [ 1; 2 ] = [ 1; 1; 1; 2 ]
let%test _ = suivant [ 1; 1; 1; 1; 3; 3; 4 ] = [ 4; 1; 2; 3; 1; 4 ]
let%test _ = suivant [ 1; 1; 1; 3; 3; 4 ] = [ 3; 1; 2; 3; 1; 4 ]
let%test _ = suivant [ 1; 3; 3; 4 ] = [ 1; 1; 2; 3; 1; 4 ]
let%test _ = suivant [3;3] = [2;3]

(* suite : int -> int list -> int list list *)
(* Calcule la suite de Conway *)
(* Paramètre taille : le nombre de termes de la suite que l'on veut calculer *)
(* Paramètre depart : le terme de départ de la suite de Conway *)
(* Résultat : la suite de Conway *)
let suite taille depart = 
  let rec suite_aux j max_iter acc e =
    if j>=max_iter then acc
    else let f = (suivant e) in suite_aux (j+1) taille (acc@[f]) (f)
  in suite_aux 1 taille [depart] depart

(* TO DO : copier / coller les tests depuis conwayTests.txt *)

let%test _ = suite 1 [ 1 ] = [ [ 1 ] ]
let%test _ = suite 2 [ 1 ] = [ [ 1 ]; [ 1; 1 ] ]
let%test _ = suite 3 [ 1 ] = [ [ 1 ]; [ 1; 1 ]; [ 2; 1 ] ]
let%test _ = suite 4 [ 1 ] = [ [ 1 ]; [ 1; 1 ]; [ 2; 1 ]; [ 1; 2; 1; 1 ] ]

let%test _ =
  suite 5 [ 1 ]
  = [ [ 1 ]; [ 1; 1 ]; [ 2; 1 ]; [ 1; 2; 1; 1 ]; [ 1; 1; 1; 2; 2; 1 ] ]

let%test _ =
  suite 10 [ 1 ]
  = [
      [ 1 ];
      [ 1; 1 ];
      [ 2; 1 ];
      [ 1; 2; 1; 1 ];
      [ 1; 1; 1; 2; 2; 1 ];
      [ 3; 1; 2; 2; 1; 1 ];
      [ 1; 3; 1; 1; 2; 2; 2; 1 ];
      [ 1; 1; 1; 3; 2; 1; 3; 2; 1; 1 ];
      [ 3; 1; 1; 3; 1; 2; 1; 1; 1; 3; 1; 2; 2; 1 ];
      [ 1; 3; 2; 1; 1; 3; 1; 1; 1; 2; 3; 1; 1; 3; 1; 1; 2; 2; 1; 1 ];
    ]

let%test _ =
  suite 10 [ 3; 3 ]
  = [
      [ 3; 3 ];
      [ 2; 3 ];
      [ 1; 2; 1; 3 ];
      [ 1; 1; 1; 2; 1; 1; 1; 3 ];
      [ 3; 1; 1; 2; 3; 1; 1; 3 ];
      [ 1; 3; 2; 1; 1; 2; 1; 3; 2; 1; 1; 3 ];
      [ 1; 1; 1; 3; 1; 2; 2; 1; 1; 2; 1; 1; 1; 3; 1; 2; 2; 1; 1; 3 ];
      [ 3; 1; 1; 3; 1; 1; 2; 2; 2; 1; 1; 2; 3; 1; 1; 3; 1; 1; 2; 2; 2; 1; 1; 3 ];
      [ 1; 3; 2; 1; 1; 3; 2; 1; 3; 2; 2; 1; 1; 2; 1; 3; 2; 1; 1; 3; 2; 1; 3; 2; 2; 1; 1; 3; ];
      [ 1; 1; 1; 3; 1; 2; 2; 1; 1; 3; 1; 2; 1; 1; 1; 3; 2; 2; 2; 1; 1; 2; 1; 1; 1; 3; 1; 2; 2; 1; 1; 3; 1; 2; 1; 1; 1; 3; 2; 2; 2; 1; 1; 3; ];
    ]

(* Tests de la conjecture *)
(* "Aucun terme de la suite, démarant à 1, ne comporte un chiffre supérieur à 3" *)
(* TO DO *)
(* Pour ce test j'ai écrit une fonction tester (voir contrat), qui nous permet de tester l'existance d'un chiffre supérieur strictement à 3
   dans chaque terme de la suite de Conway en considérant un seul paramètre, qui est le nombre d'itération maximal*)

(* tester : int -> bool *)
(* tester l'existance d'un chiffre supérieur strictement à 3 dans chaque terme de la suite de Conway *)
(* Paramètre maxiter : (int) le nombre de termes de la suite que l'on veut calculer (le nombre maximum d'itération) *)
(* Résultat : (bool) un boolean qui indique l'existance d'un chiffre supérieur strictement à 3 (true s'il existe et false s'il n'existe pas ) *)
let tester maxiter =
  let rec tester_aux i acc e=
    if i> maxiter then acc
    else tester_aux (i+1) (acc || List.fold_right (fun t q -> (t > 3) || q) e false) (suivant e)
  in tester_aux 1 false [1]

let%test _ = not (tester 10)
let%test _ = not (tester 15)
let%test _ = not (tester 20)
let%test _ = not (tester 45)
(*let%test _ = not (tester 46)*) (*Stack Overflow*)

(* Remarque : TO DO *)
(*Tester à la main n'est pas une manière de prouver une théorème mathématiques
   car notre test est limité, au bout d'un certain paramètre maxiter on aura un Stack Overflow (46 dans le cas de mon machine),
   on ne peut pas aller ver plus l'infini avec nos calculs, donc je pense que cette manière de test n'est pas très vigilante
   *)