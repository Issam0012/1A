open Parser

(* Fonction d'affichage des unités lexicales et des données qu'elles contiennent *)
let printToken t =
  (print_endline
     (match t with
       | UL_PAROUV -> "("
       | UL_PARFER -> ")"
       | UL_FIN -> "EOF"
       | UL_VIRG -> ","
       | UL_PT -> "."
    | UL_STP -> "!"
    | UL_NEG -> "-"
    | UL_DED -> ":-"
    | UL_SYMBOLE haja -> haja
    | UL_VARIABLE haja -> haja
       | _ -> "Unexpected token."
));;

(* Analyse lexicale du fichier passé en paramètre de la ligne de commande *)
if (Array.length Sys.argv > 1)
then
  let lexbuf = (Lexing.from_channel (open_in Sys.argv.(1))) in
  let token = ref (Lexer.lexer lexbuf) in
  while ((!token) != UL_FIN) do
    (printToken (!token));
    (token := (Lexer.lexer lexbuf))
  done
else
  (print_endline "MainJSON fichier");;

(* Analyse lexicale, syntaxique et sémantique du fichier passé en paramètre de la ligne de commande *)
if (Array.length Sys.argv > 1)
then
  let lexbuf = (Lexing.from_channel (open_in Sys.argv.(1))) in
  (Parser.programme Lexer.lexer lexbuf)
else
  (print_endline "MainJSON fichier");;
