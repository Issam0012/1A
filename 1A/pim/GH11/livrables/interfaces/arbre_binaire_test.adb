with Ada.Text_IO;           use Ada.Text_IO;
--with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with arbre_binaire; use arbre_binaire;

procedure arbre_binaire_test is


    arbre_test_1:T_AB;
    arbre_test_2:T_AB;
    arbre_test_3:T_AB;
begin
    Initialiser(arbre_test_1);
    Initialiser(arbre_test_2);
    Initialiser(arbre_test_3);
    Enregistrer(arbre_test_1, 1, To_Unbounded_String("\n"));
    Enregistrer(arbre_test_2, 2, To_Unbounded_String("d"));
    Enregistrer(arbre_test_3, 4, To_Unbounded_String("m"));
    affichage_arbre(arbre_test_1,0);
    New_Line;
    affichage_arbre(arbre_test_2,0);
    New_Line;
    Associer(arbre_test_1, arbre_test_2);
    affichage_arbre(arbre_test_1,0);
    New_Line;
    Associer(arbre_test_1, arbre_test_3);
    affichage_arbre(arbre_test_1, 0);
    Vider(arbre_test_1);
end arbre_binaire_test;
