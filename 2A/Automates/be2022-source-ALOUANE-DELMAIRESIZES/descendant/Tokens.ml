open List

type token = 
    (* A COMPLETER *)
    | UL_PTVIRG
    | UL_ACCOUV
    | UL_ACCFER
    | UL_AFF
    | UL_IDENT of string
    | UL_NAME of string
    | UL_ENTIER of int
    | UL_FIN
    | UL_ERREUR;;

type inputStream = token list;;

(* string_of_token : token -> string *)
(* Converti un token en une chaîne de caractère*)
let string_of_token token =
     match token with
       (* A COMPLETER *)
       | UL_PTVIRG -> ";"
  	| UL_ACCOUV -> "{"
 	| UL_ACCFER -> "}"
  	| UL_AFF -> "="
  	| UL_IDENT texte -> texte
    	| UL_NAME texte -> texte
    	| UL_ENTIER entier -> string_of_int entier
       | UL_FIN -> "EOF"
       | UL_ERREUR -> "Erreur Lexicale";;

(* string_of_stream : inputStream -> string *)
(* Converti un inputStream (liste de token) en une chaîne de caractère *)
let string_of_stream stream =
  List.fold_right (fun t tq -> (string_of_token t) ^ " " ^ tq ) stream "";;


(* peekAtFirstToken : inputStream -> token *)
(* Renvoie le premier élément d'un inputStream *)
(* Erreur : si l'inputStream est vide *)
let peekAtFirstToken stream = 
  match stream with
  (* Normalement, ne doit jamais se produire sauf si la grammaire essaie de lire *)
  (* après la fin de l'inputStream. *)
  | [] -> failwith "Impossible d'acceder au premier element d'un inputStream vide"
   |t::_ -> t;;

(* advanceInStream : inputStream -> inputStream *)
(* Consomme le premier élément d'un inputStream *)
(* Erreur : si l'inputStream est vide *)
let advanceInStream stream =
  match stream with
  (* Normalement, ne doit jamais se produire sauf si la grammaire essaie de lire *)
  (* après la fin de l'inputStream. *)
  | [] -> failwith "Impossible de consommer le premier element d'un inputStream vide"
  | _::q -> q;;
