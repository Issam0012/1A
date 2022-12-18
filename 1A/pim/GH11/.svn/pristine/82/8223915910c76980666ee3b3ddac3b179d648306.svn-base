with LCA;
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO; use Ada.Text_IO.Unbounded_IO;


procedure LCA_Sujet is


    package LCA_String_Integer is
            new LCA(T_Cle    => Unbounded_String,
                    T_Donnee => Integer);
    use LCA_String_Integer;

    procedure Afficher_S_I(Cle : in Unbounded_String; Donnee : in Integer) is
    begin
        Put("==");
        Put('[');
        Put (Donnee,1);
        Put('|');
        Put (Cle);
        Put(']');
    end Afficher_S_I;

    procedure Afficher_LCA is new LCA_String_Integer.Pour_Chaque (Afficher_S_I);

    LCA : T_LCA;

begin

    Initialiser(LCA);
    Enregistrer(LCA,To_Unbounded_String("un"),1);
    Enregistrer(LCA,To_Unbounded_String("deux"), 2);
    Afficher_LCA(LCA);
    Vider(LCA);

end LCA_Sujet;
