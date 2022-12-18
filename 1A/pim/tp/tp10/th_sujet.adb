with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with TH;

procedure th_sujet is

    package TH_String_Integer is
		new TH (CAPACITE => 11, T_Cle => Unbounded_String, T_Donnee => Integer, hachage => Length);
	use TH_String_Integer;


	-- Retourner une chaîne avec des guillemets autour de S
	function Avec_Guillemets (S: Unbounded_String) return String is
	begin
		return '"' & To_String (S) & '"';
	end;


	-- Afficher une Unbounded_String et un entier.
	procedure Afficher (S : in Unbounded_String; N: in Integer) is
	begin
		Put (Avec_Guillemets (S));
		Put (" : ");
		Put (N, 1);
		New_Line;
	end Afficher;

	-- Afficher la Sda.
	procedure Afficher is
        new Pour_Chaque_th (Afficher);


th_test:T_TH;
begin
    Initialiser(th_test);
    Enregistrer(th_test, To_Unbounded_String("un"),1);
    Enregistrer(th_test, To_Unbounded_String("deux"),2);
    Enregistrer(th_test, To_Unbounded_String("trois"),3);
    Enregistrer(th_test, To_Unbounded_String("quatre"),4);
    Enregistrer(th_test, To_Unbounded_String("cinq"),5);
    Enregistrer(th_test, To_Unbounded_String("quatre-vingt-dix-neuf"),99);
    Enregistrer(th_test, To_Unbounded_String("vingt-et-un"),21);
    Afficher(th_test);
    pragma Assert(Cle_Presente(th_test, To_Unbounded_String("un")));
    Vider(th_test);
end th_sujet;
