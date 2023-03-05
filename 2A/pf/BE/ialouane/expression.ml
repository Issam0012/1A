(* Exercice 3 *)
module type Expression = sig
  (* Type pour représenter les expressions *)
  type exp


  (* eval : exp -> int*)
  (* évaluer une expression mathématique *)
  (* Paramètre expression : (exp) l'expression qu'on veut évaluer sous forme d'arbre binaire ou arbre n-aire *)
  (* Résultat : (int) le résultat de l'expression mathématiques *)
  val eval : exp -> int
end

(* Exercice 4 *)

(* TO DO avec l'aide du fichier  expressionArbreBinaire.txt *)
  (* Type pour représenter les expressions binaires *)
module ExpAvecArbreBinaire : Expression =
struct
  type op = Moins | Plus | Mult | Div
  type exp = Binaire of exp * op * exp | Entier of int

  (* eval *)
  let rec eval arbre = match arbre with
  | Entier c -> c
  | Binaire (a,b,c) -> match b with
                        | Moins -> (eval a) - (eval c)
                        | Plus -> (eval a) + (eval c)
                        | Mult -> (eval a) * (eval c)
                        | Div -> (eval a) / (eval c)

  (* Tests : TO DO *)
  let%test _ = eval (Entier 2) = 2
  let%test _ = eval (Binaire ((Entier 3),Plus,(Entier 4))) = 7
  let%test _ = eval (Binaire (Binaire ((Entier 3),Plus,(Entier 4)), Moins, Entier 12)) = -5
  let%test _ = eval (Binaire ((Entier 5),Mult,(Entier 4))) = 20
  let%test _ = eval (Binaire ((Entier 64),Div,(Entier 8))) = 8
end


(* Exercice 5 *)
(* TO DO avec l'aide du fichier  expressionArbreNaire.txt *)

module ExpAvecArbreNaire : Expression =
struct
  (* Linéarisation des opérateurs binaire associatif gauche et droit *)
  type op = Moins | Plus | Mult | Div
  type exp = Naire of op * exp list | Valeur of int
  
  (* bienformee : exp -> bool *)
  (* Vérifie qu'un arbre n-aire représente bien une expression n-aire *)
  (* c'est-à-dire que les opérateurs d'addition et multiplication ont au moins deux opérandes *)
  (* et que les opérateurs de division et soustraction ont exactement deux opérandes.*)
  (* Paramètre : l'arbre n-aire dont ont veut vérifier si il correspond à une expression *)
  let bienformee arbre = 
    let compter arbre operande =
      match arbre with
      | Valeur _ -> 0
      | Naire (a,liste) -> if (a = operande) then (List.length liste) else 0
    in (let i = compter arbre Plus in i >= 2 || i = 0) && 
    (let i = compter arbre Moins in i = 2 || i = 0) && 
    (let i = compter arbre Div in i = 2 || i = 0) && 
    (let i = compter arbre Mult in i >= 2 || i = 0)

  let en1 = Naire (Plus, [ Valeur 3; Valeur 4; Valeur 12 ])
  let en2 = Naire (Moins, [ en1; Valeur 5 ])
  let en3 = Naire (Mult, [ en1; en2; en1 ])
  let en4 = Naire (Div, [ en3; Valeur 2 ])
  let en1err = Naire (Plus, [ Valeur 3 ])
  let en2err = Naire (Moins, [ en1; Valeur 5; Valeur 4 ])
  let en3err = Naire (Mult, [ en1 ])
  let en4err = Naire (Div, [ en3; Valeur 2; Valeur 3 ])

  let%test _ = bienformee en1
  let%test _ = bienformee en2
  let%test _ = bienformee en3
  let%test _ = bienformee en4
  let%test _ = not (bienformee en1err)
  let%test _ = not (bienformee en2err)
  let%test _ = not (bienformee en3err)
  let%test _ = not (bienformee en4err)

  (* eval : exp-> int *)
  (* Calcule la valeur d'une expression n-aire *)
  (* Paramètre : l'expression dont on veut calculer la valeur *)
  (* Précondition : l'expression est bien formée *)
  (* Résultat : la valeur de l'expression *)
  let rec eval_bienformee arbre = match arbre with
  | Valeur c -> c
  | Naire (a,liste) -> match a with
                      (*J'ai utilisé des fold right partout pour avoir du matching exhaustif même si je sais que je n'aurai que 2 éléments dans la soustraction et la division*)
                      | Moins -> List.fold_right (fun t q -> (eval_bienformee t) - q) liste 0 
                      | Plus -> List.fold_right (fun t q -> (eval_bienformee t) + q) liste 0 
                      | Mult -> List.fold_right (fun t q -> (eval_bienformee t) * q) liste 1
                      | Div -> List.fold_right (fun t q -> (eval_bienformee t) / q) liste 1

  let%test _ = eval_bienformee en1 = 19
  let%test _ = eval_bienformee en2 = 14
  let%test _ = eval_bienformee en3 = 5054
  let%test _ = eval_bienformee en4 = 2527

  (* Définition de l'exception Malformee *)
  (* TO DO *)
    exception Malformee

  (* eval : exp-> int *)
  (* Calcule la valeur d'une expression n-aire *)
  (* Paramètre : l'expression dont on veut calculer la valeur *)
  (* Résultat : la valeur de l'expression *)
  (* Exception  Malformee si le paramètre est mal formé *)
  let eval arbre  = if (bienformee arbre) then (eval_bienformee arbre) else raise Malformee

  let%test _ = eval en1 = 19
  let%test _ = eval en2 = 14
  let%test _ = eval en3 = 5054
  let%test _ = eval en4 = 2527

  let%test _ =
    try
      let _ = eval en1err in
      false
    with Malformee -> true

  let%test _ =
    try
      let _ = eval en2err in
      false
    with Malformee -> true

  let%test _ =
    try
      let _ = eval en3err in
      false
    with Malformee -> true

  let%test _ =
    try
      let _ = eval en4err in
      false
    with Malformee -> true

end
