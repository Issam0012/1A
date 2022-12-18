with LCA;

generic
    CAPACITE: integer;
    type T_Cle is private;
    type T_Donnee is private;
    with function hachage(Cle: T_Cle) return Integer;

package TH is

    package T_lca_th is new LCA(T_Cle, T_Donnee);
    use T_lca_th;


    type T_TH is limited private;


	-- Initialiser un Th.  Le Th est vide.
	procedure Initialiser(Th: out T_TH) with
        Post => Est_Vide (Th);


    -- La fonction de hachage modulo la capacité
	function fonction_de_hachage(Cle : in T_Cle) return integer with
        Post => fonction_de_hachage'Result <= CAPACITE;


	-- Est-ce qu'un Th est vide ?
	function Est_Vide (TH : T_TH) return Boolean;


	-- Obtenir la taille d'un Th
	function Taille (Th : in T_TH) return Integer with
		Post => Taille'Result >= 0
			and (Taille'Result = 0) = Est_Vide (Th);


	-- Enregistrer une Donnée associée à une Clé dans un Th.
	-- Si la clé est déjà présente dans le Th, on va considérer notre T_donnee comme LCA.
	procedure Enregistrer (Th : in out T_TH ; Cle : in T_Cle ; Donnee : in T_Donnee) with
		Post => Cle_Presente (Th, Cle) and (La_Donnee (Th, Cle) = Donnee)   -- donnée insérée
                and (not (Cle_Presente (Th, Cle)'Old) or Taille (Th) = Taille (Th)'Old)
				and (Cle_Presente (Th, Cle)'Old or Taille (Th) = Taille (Th)'Old + 1);

	-- Supprimer la Donnée associée à une Clé dans un Th.
	-- Exception : Cle_Absente_Exception si Clé n'est pas utilisée dans le Th
	procedure Supprimer (Th : in out T_TH ; Cle : in T_Cle) with
		Post =>  Taille (Th) = Taille (Th)'Old - 1 -- un élément de moins
			and not Cle_Presente (Th, Cle);         -- la clé a été supprimée


	-- Savoir si une Clé est présente dans un Th.
	function Cle_Presente (Th : in T_TH ; Cle : in T_Cle) return Boolean;


	-- Obtenir la donnée associée à une Cle dans le Th.
	-- Exception : Cle_Absente_Exception si Clé n'est pas utilisée dans l'Th
	function La_Donnee (Th : in T_TH ; Cle : in T_Cle) return T_Donnee;


	-- Supprimer tous les éléments d'un Th.
	procedure Vider (Th : in out T_TH) with
		Post => Est_Vide (Th);


	-- Appliquer un traitement (Traiter) pour chaque couple d'un Th.
	generic
		with procedure Traiter (Cle : in T_Cle; Donnee: in T_Donnee);
	procedure Pour_Chaque_th (Th : in T_TH);


-- AVEC_AFFICHER_DEBUG STOP DELETE
private

    type T_Tab_TH is array (1.. CAPACITE) of T_LCA;

    type T_TH is
        record
            taille: integer;
            Tab_TH: T_Tab_TH;
        end record;

end TH;
