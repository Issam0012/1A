(*  Module qui permet la décomposition et la recomposition de données **)
(*  Passage du type t1 vers une liste d'éléments de type t2 (décompose) **)
(*  et inversement (recopose).**)
module type DecomposeRecompose =
sig
  (*  Type de la donnée **)
  type mot
  (*  Type des symboles de l'alphabet de t1 **)
  type symbole

  val decompose : mot -> symbole list
  val recompose : symbole list -> mot
end

module DRString:DecomposeRecompose with type mot = string and type symbole = char =
struct
  type mot = string
  type symbole = char
  let decompose s = 
    let rec decompose_aux i accu =
      if i < 0 then accu
      else decompose_aux (i-1) (s.[i]::accu)
    in decompose_aux (String.length s - 1) []

  let recompose lc = List.fold_right (fun t q -> String.make 1 t ^ q) lc ""
end

module DRSNat:DecomposeRecompose with type mot = int and type symbole = int =
struct
  type mot = int
  type symbole = int
  let decompose s = 
    let rec decompose_aux nombre accu =
      if nombre = 0 then accu
      else let r=(nombre mod 10) in decompose_aux ((nombre-r) / 10) (r::accu)
    in decompose_aux s []

  let recompose lc = List.fold_left (fun q t -> t + q*10) 0 lc
end

let%test _ = DRSNat.decompose 248 = [2;4;8]
let%test _ = DRSNat.recompose [2;4;8] = 248