--with Ada.Text_IO;            use Ada.Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;

package body LCA is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LCA);


	procedure Initialiser(Sda: out T_LCA) is
	begin
		Sda:=null;
	end Initialiser;


	function Est_Vide (Sda : in T_LCA) return Boolean is
	begin
		return (Sda=null);
	end;


    function Taille (Sda : in T_LCA) return Integer is --on utilise une fonction récursive
     begin
        if Est_Vide(Sda) then
            return 0;
        else
            return 1+Taille(Sda.all.suivant);   -- on ajoute 1 à la taille du suivant
        end if;
	 end Taille;


	procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Donnee : in T_Donnee) is
	begin
        if Est_Vide(Sda) then
            Sda:= new T_cellule'(Cle, Donnee, null);   --on crée une nouvelle cellule et on l'enregistre
        elsif Sda.all.cle=Cle then
            Sda.all.donnee:=Donnee;
        else
            Enregistrer(Sda.all.suivant,Cle,Donnee);
        end if;
	end Enregistrer;


	function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
	begin
        if Est_Vide(Sda) then   -- une liste vide ne contient aucun élément
            return False;
        elsif Sda.all.cle=Cle then   --le clé existe donc on retourne "True"
            return True;
        else
            return False or Cle_Presente(Sda.all.suivant, Cle); --si le clé n'existe pas dans notre niveau on cherche dans la partie suivante de la liste
        end if;

	end;


	function La_Donnee (Sda : in T_LCA ; Cle : in T_Cle) return T_Donnee is
	begin
        if Est_Vide(Sda) then          --liste vide ne contient aucun élément
            raise Cle_Absente_Exception;
        elsif Sda.all.cle=Cle then     --clé existant
            return Sda.all.donnee;
        else
            return La_Donnee(Sda.all.suivant, Cle);   --clé n'existant pas alors on le cherche dans la partie suivante de la liste
        end if;
	end La_Donnee;


    procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
        A_detruire: T_LCA;
	begin
        if Est_Vide(Sda) then
            raise Cle_Absente_Exception;
        elsif Sda.all.cle=Cle then
            A_detruire:=Sda;       --on associe l'adresse du Sda à un autre pointeur et on écrase la
            Sda:=Sda.all.suivant;  --valeur de Sda afin qu'elle change d'adresse et on libére le
            Free(A_detruire);      --nouveau pointeur
        else
            Supprimer(Sda.all.suivant, Cle);
        end if;

	end Supprimer;


	procedure Vider (Sda : in out T_LCA) is
	begin
		if not Est_Vide(Sda) then
			Vider (Sda.all.Suivant);  --on vide les listes composante par composante
			Free (Sda);
		else
			Null;
		end if;
	end Vider;


	procedure Pour_Chaque (Sda : in T_LCA) is
    begin
        if Est_vide(Sda) then
            null;
        else
            Traiter(Sda.all.cle,Sda.all.donnee);  --on traite le début de la liste et on passe à la
            Pour_Chaque(Sda.all.suivant);         -- partie suivante du liste
        end if;

    end Pour_Chaque;


end LCA;
