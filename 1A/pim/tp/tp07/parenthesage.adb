with Piles;

procedure Parenthesage is


    -- L'indice dans la chaîne Meule de l'élément Aiguille.
    -- Si l'Aiguille n'est pas dans la Meule, on retroune Meule'Last + 1.
    Function Index (Meule : in String; Aiguille: in Character) return Integer with
        Post => Meule'First <= Index'Result and then Index'Result <= Meule'Last + 1
            and then (Index'Result > Meule'Last or else Meule (Index'Result) = Aiguille)
    is
        index: Integer;
    begin
        index:=Meule'First;
        for i in Meule'Range loop
            if Apostrophe & Meule(index) & Apostrophe/=Aiguille then
                index:=index+1;
            else
                exit;
            end if;
        end loop;
        return index;
    end Index;


    -- Programme de test de Index.
    procedure Tester_Index is
        ABCDEF : constant String := "abcdef";
    begin
        pragma Assert (1 = Index (ABCDEF, 'a'));
        pragma Assert (3 = Index (ABCDEF, 'c'));
        pragma Assert (6 = Index (ABCDEF, 'f'));
        pragma Assert (7 = Index (ABCDEF, 'z'));
        pragma Assert (4 = Index (ABCDEF (1..3), 'z'));
        pragma Assert (3 = Index (ABCDEF (3..5), 'c'));
        pragma Assert (5 = Index (ABCDEF (3..5), 'e'));
        pragma Assert (6 = Index (ABCDEF (3..5), 'a'));
        pragma Assert (6 = Index (ABCDEF (3..5), 'g'));
    end;


    -- Vérifier les bon parenthésage d'une Chaîne (D).  Le sous-programme
    -- indique si le parenthésage est bon ou non (Correct : R) et dans le cas
    -- où il n'est pas correct, l'indice (Indice_Erreur : R) du symbole qui
    -- n'est pas appairé (symbole ouvrant ou fermant).
    --
    -- Exemples
    --   "[({})]"  -> Correct
    --   "]"       -> Non Correct et Indice_Erreur = 1
    --   "((()"    -> Non Correct et Indice_Erreur = 2
    --
    procedure Verifier_Parenthesage (Chaine: in String ; Correct : out Boolean ; Indice_Erreur : out Integer) is
        Ouvrants : Constant String := "([{";
        Fermants : Constant String := ")]}";
        package T_piles is new Piles(Capacite=>Chaine'Last, T_element=>Character);
        pile_ouvrants, piles_fermants: T_piles;
        package T_piles_integer is new Piles(Capacite=>Chaine'Last, T_element=>integer);
        pile_Indice: T_piles_integer;
        function est_ouvrants (caracter : in character) return Boolean is
            Resultat : Boolean;
        begin
            Resultat:=False;
            for i in 1..3 loop
                if caracter=Ouvrants(i) then
                    Resultat:=True;
                end if;
            end loop;
            return Resultat;
        end est_ouvrants;
        function est_fermants (caracter : in character) return Boolean is
            Resultat : Boolean;
        begin
            Resultat:=False;
            for i in 1..3 loop
                if caracter=Fermants(i) then
                    Resultat:=True;
                end if;
            end loop;
            return Resultat;
        end est_fermants;
    begin
        Correct:=False;
        Initialiser(pile_ouvrants);
        Initialiser(pile_Indice);
        Initialiser(pile_fermants);
        for i in Chaine'range loop
            if est_ouvrants(Chaine(i)) then
                Empiler(pile_ouvrants, Chaine(i));
                Empiler(pile_Indice, i);
            elsif est_fermants(Chaine(i)) then
                Empiler(pile_fermants, Chaine(i));
            end if;
        end loop;
        if pile_ouvrants'Last=piles_fermants'Last then
            for j in pile_ouvrants'Range loop
                if Fermants(Index(Ouvrants, piles_ouvrants(i)))=piles_fermants(i) then
                    Correct:=False;
                    Indice_Erreur:=Index(Chaine,
    end Verifier_Parenthesage;


    -- Programme de test de Verifier_Parenthesage
    procedure Tester_Verifier_Parenthesage is
        Exemple1 : constant String(1..2) :=  "{}";
        Exemple2 : constant String(11..18) :=  "]{[(X)]}";

        Indice : Integer;   -- Résultat de ... XXX
        Correct : Boolean;
    begin
        Verifier_Parenthesage ("(a < b)", Correct, Indice);
        pragma Assert (Correct);

        Verifier_Parenthesage ("([{a}])", Correct, Indice);
        pragma Assert (Correct);

        Verifier_Parenthesage ("(][{a}])", Correct, Indice);
        pragma Assert (not Correct);
        pragma Assert (Indice = 2);

        Verifier_Parenthesage ("]([{a}])", Correct, Indice);
        pragma Assert (not Correct);
        pragma Assert (Indice = 1);

        Verifier_Parenthesage ("([{}])}", Correct, Indice);
        pragma Assert (not Correct);
        pragma Assert (Indice = 7);

        Verifier_Parenthesage ("([{", Correct, Indice);
        pragma Assert (not Correct);
        pragma Assert (Indice = 3);

        Verifier_Parenthesage ("([{}]", Correct, Indice);
        pragma Assert (not Correct);
        pragma Assert (Indice = 1);

        Verifier_Parenthesage ("", Correct, Indice);
        pragma Assert (Correct);

        Verifier_Parenthesage (Exemple1, Correct, Indice);
        pragma Assert (Correct);

        Verifier_Parenthesage (Exemple2, Correct, Indice);
        pragma Assert (not Correct);
        pragma Assert (Indice = 11);

        Verifier_Parenthesage (Exemple2(12..18), Correct, Indice);
        pragma Assert (Correct);

        Verifier_Parenthesage (Exemple2(12..15), Correct, Indice);
        pragma Assert (not Correct);
        pragma Assert (Indice = 14);
    end Tester_Verifier_Parenthesage;

begin
    Tester_Index;
    Tester_Verifier_Parenthesage;
end Parenthesage;