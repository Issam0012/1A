open Tokens

(* Type du résultat d'une analyse syntaxique *)
type parseResult =
  | Success of inputStream
  | Failure
;;

(* accept : token -> inputStream -> parseResult *)
(* Vérifie que le premier token du flux d'entrée est bien le token attendu *)
(* et avance dans l'analyse si c'est le cas *)
let accept expected stream =
  match (peekAtFirstToken stream) with
    | token when (token = expected) ->
      (Success (advanceInStream stream))
    | _ -> Failure
;;

let acceptSymbole stream =
  match (peekAtFirstToken stream) with
    | (UL_SYMBOLE _) -> (print_endline (("accept symbole")));(Success (advanceInStream stream))
    | _ -> Failure
    
let acceptVariable stream =
match (peekAtFirstToken stream) with
| (UL_VARIABLE _) -> (print_endline (("accept variable")));(Success (advanceInStream stream))
| _ -> Failure


(* Définition de la monade  qui est composée de : *)
(* - le type de donnée monadique : parseResult  *)
(* - la fonction : inject qui construit ce type à partir d'une liste de terminaux *)
(* - la fonction : bind (opérateur >>=) qui combine les fonctions d'analyse. *)

(* inject inputStream -> parseResult *)
(* Construit le type de la monade à partir d'une liste de terminaux *)
let inject s = Success s;;

(* bind : 'a m -> ('a -> 'b m) -> 'b m *)
(* bind (opérateur >>=) qui combine les fonctions d'analyse. *)
(* ici on utilise une version spécialisée de bind :
   'b  ->  inputStream
   'a  ->  inputStream
    m  ->  parseResult
*)
(* >>= : parseResult -> (inputStream -> parseResult) -> parseResult *)
let (>>=) result f =
  match result with
    | Success next -> f next
    | Failure -> Failure
;;


(* parseProgramme : inputStream -> parseResult *)
(* Analyse du non terminal Programme *)
let rec parseProgramme stream =
  (print_string "Programme -> ");
  (match (peekAtFirstToken stream) with
    | UL_SYMBOLE _ -> (inject stream >>=
                        parseR >>=
                        parseSR)
    | _ -> Failure)

and parseSR stream =
  (print_string "SR -> ");
  (match (peekAtFirstToken stream) with
    | UL_FIN -> Success stream
    | UL_SYMBOLE _ -> (inject stream >>=
                        parseR >>=
                        parseSR)
    | _ -> Failure)
    
and parseR stream =
  (print_string "R -> ");
  (match (peekAtFirstToken stream) with
    | UL_SYMBOLE _ -> (inject stream >>=
                        parseP >>=
                        parseSP >>=
                        accept UL_PT)
    | _ -> Failure)

and parseSP stream =
  (print_string " SP -> ");
  (match (peekAtFirstToken stream) with
    | UL_PT -> Success stream
    | UL_DED -> (inject stream >>=
    			accept UL_DED >>=
                        parseE >>=
                        parseSE)
    | _ -> Failure)
    
and parseE stream =
  (print_string " E -> ");
  (match (peekAtFirstToken stream) with
    | UL_ECHEC -> Success stream
    | UL_STP -> Success stream
    | UL_NEG -> (inject stream >>=
    			accept UL_NEG >>=
                        parseP)
    | UL_SYMBOLE _ -> (parseP stream)
    | _ -> Failure)
    
and parseSE stream =
  (print_string " SE -> ");
  (match (peekAtFirstToken stream) with
    | UL_PT -> Success stream
    | UL_VIRG -> (inject stream >>=
    			accept UL_VIRG >>=
                        parseE >>=
                        parseSE)
    | _ -> Failure)

and parseP stream =
  (print_string " P -> ");
  (match (peekAtFirstToken stream) with
    | UL_SYMBOLE _ -> (inject stream >>=
    			acceptSymbole >>=
                        accept UL_PAROUV >>=
                        parseT >>=
                        parseST >>=
                        accept UL_PARFER)
    | _ -> Failure)
    
and parseT stream =
  (print_string " T -> ");
  (match (peekAtFirstToken stream) with
    | UL_SYMBOLE _ ->(inject stream >>=
    			acceptSymbole >>=
                        parseO)
    | UL_VARIABLE _ -> (acceptVariable stream)
    | _ -> Failure)
    
and parseST stream =
  (print_string " ST -> ");
  (match (peekAtFirstToken stream) with
    | UL_PARFER ->(Success stream)
    | UL_VIRG ->(inject stream >>=
    			accept UL_VIRG >>=
    			parseT >>=
                        parseST)
    | _ -> Failure)
    
and parseO stream =
  (print_string " O -> ");
  (match (peekAtFirstToken stream) with
    | (UL_PT | UL_VIRG | UL_PARFER) ->(Success stream)
    | UL_PAROUV ->(inject stream >>=
    			accept UL_PAROUV >>=
    			parseT >>=
                        parseST >>=
                        accept UL_PARFER)
    | _ -> Failure)
;;
