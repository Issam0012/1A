with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Unchecked_Deallocation;

package body Vecteurs_Creux is


	procedure Free is
		new Ada.Unchecked_Deallocation (T_Cellule, T_Vecteur_Creux);


	procedure Initialiser (V : out T_Vecteur_Creux) is
	begin
		V := Null;
	end Initialiser;


    procedure Detruire (V: in out T_Vecteur_Creux) is
	begin
		if V /= Null then
			Detruire (V.all.Suivant);
			Free (V);
		else
			Null;
		end if;
	end Detruire;


	function Est_Nul (V : in T_Vecteur_Creux) return Boolean is
	begin
		return (V=Null);
	end Est_Nul;


    function Composante_Recursif (V : in T_Vecteur_Creux ; Indice : in Integer) return Float is
     begin
        if Indice=V.all.Indice then
            return V.all.Valeur;
        else
            return Composante_Recursif (V.all.Suivant , Indice ) ;
        end if;
	end Composante_Recursif;


    function Composante_Iteratif (V : in T_Vecteur_Creux ; Indice : in Integer) return Float is
        Vecteur: T_Vecteur_Creux;
    begin
        Vecteur:=V;
        while V.all.Indice /= Indice loop
            Vecteur:=Vecteur.all.suivant;
        end loop;
        return Vecteur.all.Valeur;
	end Composante_Iteratif;


	procedure Modifier (V : in out T_Vecteur_Creux ;
				       Indice : in Integer ;
                         Valeur : in Float ) is
        New_cellule: T_Vecteur_Creux;
    begin
        New_cellule := new T_Cellule;
        if Est_Nul(V) then
            New_cellule.all.Indice:=Indice;
            New_cellule.all.Valeur:=Valeur;
            V:=New_cellule;
        else
            Modifier(V.all.suivant,Indice,Valeur);
        end if;
	end Modifier;


	function Sont_Egaux_Recursif (V1, V2 : in T_Vecteur_Creux) return Boolean is
        begin
            if Est_Nul(V1) and Est_Nul(V2) then
                return True;
            else
                return (V1.all.Valeur=V2.all.Valeur) and Sont_Egaux_Recursif (V1.all.Suivant, V2.all.Suivant);
            end if;
	end Sont_Egaux_Recursif;


    function Sont_Egaux_Iteratif (V1, V2 : in T_Vecteur_Creux) return Boolean is
            V1_copie,V2_copie: T_Vecteur_Creux;
        begin
            V1_copie:=V1;
            V2_copie:=V2;
            while V1_copie.all.Valeur=V2_copie.all.Valeur loop
                V1_copie:=V1_copie.all.Suivant;
                V2_copie:=V2_copie.all.Suivant;
            end loop;
            if Est_Nul(V1_copie) and Est_Nul(V2_copie) then
                return True;
            else
                return False;
            end if;
	end Sont_Egaux_Iteratif;


	procedure Additionner (V1 : in out T_Vecteur_Creux; V2 : in T_Vecteur_Creux) is
	begin
		Null;	-- TODO : à changer
	end Additionner;


	function Norme2 (V : in T_Vecteur_Creux) return Float is
	begin
		return 0.0;	-- TODO : à changer
	end Norme2;


	Function Produit_Scalaire (V1, V2: in T_Vecteur_Creux) return Float is
	begin
		return 0.0;	-- TODO : à changer
	end Produit_Scalaire;


	procedure Afficher (V : T_Vecteur_Creux) is
	begin
		if V = Null then
			Put ("--E");
		else
			-- Afficher la composante V.all
			Put ("-->[ ");
			Put (V.all.Indice, 0);
			Put (" | ");
			Put (V.all.Valeur, Fore => 0, Aft => 1, Exp => 0);
			Put (" ]");

			-- Afficher les autres composantes
			Afficher (V.all.Suivant);
		end if;
	end Afficher;


	function Nombre_Composantes_Non_Nulles (V: in T_Vecteur_Creux) return Integer is
	begin
		if V = Null then
			return 0;
		else
			return 1 + Nombre_Composantes_Non_Nulles (V.all.Suivant);
		end if;
	end Nombre_Composantes_Non_Nulles;


end Vecteurs_Creux;
