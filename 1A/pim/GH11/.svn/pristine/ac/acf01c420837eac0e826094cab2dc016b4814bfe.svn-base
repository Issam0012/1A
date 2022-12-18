with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
-- with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Sequential_IO ;	-- pour l'accÃ¨s typÃ© aux fichiers (integer, naturel, float, etc.)
--with AB_Exceptions;         use AB_Exceptions;
with Ada.Command_line; use Ada.Command_line;
with arbre_binaire; use arbre_binaire;
with tableau;
--with lca;

procedure Compression is
    
    Taille_table : Constant Integer := 256;
    
    --Occurence : Integer := 0;
    
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
    un_octet : T_Octet;
    --un_char_test : Character;
   
    Str_save : Unbounded_String;

    package Tab is
            new tableau (Taille_table);
    use Tab;    


    Tableau_AB : T_Tableau;
    nb_arbres, nb_feuilles : integer;
    
begin

    Initialiser(Tableau_AB);
   
    open (file_txt, In_File, "file_txt.txt"); 	-- Ouverture du fichier en lecture 
   
   -- Consruction de l'arbre
    while not End_Of_File(file_txt) loop
        Str_save := To_Unbounded_String(" ");
        Get_immediate (file_txt, un_char);
        Replace_Element(Str_save,1,un_char);
        if un_char = character'val(10) then
            if not (Valeur_existe(Tableau_AB, To_Unbounded_String("\n"))) then
                Enregistrer(Tableau_AB, 1, To_Unbounded_String("\n"));
            else
                Incrementer(Tableau_AB, indice_valeur(Tableau_AB, To_Unbounded_String("\n")));
            end if;
        else
            if not (Valeur_existe(Tableau_AB, Str_save)) then
                Enregistrer(Tableau_AB, 1, Str_save);
            else
                Incrementer(Tableau_AB, indice_valeur(Tableau_AB, Str_save));
            end if;
        end if;

        --Put("Octet = " & T_Octet'Image(Octet));
        --Put(" '" & Character'Val(Octet) & "'");
        --New_Line;        
    end loop;
    --Enregistrer(Tableau_AB, 0, To_Unbounded_String("\$"));

    -- Fermer le fichier
    Close (file_txt);
    
    -- Tri du tableau dans l'ordre croissant
    Tri_Tab(Tableau_AB);
    
    --La construction de l'arbre de Hufman
    afficher_tab(Tableau_AB);
    
    while Taille(Tableau_AB) > 1 loop
        Associer(Tableau_AB, 1, 2);
    end loop;
    
        
    afficher_tab(Tableau_AB);
    
    Vider(Tableau_AB);
end Compression;
