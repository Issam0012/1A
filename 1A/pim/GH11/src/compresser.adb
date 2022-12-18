with Ada.IO_Exceptions;
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
-- with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Sequential_IO ;	-- pour l'accÃÂ¨s typÃÂ© aux fichiers (integer, naturel, float, etc.)
--with AB_Exceptions;         use AB_Exceptions;
with Ada.Command_line; use Ada.Command_line;
--with arbre_binaire;
with Tableau;
with lca;

procedure Compresser is
    
    Taille_table : Constant Integer := 256;
    
    function sum (a : in integer; b : in integer) return integer is
    begin
        return a+b;
    end sum;
    
    function sup (a : in integer; b : in integer) return Boolean is
    begin
        return (a>=b);
    end sup;
    
    function increm (a : in integer) return integer is
    begin
        return a + 1;
    end increm;
    
    package tab_test is
            new Tableau(Taille_table, integer, Unbounded_String, sum, increm, sup);
    use tab_test;

    --package AB is new arbre_binaire(integer, Unbounded_String, sum);
    --use AB;
    
    procedure affichage_str (a : in Unbounded_String) is
    begin
        Put('"' & To_String(a) & '"');
    end affichage_str;
    
    procedure affichage_int (a : in integer) is
    begin
        Put(a, 0);
    end affichage_int;
    
    procedure affichage_arbre is new tab_test.affichage_arbre(affichage_int, affichage_str);
    
    type T_Octet is mod 2 ** 8;	-- sur 8 bits
    for T_Octet'Size use 8;
   
    package Octet_file is new Ada.Sequential_IO(T_Octet) ; 
    use Octet_file ;

    -- File_Name : String :=  "exemple_fichier.out";
    -- File      : Ada.Streams.Stream_IO.File_Type;	-- car il y a aussi Ada.Text_IO.File_Type
    file_txt : Ada.Text_IO.file_type;
    -- S         : Stream_Access;
    Octet     : T_Octet;
    un_char : Character;
    --un_octet : T_Octet;
    --un_char_test : Character;
   
    Str_save : Unbounded_String;


    package LCA_codage is
            new LCA(T_Cle    => Unbounded_String, T_Donnee => Unbounded_String);
    use LCA_codage;
   
    procedure Affichage(Cle : in Unbounded_String; Donnee : in Unbounded_String) is
    begin
        Put ("'" & To_String(Cle) & "'");
        Put(" --> ");
        Put (To_String(Donnee));
        New_Line;
    end Affichage;
   
    procedure Afficher_codage is new Pour_Chaque (Affichage);
    
    
    function horner (code: in Unbounded_String) return T_Octet is
        byte: T_Octet := 0;
    begin
        for i in 1..Length(code) loop
            if To_String(code)(i) = '0' then
                byte := byte * 2 +  0;
            else
                byte := byte * 2 +  1;
            end if;
        end loop;
        return byte;
    end horner;
    
    
    type t_tab_int is array (1..Taille_table) of integer;
    type t_tab is
        record
            tab : t_tab_int;
            taille : Integer;
        end record;
    
    
    procedure Parcours_infixe(Arbre : in tab_test.AB.T_AB; LCA : in out LCA_codage.T_LCA;
                              Parcours_Huffman: in out Unbounded_String; Parcours_caractere: in out Unbounded_String) is
        fils_G : tab_test.AB.T_AB;
        fils_D : tab_test.AB.T_AB;
    begin
        tab_test.Fils_droit(Arbre, fils_D);
        Fils_gauche(Arbre, fils_G);
        if not Est_Vide(fils_G) then
            Parcours_Huffman := Parcours_Huffman & "0";
            Parcours_caractere := Parcours_caractere & "0";
            Parcours_infixe(fils_G,LCA, Parcours_Huffman, Parcours_caractere);
        else
            LCA_codage.Enregistrer(LCA, Valeur(Arbre), Parcours_caractere);
        end if;
        if not Est_Vide(fils_D) then
            Parcours_Huffman := Parcours_Huffman & "1";
            Parcours_caractere := Parcours_caractere & "1";
            Parcours_infixe(fils_D,LCA, Parcours_Huffman, Parcours_caractere);
        else
            LCA_codage.Enregistrer(LCA, Valeur(Arbre), Parcours_caractere);
        end if;
        Parcours_caractere := To_Unbounded_String( To_String ( Parcours_caractere)(1 .. Length(Parcours_caractere)-1));
    end Parcours_infixe;



    file_hff : Octet_file.file_type;
    Tableau_AB : T_Tableau;
    LCA_cara_code : T_LCA;
    --Arbre_Huffman : T_AB;
    Arbre_Huffman_1 : tab_test.AB.T_AB;
    Parcours_Huffman: Unbounded_String;
    Parcours_caractere: Unbounded_String;
    texte_code : Unbounded_String;
    indice, indice_code : integer;
    tab_int : t_tab;
    Argument_affichage : Unbounded_String;
    Argument_fichier : Unbounded_String;
   
    -- Extension_error : exception;
    Argument_error : exception;
    
       
    procedure char_to_int(cle: in Unbounded_String; donnee: in Unbounded_String) is
    begin
        if cle = To_Unbounded_String("\n") then
            tab_int.tab(tab_int.taille+1) := 10;
            tab_int.taille := tab_int.taille + 1;
        elsif cle = To_Unbounded_String("\$") then
            indice := tab_int.taille;
        else
            tab_int.tab(tab_int.taille+1) := Character'Pos(To_String(cle)(1));  
            tab_int.taille := tab_int.taille + 1;
        end if;
    end char_to_int;
    
    procedure Completion_octet(Suite_binaire : in out Unbounded_String) is
    begin
        for i in 1..(8 - length(Suite_binaire) mod 8) loop
            Suite_binaire := Suite_binaire & "0";
        end loop;
    end Completion_octet;
        
    
    procedure Enregistrer_tab is new Pour_chaque(char_to_int);
        
