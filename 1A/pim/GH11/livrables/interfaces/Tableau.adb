--with AB_Exceptions;         use AB_Exceptions;
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
    

    procedure Echanger (Tab: in out T_Tableau; emplacement_d: in Integer; emplacement_a: in Integer) is
    begin
        Permutation(Tab.Tableau(emplacement_d), Tab.Tableau(emplacement_a));
    end Echanger;



    procedure Enregistrer (Tab : in out T_Tableau ; Indice : in Integer ; Valeur : in Unbounded_string) is
    begin
        Initialiser(Tab.Tableau(Tab.Taille+1));
        Enregistrer(Tab.Tableau(Tab.Taille+1), Indice, Valeur);
        Tab.Taille:=Tab.Taille+1;
    end Enregistrer;


    function Valeur_existe(Tab : in T_Tableau; Valeur_test : in Unbounded_String) return Boolean is
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
    
    
    function indice_valeur(Tab : in T_Tableau; Valeur_test : in Unbounded_String) return integer is
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
        Enregistrer(Tab, Indice(Tab.Tableau(emplacement)) + 1, Valeur(Tab.Tableau(emplacement)));
        Supprimer(Tab, emplacement);
    end Incrementer;
    
    
    function superieur(Tab: in T_Tableau; i: in Integer; j: in Integer) return Boolean is
    begin
        return (Indice(Tab.Tableau(i))>=Indice(Tab.Tableau(j)));
    end superieur;
    
    
    function superieur_stricte(Tab: in T_Tableau; i: in Integer; j: in Integer) return Boolean is
    begin
        return (Indice(Tab.Tableau(i))>Indice(Tab.Tableau(j)));
    end superieur_stricte;
    
    
    function maximum(a: in integer; b: in integer) return Integer is
    begin
        if a>=b then
            return a;
        else
            return b;
        end if;
    end maximum;
    
    
    Procedure Tri_Tab(Tab : in out T_Tableau) is 
    begin 
        for i in 1..Tab.Taille loop
            for j in 1..Tab.Taille-1 loop
                if Indice(Tab.Tableau(j))>Indice(Tab.Tableau(j+1)) then
                    Echanger (Tab, j, j+1);
                else
                    null;
                end if;
            end loop;
        end loop;
    end Tri_Tab;
    
    
    Procedure Associer(Tab: in out T_Tableau; i: in integer; j: in integer) is
        k: integer := i;
    begin
        Associer(Tab.Tableau(i), Tab.Tableau(j));
        Supprimer(Tab, j);
        while k<Tab.Taille and Indice(Tab.Tableau(k)) >= Indice(Tab.Tableau(k+1)) loop
            Echanger(Tab, k, k+1);
            k:=k+1;
        end loop;
    end Associer;


    procedure Supprimer (Tab : in out T_Tableau ; emplacement : in Integer) is
        index : Integer := emplacement;
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
        for i in 1..Taille(Tab) loop
            Vider(Tab.Tableau(i));
        end loop;
        Tab.taille:=0;
    end Vider;

    procedure afficher_tab (Tab : in T_Tableau) is
        index : Integer;
    begin
        index:=1;
        while index <= Taille(Tab) loop
            affichage_arbre(Tab.Tableau(index), 0, 0);
            index := index + 1;
        end loop;
    end afficher_tab;

end Tableau;
