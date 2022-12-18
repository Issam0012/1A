generic
    type T_indice is private;
    type T_valeur is private;
    with function sum(indice_1 : in T_indice; indice_2 : in T_indice) return T_indice;


package arbre_binaire is

    type T_AB is private;  
    

    -- Initialiser une arbre binaire.  La Arbre est vide.
    procedure Initialiser(Arbre: out T_AB) with
            Post => Est_Vide (Arbre);


    -- Est-ce qu'une Arbre et son fils droit et son fils gauche sont vide ? 
    function Est_Vide (Arbre : in T_AB) return Boolean;
    
    --Avoir le fils gauche d'un arbre
    procedure fils_gauche (Arbre : in T_AB; gauche: out T_AB);
    
    --Avoir le fils droit d'un arbre
    procedure fils_droit (Arbre : in T_AB; droit: out T_AB);
    
    
    --Les quatres fonctions suivantes renvoient l'indice et la valeur et le fils droit et le fils gauche
    function Indice (Arbre : in T_AB) return T_indice;
    function Valeur (Arbre : in T_AB) return T_valeur;


    -- Obtenir le nombre d'éléments d'une Arbre. 
    function Taille (Arbre : in T_AB) return integer with
            Post => Taille'Result >= 0
            and (Taille'Result = 0) = Est_Vide (Arbre);


    -- Enregistrer une Donnée associée à une Clé dans une Arbre.
    -- Si la clé est déjà présente dans la Arbre, sa donnée est changée.
    procedure Enregistrer (Arbre : in out T_AB ; Indice : in T_indice ; Valeur : in T_valeur);
    
    
    --Associer deux arbres
    procedure Associer (Arbre_1 : in out T_AB ; Arbre_2: in T_AB; valeur: in T_valeur);
    
    
    --Permuter les valeurs de 2 arbres
    procedure Permutation (Arbre_1 : in out T_AB ; Arbre_2: in out T_AB);


    -- Supprimer la Donnée associée à une Clé dans une Arbre.
    -- Exception : Indice_Absente_Exception si Clé n'est pas utilisée dans la Arbre
    procedure Supprimer (Arbre : in out T_AB ; Indice : in T_indice) with
            Post =>  Taille (Arbre) = Taille (Arbre)'Old - 1; -- un élément de moins

    
    -- Supprimer tous les éléments d'une Arbre.
    procedure Vider (Arbre : in out T_AB) with
            Post => Est_Vide (Arbre);
    
    
    -- L'affichage d'une arbre
    generic
        with procedure afficher_int(variable : in T_indice);
        with procedure afficher_str(variable : in T_valeur);
    Procedure affichage_arbre(arbre : in T_AB; nombre : in integer);
   

private

	
    type T_noeud;

    type T_AB is access T_noeud;
    
    type T_noeud is 
        record
            Indice : T_indice;
            Valeur : T_valeur;
            Fils_D : T_AB;
            Fils_G : T_AB;
        end record;
    
end arbre_binaire;