begin
   
    -- Verification des arguments
    if Argument_Count = 0 then
        raise Argument_error;
    elsif Argument_Count = 1 then
        Argument_affichage := To_Unbounded_String("");
        Argument_fichier := To_Unbounded_String(Argument(1));
    else
        Argument_affichage := To_Unbounded_String(Argument(1));
        Argument_fichier := To_Unbounded_String(Argument(2));
    end if; 
      
  
   
    Initialiser(Tableau_AB);
   
    open (file_txt, In_File, To_String(Argument_fichier)); 	-- Ouverture du fichier en lecture 
    
    -- Calcul des fréquences d'apparition des caracteres
    while not End_Of_File(file_txt) loop
        Str_save := To_Unbounded_String(" ");
        Get_immediate (file_txt, un_char);
        Replace_Element(Str_save,1,un_char);
        if un_char = character'val(10) then -- Detection du retour a la ligne
            if not (Valeur_existe(Tableau_AB, To_Unbounded_String("\n"))) then
                Enregistrer(Tableau_AB, 1, To_Unbounded_String("\n"));
            else
                Incrementer(Tableau_AB, indice_valeur(Tableau_AB, To_Unbounded_String("\n")));
            end if;
        else -- Enregistrement de la nouvelle valeur si nécessaire sinon incrementation de sa valeur fréquence
            if not (Valeur_existe(Tableau_AB, Str_save)) then
                Enregistrer(Tableau_AB, 1, Str_save);
            else
                Incrementer(Tableau_AB, indice_valeur(Tableau_AB, Str_save));
            end if;
        end if;    
    end loop;
    Enregistrer(Tableau_AB, 0, To_Unbounded_String("\$"));

    -- Fermer le fichier
    Close (file_txt);
    
    -- Tri du tableau dans l'ordre croissant
    Tri_Tab(Tableau_AB);
    
    --La construction de l'arbre de Hufman
    -- afficher_tab(Tableau_AB);
    
    while Taille(Tableau_AB) > 1 loop
        Associer(Tableau_AB, 1, 2, To_Unbounded_String("0"));
    end loop;
        
    -- afficher_tab(Tableau_AB);
    
    Extraction_arbre(Tableau_AB, Arbre_Huffman_1, 1); -- Récuperation de l'arbre d'Huffman qui est dans le tableau
    
    -- Parcours infixe pour rÃ©cuperer le codage de chaque caractÃ¨re
    Initialiser(LCA_cara_code);   
    Parcours_infixe(Arbre_Huffman_1, LCA_cara_code, Parcours_Huffman, Parcours_caractere);   
   
    -- Put("'" & To_String(Parcours_Huffman) & "'");
    -- New_Line;
    -- Afficher_codage(LCA_cara_code);
    --crÃ©ation du fichier
    create(file_hff, Out_File, To_String(Argument_fichier) & ".hff"); -- CrÃ©ation / Ã©criture
    tab_int.taille := 1;
    Enregistrer_tab(LCA_cara_code);
    tab_int.tab(1) := indice;
    tab_int.tab(tab_int.taille + 1) := tab_int.tab(tab_int.taille);
    tab_int.taille := tab_int.taille + 1;
    for i in 1..tab_int.taille loop
        Octet := T_Octet(tab_int.tab(i));
        write(file_hff, Octet);
    end loop;
    Parcours_Huffman := Parcours_Huffman & "1";
    Completion_octet(Parcours_Huffman); -- Remplissage du dernier octet s'il n'est pas complets
    
    -- Ecriture du parcours infixe dans le fichier compressé 
    for i in 0..(length(Parcours_Huffman) / 8) - 1 loop
        write(file_hff, horner(To_Unbounded_String(To_String(Parcours_Huffman)(8*i+1..8*(i+1)))));
    end loop;
    
   
    
    -- Le codage du texte
    open (file_txt, In_File, To_String(Argument_fichier)); 	-- Ouverture du fichier en lecture 
    indice_code := 0;
    while not End_Of_File(file_txt) loop
        indice := 1;
        Str_save := To_Unbounded_String(" ");
        Get_immediate (file_txt, un_char);
        Replace_Element(Str_save,1,un_char);
        if un_char = character'val(10) then
            Str_save := To_Unbounded_String("\n");
        else
            null;
        end if;
        while indice<=Length(La_Donnee(LCA_cara_code, Str_save)) loop
            texte_code := texte_code & To_String(La_Donnee(LCA_cara_code, Str_save ))(indice);
            indice_code := indice_code + 1;
            if indice_code mod 8 = 0 then
                write(file_hff, horner(texte_code));
                texte_code := To_Unbounded_String("");
            else
                null;
            end if;
            indice := indice + 1;
        end loop;
    end loop;
    
    indice := 1;
    while indice<=Length(La_Donnee(LCA_cara_code, To_Unbounded_String("\$"))) loop
        texte_code := texte_code & To_String(La_Donnee(LCA_cara_code, To_Unbounded_String("\$") ))(indice);
        indice_code := indice_code + 1;
        if indice_code mod 8 = 0 then
            write(file_hff, horner(texte_code));
        else
            null;
        end if;
        indice := indice + 1;
    end loop;
    Completion_octet(texte_code); -- Remplissage octet de fin
    write(file_hff, horner(texte_code));
    
    -- Fermer les fichiers
    Close (file_txt);
    Close(file_hff);
   
    -- Affichage codage ou arbre
    if To_String(Argument_affichage) = "-b" or To_String(Argument_affichage) = "--bavard" then
        affichage_arbre(Arbre_Huffman_1, 0);
        New_Line;
        Afficher_codage(LCA_cara_code);
        New_Line;
    else
        null;
    end if;    
    
    -- Suppresion des pointeurs
    Vider(Tableau_AB);
    Vider(LCA_cara_code);
    
exception
  
    when Argument_error =>
        Put("Arguments manquants");
    when ADA.IO_Exceptions.Name_Error =>
        Put("Le fichier n'existe pas");
end Compresser;
