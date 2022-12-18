--with AB_Exceptions;         use AB_Exceptions;
with Ada.Text_IO;           use Ada.Text_IO;
--with Ada.Unchecked_Deallocation;

package body Tableau is
    

    procedure Initialiser(Tab: out T_Tableau) is
    begin
        Tab.Taille:=0;
    end Initialiser;
    
    function Taille (Tab : T_Tableau) return integer is
    begin
        return Tab.Taille;
    end Taille;

    function Est_Vide (Tab : T_Tableau) return Boolean is
    begin
        return (Tab.Taille=0);
    end;
    

    procedure Echanger (Tab: in out T_Tableau; emplacement_d: in integer; emplacement_a: in integer) is
    begin
        Permutation(Tab.Tableau(emplacement_d), Tab.Tableau(emplacement_a));
    end Echanger;


    procedure Extraction_arbre(Tab : in T_Tableau; Arbre : out AB.T_AB; Indice : in integer) is
    begin
        Arbre := Tab.Tableau(Indice);
    end Extraction_arbre;


    procedure Enregistrer (Tab : in out T_Tableau ; Indice : in T_indice ; Valeur : in T_valeur) is
    begin
        if not Valeur_existe(tab, valeur) then
            Initialiser(Tab.Tableau(Tab.Taille+1));
            Enregistrer(Tab.Tableau(Tab.Taille+1), Indice, Valeur);
            Tab.Taille:=Tab.Taille+1;
        else
            Enregistrer(Tab.Tableau(indice_valeur(tab, valeur)), Indice, Valeur);
        end if;
                    
    end Enregistrer;


    function Valeur_existe(Tab : in T_Tableau; Valeur_test : in T_valeur) return Boolean is
        existance : Boolean := False;
    begin
        for index in 1..Tab.Taille loop
            if Valeur(Tab.Tableau(index)) = Valeur_test then
                existance := True;
            else
                null;
            end if;
        end loop;
        return existance;
    end Valeur_existe;
    
    
    function indice_valeur(Tab : in T_Tableau; Valeur_test : in T_valeur) return integer is
        index : integer;
    begin
        for i in 1..Tab.Taille loop
            if Valeur(Tab.Tableau(i)) = Valeur_test then
                index := i;
            else
                null;
            end if;
        end loop;
        return index;
    end indice_valeur;
    
    
    procedure Incrementer(Tab: in out T_Tableau; emplacement: in integer) is
    begin
        Enregistrer(Tab, increm(Indice(Tab.Tableau(emplacement))), Valeur(Tab.Tableau(emplacement)));
    end Incrementer;
    
    
    Procedure Tri_Tab(Tab : in out T_Tableau) is 
    begin 
        for i in 1..Tab.Taille loop
            for j in 1..Tab.Taille-1 loop
                if sup(Indice(Tab.Tableau(j)),Indice(Tab.Tableau(j+1))) then
                    Echanger (Tab, j, j+1);
                else
                    null;
                end if;
            end loop;
        end loop;
    end Tri_Tab;
    
    
    Procedure Associer(Tab: in out T_Tableau; i: in integer; j: in integer; valeur : in T_valeur) is
        k: integer := i;
    begin
        Associer(Tab.Tableau(i), Tab.Tableau(j), valeur);
        Supprimer(Tab, j);
        while k<Tab.Taille and sup(Indice(Tab.Tableau(k)),Indice(Tab.Tableau(k+1))) loop
            Echanger(Tab, k, k+1);
            k:=k+1;
        end loop;
    end Associer;


    procedure Supprimer (Tab : in out T_Tableau ; emplacement : in integer) is
        index : integer := emplacement;
    begin
        if emplacement = Taille(Tab) then
            null;
        else
            while index<Taille(Tab) loop
                Permutation(Tab.Tableau(index), Tab.Tableau(index+1));
                index := index +1;
            end loop;
        end if;
        --Vider(Tab.Tableau(Tab.Taille));
        Tab.Taille:=Tab.Taille-1;
    end Supprimer;


    procedure Vider (Tab : in out T_Tableau) is
    begin
        for i in 1..Tab.Taille loop
            Vider(Tab.Tableau(i));
        end loop;
        Tab.taille:=0;
    end Vider;


    procedure Initialiser(Arbre: out T_AB) is
    begin
        AB.Initialiser(Arbre);
    end Initialiser;


    procedure fils_droit (Arbre : in T_AB; droit: out T_AB) is
    begin
        AB.fils_droit (Arbre , droit);
    end fils_droit;


    procedure fils_gauche (Arbre : T_AB; gauche : out T_AB) is
    begin
        AB.fils_gauche (Arbre, gauche);
    end fils_gauche;


    function Est_Vide (Arbre : T_AB) return Boolean is
    begin
        return AB.Est_Vide (Arbre);
    end Est_Vide;


    function Indice (Arbre : T_AB) return T_indice is
    begin
        return AB.Indice (Arbre);
    end Indice;


    function Valeur (Arbre : in T_AB) return T_valeur is
    begin
        return AB.Valeur (Arbre);
    end Valeur;


    function Taille (Arbre : in T_AB) return integer is
    begin
        return AB.Taille(Arbre);
    end Taille;


    procedure Enregistrer (Arbre : in out T_AB ; Indice : in T_indice ; Valeur : in T_valeur) is
    begin
        AB.Enregistrer(arbre, indice, valeur);
    end Enregistrer;


    procedure Associer (Arbre_1 : in out T_AB ; Arbre_2: in T_AB; valeur: in T_valeur) is 
    begin
        AB.associer(Arbre_1 , arbre_2, valeur);
    end Associer;


    procedure Permutation (Arbre_1 : in out T_AB ; Arbre_2: in out T_AB) is
    begin
        AB.permutation(ARbre_1, arbre_2);
    end Permutation;


    procedure Supprimer (Arbre : in out T_AB ; Indice : in T_indice) is
    begin
        AB.Supprimer(Arbre, indice);
    end Supprimer;


    procedure Vider (Arbre : in out T_AB) is
    begin
        AB.Vider(Arbre);
    end Vider;


    Procedure affichage_arbre(arbre : in T_AB; nombre: in integer) is --l'indice sera toujours remi à 0
        fils_g : T_AB;
        fils_d : T_AB;
    begin
        AB.fils_gauche(arbre, fils_g);
        AB.fils_droit(arbre, fils_d);
        If Est_Vide(fils_d) and Est_Vide(fils_g) then
            Put("(");
            afficher_int(AB.Indice(arbre));
            Put(")");
            Put(" ");
            --afficher('"' & To_String(Valeur(arbre)) & '"');
            afficher_str(AB.valeur(arbre));
            New_Line;
        elsif Est_Vide(arbre) then
            null;
        Else
            Put ("(");
            afficher_int(AB.Indice(arbre));
            Put(")");
            New_Line;
            for i in 1..nombre loop
                Put("  |       ");
            end loop;
            Put("  \--0--");
            affichage_arbre(fils_g, nombre + 1);
            for i in 1..nombre loop
                Put("  |       ");
            end loop;

            Put("  \--1--" );
            affichage_arbre(fils_d, nombre + 1);
        end if;
    end affichage_arbre;
    

end Tableau;
