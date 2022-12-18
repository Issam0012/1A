with Ada.IO_Exceptions;
with Ada.Text_IO;           use Ada.Text_IO;
--with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
-- with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Sequential_IO ;	-- pour l'accÃÂ¨s typÃÂ© aux fichiers (integer, naturel, float, etc.)
--with AB_Exceptions;         use AB_Exceptions;
with Ada.Command_line; use Ada.Command_line;
with lca;

procedure decompresser is
    
    Taille_table : Constant Integer := 256;
    
    type T_Octet is mod 2 ** 8;	-- sur 8 bits
    for T_Octet'Size use 8;
   
    package Octet_file is new Ada.Sequential_IO(T_Octet) ; 
    use Octet_file ;

    -- File_Name : String :=  "exemple_fichier.out";
    -- File      : Ada.Streams.Stream_IO.File_Type;	-- car il y a aussi Ada.Text_IO.File_Type
    file_txt : Ada.Text_IO.file_type;
    file_txt_2 : Octet_file.File_Type;
    -- S         : Stream_Access;
    un_char : Character;
    un_char_bis : Character := '$';
    un_octet : T_Octet;
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
    
    
    type t_tab_int is array (1..Taille_table) of Unbounded_String;
    type t_tab is
        record
            tab : t_tab_int;
            taille : Integer;
        end record;

   


    file_hff : Ada.Text_IO.file_type;
    -- Tableau_AB : T_Tableau;
    LCA_cara_code : T_LCA;  -- Liste des caracteres encodés dans l'ordre d'apparition du parcours infixe
    -- Arbre_Huffman : T_AB;
    Parcours_Huffman: Unbounded_String;
    Longueur_caractere: Integer := 1;
    texte_original : Unbounded_String;
    indice : integer := 1;
    indice_2, indice_carac : integer;
    tab_int : t_tab;
    Iteration_lecture : Integer := 0;  -- Compte le nombre d'iteration pour arriver a la fin du texte
    flag_recup_cara : Boolean := True;  -- Detecte la fin de la representation infixe   
    Carac_fin : Integer;  -- Emplacement du caractere '/$' dans la representation infixe et son code
    code_fin : Unbounded_String;
    Nbr_zero : Integer := 0;
    Nbr_un : Integer := 0 ;
    Octet_val : Integer;
    skip_cond : Boolean := False; -- condition de saut de boucle pour la detection de doublon
    Parcours_caractere : Unbounded_String;
    Octet_Texte : Unbounded_String := To_Unbounded_String("");
    last_code : Unbounded_String;
   
    Extension_error : exception;
    Argument_error : exception;     
    --Name_Error : exception;
    
