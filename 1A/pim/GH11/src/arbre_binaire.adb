with Ada.Text_IO;           use Ada.Text_IO;
--with Ada.T_indice_Text_IO;   use Ada.T_indice_Text_IO;
with Ada.Unchecked_Deallocation;

package body arbre_binaire is

    procedure Free is
            new Ada.Unchecked_Deallocation (Object => T_noeud, Name => T_AB);

    procedure Initialiser(Arbre: out T_AB) is
    begin
        Arbre := null;
    end Initialiser;


    procedure fils_droit (Arbre : in T_AB; droit: out T_AB) is
    begin
        droit := Arbre.all.Fils_D;
    end fils_droit;


    procedure fils_gauche (Arbre : T_AB; gauche : out T_AB) is
    begin
        gauche := Arbre.all.Fils_G;
    end fils_gauche;


    function Est_Vide (Arbre : T_AB) return Boolean is
    begin
        return Arbre = null;
    end Est_Vide;


    function Indice (Arbre : T_AB) return T_indice is
    begin
        return Arbre.all.Indice;
    end Indice;


    function Valeur (Arbre : in T_AB) return T_valeur is
    begin
        return Arbre.all.Valeur;
    end Valeur;


    function Taille (Arbre : in T_AB) return integer is
    begin
        if Est_Vide(Arbre) then
            return 0;
        else
            return 1+Taille(Arbre.all.Fils_G)+ Taille(Arbre.all.Fils_D);
        end if;
    end Taille;


    procedure Enregistrer (Arbre : in out T_AB ; Indice : in T_indice ; Valeur : in T_valeur) is
    begin
        if Est_Vide(Arbre) then
            Arbre := new T_noeud'(Indice, Valeur, null, null);
        else
            Arbre.all.Indice := Indice;
        end if;
    end Enregistrer;


    procedure Associer (Arbre_1 : in out T_AB ; Arbre_2: in T_AB; valeur: in T_valeur) is
    begin
        Arbre_1 := new T_noeud'(sum(Indice(Arbre_1),Indice(Arbre_2)), valeur, Arbre_2, Arbre_1);
    end Associer;


    procedure Permutation (Arbre_1 : in out T_AB ; Arbre_2: in out T_AB) is
        Arbre_temp: T_AB;
    begin
        Arbre_temp := Arbre_1;
        Arbre_1:=Arbre_2;
        Arbre_2:=Arbre_temp;
    end Permutation;


    procedure Supprimer (Arbre : in out T_AB ; Indice : in T_indice) is
        A_Detruire : T_AB;
    begin
        if Taille(Arbre) = 0 then
            null;
        elsif Arbre.all.Indice = Indice then
            A_Detruire := Arbre;
            if Arbre.all.Fils_G = null then
                Arbre := Arbre.all.Fils_D;
                free(A_Detruire);
            elsif Arbre.all.Fils_D = null then
                Arbre := Arbre.all.Fils_G;
                free(A_Detruire);
            else
                null;
            end if;
        else
            Supprimer(Arbre.all.Fils_D, Indice);
            Supprimer(Arbre.all.Fils_G, Indice);
        end if;
    end Supprimer;


    procedure Vider (Arbre : in out T_AB) is
    begin
        if Taille(Arbre) = 0 then
            Null;
        else
            Vider(Arbre.all.Fils_D);
            Vider(Arbre.all.Fils_G);
            Supprimer(Arbre, Arbre.all.Indice);
        end if;
    end Vider;


    Procedure affichage_arbre(arbre : in T_AB; nombre: in integer) is --les deux indices seront toujours remis à 0
    begin
        If Est_Vide(Arbre.all.Fils_D) and Est_Vide(Arbre.all.Fils_G) then
            Put("(");
            afficher_int(Indice(arbre));
            Put(")");
            Put(" ");
            --afficher('"' & To_String(Valeur(arbre)) & '"');
            afficher_str(valeur(arbre));
            New_Line;
        elsif arbre = null then
            null;
        Else
            Put ("(");
            afficher_int(Indice(arbre));
            Put(")");
            New_Line;
            for i in 1..nombre loop
                Put("  |       ");
            end loop;
            Put("  \--0--");
            affichage_arbre(Arbre.all.Fils_G, nombre + 1);
            for i in 1..nombre loop
                Put("  |       ");
            end loop;

            Put("  \--1--" );
            affichage_arbre(Arbre.all.Fils_D, nombre + 1);
        end if;
    end affichage_arbre;


end arbre_binaire;
