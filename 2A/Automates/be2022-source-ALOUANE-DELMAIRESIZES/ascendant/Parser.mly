%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

%token UL_ACCOUV UL_ACCFER
%token UL_PTVIRG UL_AFF 

/* Defini le type des donnees associees a l'unite lexicale */

%token <string> UL_IDENT
%token <string> UL_NAME
%token <int> UL_ENTIER

/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN

/* Type renvoye pour le nom terminal document */
%type <unit> record

/* Le non terminal document est l'axiome */
%start record

%% /* Regles de productions */

record : valeur UL_FIN { (print_endline "record : valeur UL_FIN") }

valeur : UL_ACCOUV enregistrement UL_ACCFER { (print_endline "valeur : UL_ACCOUV enregistrement UL_ACCFER ") }
	| UL_IDENT { (print_endline "valeur : UL_IDENT ") }
	| UL_ENTIER { (print_endline "valeur : UL_ENTIER ") }
	
enregistrement : /* lambda, mot vide  */ { (print_endline "enregistrement : /* Lambda, mot vide */") }
		| UL_NAME UL_AFF valeur enregistrement_suite { (print_endline "enregistrement : UL_NAME UL_AFF valeur enregistrement_suite") }
		
enregistrement_suite :  /* lambda, mot vide  */ { (print_endline "enregistrement_suite : /* Lambda, mot vide */") }
		    | UL_PTVIRG enregistrement { (print_endline "enregistrement_suite : UL_PTVIRG enregistrement") }

%%