begin
    
    tab_int.taille := 0;
   
    -- Verification des arguments
    if Argument_Count = 0 then
        raise Argument_error;
    else
        null;
    end if; 
      
    -- Verification extension fichier
    if  (Argument(1)(Length(To_Unbounded_String(Argument(1)))-3..Length(To_Unbounded_String(Argument(1)))) /= ".hff") then
        raise Extension_error;   
    else
        null;
    end if;   
   
    open (file_txt, In_File, Argument(1)); 	-- Ouverture du fichier en lecture    
   
    -- Récuperation des caractères encodés
    while not End_Of_File(file_txt) loop      
        Str_save := To_Unbounded_String(" ");
        Get_immediate (file_txt, un_char);
        Replace_Element(Str_save,1,un_char);   
        -- Récuperation de la postion du caractere de fin '/$' 
        if Iteration_lecture = 0 then
            Carac_fin := Character'Pos(un_char);
        else
            null;
        end if;
      
        -- Remplacement du saut a la ligne par des caracteres plus visuels
        if un_char = character'val(10) then
            Str_save := To_Unbounded_String("\n");
        else
            null;
        end if;
      
        -- Détéction du caractere doublon indiquant la fin des caracteres a récuperer
        if un_char = un_char_bis and flag_recup_cara then
            Longueur_caractere := Longueur_caractere + 1; 
            flag_recup_cara := False;
            skip_cond := True;
        else
            null;
        end if;
      
        -- Enregistrement des caracteres dans une LCA pour reconstruire l'arbre
        if flag_recup_cara and Iteration_lecture > 0 then          
            Longueur_caractere := Longueur_caractere + 1; 
            if Iteration_lecture = Carac_fin then -- Décalage pour ne pas prendre la place de l'indice de fin dans le parcours infixe
                --Enregistrer(LCA_cara_code,To_Unbounded_String(""),To_Unbounded_String("\$"));
                Iteration_lecture := Iteration_lecture +1;
                tab_int.tab(tab_int.taille + 1) := To_Unbounded_String("\$");
                tab_int.taille := tab_int.taille + 1;
            else
                null;
            end if;
            --Enregistrer(LCA_cara_code,To_Unbounded_String(""),Str_save);
            tab_int.tab(tab_int.taille + 1) := Str_save;
            tab_int.taille := tab_int.taille + 1;
            --Put(un_char);                      
            un_char_bis := un_char;   
            
        elsif not(flag_recup_cara) and not skip_cond and Nbr_un /= (Nbr_zero + 1) then  -- Récupération parcours infixe
            Octet_val := Character'Pos(un_char);
            --Put(Octet_val);
            --New_line;
            for i in reverse 1..8 loop -- Conversion de la valeur du caractere en bits
                if Octet_val >= (2**(i-1)) and Nbr_un /= (Nbr_zero + 1) then
                    Octet_val := Octet_val - 2**(i-1);
                    Parcours_Huffman := Parcours_Huffman & "1";
                    Nbr_un := Nbr_un + 1;
                elsif Octet_val < (2**(i-1)) and Nbr_un /= (Nbr_zero + 1) then
                    Parcours_Huffman := Parcours_Huffman & "0";
                    Nbr_zero := Nbr_zero + 1;                  
                else
                    null;               
                end if;  
            end loop;  
            
        else -- Récuperation du texte encodé
            Octet_val := Character'Pos(un_char);
            --Put(Octet_val);
            for i in reverse 1..8 loop -- Conversion de la valeur du caractere en bits
                if Octet_val >= (2**(i-1)) then
                    Octet_val := Octet_val - 2**(i-1);
                    Octet_Texte := Octet_Texte & "1";                           
                else 
                    Octet_Texte := Octet_Texte & "0";                          
                end if;
            end loop;
        end if;    
        skip_cond := False; -- Reinitialisation du passage de la boucle de détéction du doublon
        Iteration_lecture := Iteration_lecture + 1;
    end loop;   
    Parcours_Huffman := To_Unbounded_String(To_String(Parcours_Huffman)(1..length(Parcours_Huffman) - 1));    
    
    --La récupération des codes des caractère 
    indice_2 := 1;
    indice_carac := 1;
    while indice_2 < length(Parcours_Huffman) loop
        
        Parcours_caractere := Parcours_caractere & To_String(Parcours_Huffman)(indice_2);
        
        if To_String(Parcours_Huffman)(indice_2 + 1) = '1' then
            if indice_carac = Carac_fin then
                LCA_codage.Enregistrer(LCA_cara_code, Parcours_caractere, To_Unbounded_String("\$"));
                code_fin := Parcours_caractere;
            else
                LCA_codage.Enregistrer(LCA_cara_code, Parcours_caractere, tab_int.tab(indice_carac));
            end if;
            indice_carac := indice_carac + 1;
            while To_String(Parcours_caractere)(length(Parcours_caractere)) /= '0' loop
                Parcours_caractere := To_Unbounded_String(To_String(Parcours_caractere)(1..length(Parcours_caractere)-1));
            end loop;
            Parcours_caractere := To_Unbounded_String(To_String(Parcours_caractere)(1..length(Parcours_caractere)-1));
        else
            null;
        end if;

        indice_2 := indice_2 + 1;
    end loop;
    Parcours_caractere := Parcours_caractere & To_String(Parcours_Huffman)(length(Parcours_Huffman));
    if indice_carac = Carac_fin then
        LCA_codage.Enregistrer(LCA_cara_code, Parcours_caractere, To_Unbounded_String("\$"));
        code_fin := Parcours_caractere;
    else
        LCA_codage.Enregistrer(LCA_cara_code, Parcours_caractere, tab_int.tab(indice_carac));
    end if;
    
    -- Fermer le fichier
    Close (file_txt);  
   
    --Put(Longueur_caractere);
    --New_Line;
    --Put(To_String(Parcours_Huffman));
    --New_Line;
    --Put(To_String(Parcours_debordement));
    --New_Line;
    -- Affichage tableau de caractere 
    --Afficher_codage(LCA_cara_code);
    --New_Line;
    --Put(To_String(Octet_Texte));
    --New_Line;    
    Octet_Texte := To_Unbounded_String(To_String(Octet_Texte)(17..Length(Octet_Texte)));
    --Put(To_String(Octet_Texte));
    --New_Line;
    
    
    --récupération du texte original
    create(file_txt_2, Out_File, Argument(1)(1..length(To_Unbounded_String( Argument(1)))-4)); -- CrÃ©ation / Ã©criture

    
    indice := 1;
    while texte_original /= code_fin loop
        texte_original := texte_original & To_String(Octet_Texte)(indice);
        if Cle_presente(LCA_cara_code, texte_original) then
            if La_Donnee(LCA_cara_code, texte_original) = To_Unbounded_String("\n") then
                write(file_txt_2, T_Octet(10));
                last_code := texte_original;
                texte_original := To_Unbounded_String("");
            elsif La_Donnee(LCA_cara_code, texte_original) = To_Unbounded_String("\$") then
                null;
            else
                un_octet := T_Octet(Character'Pos(To_String(La_Donnee(LCA_cara_code, texte_original))(1)));
                write(file_txt_2, un_octet);
                last_code := texte_original;
                texte_original := To_Unbounded_String("");
            end if;
        else
            null;
        end if;
        indice := indice +1;
    end loop;
    if La_Donnee(LCA_cara_code, last_code) = To_Unbounded_String("\n") then
        write(file_txt_2, T_Octet(10));
    else
        null;
    end if;
        
    -- Fermer le fichier
    Close (file_txt_2);  
    
    -- Suppresion des pointeurs
    Vider(LCA_cara_code);
  
exception
    when Extension_error =>
        Put("problème d'extension");
    when ADA.IO_Exceptions.Name_Error =>
        Put("Le fichier n'existe pas");
    when Argument_error =>
        Put("Arguments manquants");
end decompresser;
