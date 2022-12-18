with Ada.Text_IO;           use Ada.Text_IO;
--with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Tableau;

procedure tableau_test is
    Taille_table : Constant Integer := 256;
    package tab_test is
            new Tableau(Taille_table);
    use tab_test;
    
    Tableau_AB : T_Tableau;

begin
    Initialiser(Tableau_AB);

    pragma Assert(Est_Vide(Tableau_AB));

    Enregistrer(Tableau_AB,1,To_Unbounded_String("un"));
    Enregistrer(Tableau_AB,2,To_Unbounded_String("deux"));
    Enregistrer(Tableau_AB,5,To_Unbounded_String("cinq"));
    Enregistrer(Tableau_AB,3,To_Unbounded_String("trois"));
    --Enregistrer(Tableau_AB,8,To_Unbounded_String("huit"));

    Afficher_Tab(Tableau_AB);
    
    New_Line;

    Echanger(Tableau_AB,2,3);

    Afficher_Tab(Tableau_AB);
    
    New_Line;

    Associer(Tableau_AB,2,3);
    
    Afficher_Tab(Tableau_AB);
    
    New_Line;
    
    Associer(Tableau_AB,1,2);

    Afficher_Tab(Tableau_AB);
    
    Supprimer(Tableau_AB, 1);
    
    Afficher_Tab(Tableau_AB);

    Vider(Tableau_AB);

    Put("Les tests sont finis");
end tableau_test;
