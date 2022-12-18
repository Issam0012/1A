with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with arbre_binaire;

procedure arbre_binaire_test is

    function sum (a : in integer; b : in integer) return integer is
    begin
        return a+b;
    end sum;

    package AB is new arbre_binaire(integer, Unbounded_String, sum);
    use AB;

    procedure affichage_str (a : in Unbounded_String) is
    begin
        Put('"' & To_String(a) & '"');
    end affichage_str;

    procedure affichage_int (a : in integer) is
    begin
        Put(a, 0);
    end affichage_int;

    procedure affichage_arbre is new AB.affichage_arbre(affichage_int, affichage_str);

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
    Associer(arbre_test_1, arbre_test_2, To_Unbounded_String("0"));
    affichage_arbre(arbre_test_1,0);
    New_Line;
    Associer(arbre_test_1, arbre_test_3, To_Unbounded_String("0"));
    affichage_arbre(arbre_test_1, 0);
    Vider(arbre_test_1);
end arbre_binaire_test;
