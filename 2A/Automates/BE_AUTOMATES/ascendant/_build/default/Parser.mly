%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

%token UL_PAROUV UL_PARFER
%token UL_PT UL_VIRG 
%token UL_STP UL_DED UL_NEG UL_FAIL

/* Defini le type des donnees associees a l'unite lexicale */

%token <string> UL_SYMBOLE
%token <string> UL_VARIABLE

/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN

/* Type renvoye pour le nom terminal document */
%type <unit> programme

/* Le non terminal document est l'axiome */
%start programme

%% /* Regles de productions */

programme : UL_FIN { (print_endline "programme : FIN ") }
	    | programme_aux programme { (print_endline "programme : programme_aux programme ") }

programme_aux : axiome { (print_endline "programme : axiome ") }
	    | deduction { (print_endline "programme : deduction ") }

axiome : predicat UL_PT { (print_endline "axiome : predicat UL_PT ") }

deduction : predicat UL_DED deduction_aux suite_deduction UL_PT { (print_endline "deduction : predicat UL_DED deduction_aux UL_PT ") }

suite_deduction : /* Lambda, mot vide */ { (print_endline "suite_deduction : /* Lambda, mot vide */") }
	          | UL_VIRG deduction_aux suite_deduction { (print_endline "suite_deduction : UL_VIRG deduction_aux suite_deduction") }

deduction_aux : predicat { (print_endline "deduction_aux ; predicat ") }
                | UL_NEG predicat { (print_endline "deduction_aux ; UL_NEG predicat ") }
                | UL_FAIL { (print_endline "deduction_aux ; FAIL ") }
                | UL_STP { (print_endline "deduction_aux ; UL_STP ") }
	   
predicat : UL_SYMBOLE UL_PAROUV aux UL_PARFER { (print_endline "predicat ; UL_SYMBOLE UL_PAROUV suite_predicat UL_PARFER ") }

aux : UL_VARIABLE { (print_endline "aux ; UL_VARIABLE ") }
      | terme  { (print_endline "aux ; terme ") }
      | UL_VIRG aux  { (print_endline "aux ; UL_VIRG ") }
      
terme : UL_SYMBOLE { (print_endline "terme ; UL_SYMBOLE ") }
	| UL_SYMBOLE UL_PAROUV aux UL_PARFER { (print_endline "terme ; UL_SYMBOLE UL_PAROUV aux UL_PARFER ") }
      
%%
