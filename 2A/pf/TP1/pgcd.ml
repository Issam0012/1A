(*  Exercice à rendre **)
(* Nom : ALOUANE *)
(* Prénom : Issam *)
(* Groupe : M1 *)

(*  
   coeff_directeur : int -> int -> int
   Calcule le plus grand diviseur commun de deux entiers relatifs
   Parametre a : int, le premier entier relatif
   Parametre b : int, le second entier relatif
   Resultat : int, le pgcd de a et b
   postcondition : (pgcd a b) > 0
*)
let pgcd a b = 
  if (a=0) then (abs b) else if (b=0) then (abs a) else
  let rec pgcd_pos x y =
  if (x=y) then x else if (x>y) then (pgcd_pos (x-y) y) else (pgcd_pos x (y-x))
in (pgcd_pos (abs a) (abs b));;

(* tests unitaires *)
let%test _ = pgcd 4 2 = 2
let%test _ = pgcd 24 18 = 6
let%test _ = pgcd 0 9 = 9
let%test _ = pgcd 7 0 = 7
let%test _ = pgcd (-15) 9 = 3
let%test _ = pgcd 4 (-18) = 2
let%test _ = pgcd (-12) (-16) = 4

(* Réponse à la question :
   Le seul cas que l'algorithme original ne prend pas en compte est si l'un des deux entiers est null 
   alors la précondition est que les deux entiers soient non nulls, ce qu'on peut résoudre par
   une conditionnel, car si l'un des entiers est null, l'autre sera automatiquement le pgcd*)