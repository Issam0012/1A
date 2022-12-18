
-- Auteur: 
-- Gérer un stock de matériel informatique.

package Stocks_Materiel is


    CAPACITE : constant Integer := 10;      -- nombre maximum de matériels dans un stock

    type T_Nature is (UNITE_CENTRALE, DISQUE, ECRAN, CLAVIER, IMPRIMANTE);


    type T_Stock is limited private;


    -- Créer un stock vide.
    --
    -- paramètres
    --     Stock : le stock à créer
    --
    -- Assure
    --     Nb_Materiels (Stock) = 0
    --
    procedure Creer (Stock : out T_Stock) with
        Post => Nb_Materiels (Stock) = 0;


    -- Obtenir le nombre de matériels dans le stock Stock.
    --
    -- Paramètres
    --    Stock : le stock dont ont veut obtenir la taille
    --
    -- Nécessite
    --     Vrai
    --
    -- Assure
    --     Résultat >= 0 Et Résultat <= CAPACITE
    --
    function Nb_Materiels (Stock: in T_Stock) return Integer with
        Post => Nb_Materiels'Result >= 0 and Nb_Materiels'Result <= CAPACITE;


    -- Enregistrer un nouveau métériel dans le stock.  Il est en
    -- fonctionnement.  Le stock ne doit pas être plein.
    -- 
    -- Paramètres
    --    Stock : le stock à compléter
    --    Numero_Serie : le numéro de série du nouveau matériel
    --    Nature       : la nature du nouveau matériel
    --    Annee_Achat  : l'année d'achat du nouveau matériel
    -- 
    -- Nécessite
    --    Nb_Materiels (Stock) < CAPACITE
    -- 
    -- Assure
    --    Nouveau matériel ajouté
    --    Nb_Materiels (Stock) = Nb_Materiels (Stock)'Avant + 1
    procedure Enregistrer (
            Stock        : in out T_Stock;
            Numero_Serie : in     Integer;
            Nature       : in     T_Nature;
            Annee_Achat  : in     Integer
        ) with
            Pre => Nb_Materiels (Stock) < CAPACITE,
            Post => Nb_Materiels (Stock) = Nb_Materiels (Stock)'Old + 1;
    
    -- Obtenir le nombre de matériels dans le stock Stock qui ne fonctionne pas.
    --
    -- Paramètres
    --    Stock : le stock dont ont veut obtenir le nombre de matériels qui ne fonctionne pas
    --
    -- Nécessite
    --     Vrai
    --
    -- Assure
    --     Résultat >= 0 Et Résultat <= CAPACITE
    --
    function Nb_Materiels_fonctionnant_pas (Stock: in T_Stock) return Integer with
            Post => Nb_Materiels_fonctionnant_pas'Result >= 0 and Nb_Materiels_fonctionnant_pas'Result <= CAPACITE;
    
    -- Mettre à jour l'état d'un élément à partir de son numéro de série
    -- 
    -- Paramètres
    --    Stock : le stock à modifier
    --    Numero_Serie : le numéro de série du matériel
    --    etat: le nouveau état du matériel
    -- 
    -- Nécessite
    --    Vrai
    -- 
    -- Assure
    --    Stock.etat_fonctionnement=etat
    procedure modifier (
            Stock        : in out T_Stock;
            Numero_Serie : in     Integer;
            etat       : in     Boolean
        ) with
            Post => Stock.etat_fonctionnement=etat;
    
    -- Supprimer du stock un élément à partir de son numéro de série
    -- 
    -- Paramètres
    --    Stock : le stock à modifier
    --    Numero_Serie : le numéro de série du matériel à supprimer
    -- 
    -- Nécessite
    --    exists x in Stock: Stock.num_serie=Numero_Serie
    -- 
    -- Assure
    --    forall x in Stock: Stock.num_serie/=Numero_Serie
    procedure modifier (
            Stock        : in out T_Stock;
            Numero_Serie : in     Integer;
            etat       : in     Boolean
        ) with
            Pre => exists x in Stock: Stock.num_serie=Numero_Serie;
            Post => forall x in Stock: Stock.num_serie/=Numero_Serie;
    
    -- Afficher tous le matériel du stock
    -- 
    -- Paramètres
    --    Stock : le stock à afficher
    --    
    -- 
    -- Nécessite
    --    Vrai
    -- 
    -- Assure
    --    Vrai
    procedure afficher_stock (
            Stock        : in out T_Stock
        ) with ;
            
    
    
    -- Supprimer du stock les éléments ne fonctionnant pas
    -- 
    -- Paramètres
    --    Stock : le stock à modifier
    -- 
    -- Nécessite
    --    Vrai
    -- 
    -- Assure
    --    pour tous element de Stock: Stock.etat_fonctionnement=True
    procedure supprimer_non_fonctionnant (
            Stock        : in out T_Stock;
        ) with
            Post => Stock.etat_fonctionnement=True forall x in Stock;
                    
private
    
    type T_Stock is 
        record
            num_serie : Integer;
            nature : T_Nature;
            annee_achat : Integer;
            etat_fonctionnement : Boolean;
        end record;
    
end Stocks_Materiel;
