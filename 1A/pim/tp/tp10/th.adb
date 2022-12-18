package body TH is --En général, ce package fera appel aux fonctions du package lca avec quelques
                   --boucles parfois si on a besoin de traverser toutes les cases du tableau

    procedure Initialiser(Th: out T_TH) is
        i:Integer;
	begin
        Th.taille:=0;  --on initialise la taille à 0
        i:=1;
        while i<=CAPACITE loop
            Initialiser(Th.Tab_TH(i)); --on initialise chaque composante du tableau (type lca)
            i:=i+1;
        end loop;
    end Initialiser;


    function fonction_de_hachage(Cle : in T_Cle) return integer is
    begin
        return hachage(Cle) mod (CAPACITE+1);
    end;


    function Taille (Th : in T_TH) return Integer is
    begin
        return Th.taille;
    end;

	function Est_Vide (Th : in T_TH) return Boolean is
	begin
		return (Th.taille=0);
	end;


    procedure Enregistrer (Th : in out T_TH ; Cle : in T_Cle ; Donnee : in T_Donnee) is
    begin
        if not Cle_Presente (Th, Cle) then
            Th.taille:=Th.taille+1; --on ajoute 1 à la taille si et seulement si la cle n'est pas présente,
        else                        --s'elle est présente l'ancienne donnée est écrasée par une nouvelle
            null;                   --et la taille se conserve
        end if;
        Enregistrer (Th.Tab_TH(fonction_de_hachage(Cle)), Cle, Donnee);
	end Enregistrer;


    function Cle_Presente (Th : in T_TH ; Cle : in T_Cle) return Boolean is
	begin
        if Est_Vide(Th) then
            return False;
        else
            return Cle_Presente(Th.Tab_TH(fonction_de_hachage(Cle)), Cle);
        end if;
	end;


	function La_Donnee (Th : in T_TH ; Cle : in T_Cle) return T_Donnee is
	begin
        return La_Donnee(Th.Tab_TH(fonction_de_hachage(Cle)), Cle);
	end La_Donnee;


    procedure Supprimer (Th : in out T_TH ; Cle : in T_Cle) is
	begin
        Supprimer(Th.Tab_TH(fonction_de_hachage(Cle)), Cle);
        Th.taille:=Th.taille-1; --on retranche 1 de la taille quand on supprime un élément et si la clé
	end Supprimer;              --n'existe pas on aura une exception et le programme ne s'exécutera pas
                                --complètement

	procedure Vider (Th : in out T_TH) is
	    i:Integer;
    begin
        i:=1;
        if Est_vide(Th) then
            null;
        else
            while i<=CAPACITE loop
                Th.taille:=Th.taille-Taille(Th.Tab_TH(i)); --on retranche la taille du donnée et on le vide
                Vider(Th.Tab_TH(i));
                i:=i+1;
             end loop;
        end if;
    end Vider;



    procedure Pour_Chaque_th (Th : in T_TH) is
        procedure Pour_Chaque_lca is
		    new Pour_Chaque(Traiter);

        i:Integer;
    begin
        i:=1;
        if Est_vide(Th) then
            null;
        else
            while i<=CAPACITE loop
                Pour_Chaque_lca(Th.Tab_TH(i));
                i:=i+1;
             end loop;
        end if;

    end Pour_Chaque_th;


end TH;
