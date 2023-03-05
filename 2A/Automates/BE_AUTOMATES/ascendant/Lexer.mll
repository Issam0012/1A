{

(* Partie recopiée dans le fichier CaML généré. *)
(* Ouverture de modules exploités dans les actions *)
(* Déclarations de types, de constantes, de fonctions, d'exceptions exploités dans les actions *)

  open Parser 
  exception LexicalError

}

(* Déclaration d'expressions régulières exploitées par la suite *)
let chiffre = ['0' - '9']
let minuscule = ['a' - 'z']
let majuscule = ['A' - 'Z']
let alphabet = minuscule | majuscule
let alphanum = alphabet | chiffre | '_'
let commentaire =
  (* Commentaire fin de ligne *)
  "#" [^'\n']*

rule lexer = parse
  | ['\n' '\t' ' ']+					{ (lexer lexbuf) }
  | commentaire						{ (lexer lexbuf) }
  | "("							{ UL_PAROUV }
  | ")"							{ UL_PARFER }
  | eof							{ UL_FIN }
  | "."                                                 { UL_PT }
  | ","                                                 { UL_VIRG }
  | "!"                                                 { UL_STP }
  | ":-"                                                { UL_DED }
  | "-"                                                 { UL_NEG }
  | "fail"                                              { UL_FAIL }
  | majuscule alphabet* as texte                        { UL_VARIABLE texte}
  | minuscule alphabet* as texte                        { UL_SYMBOLE texte}
  | _ as texte				 		{ (print_string "Erreur lexicale : ");(print_char texte);(print_newline ()); raise LexicalError }

{

}
