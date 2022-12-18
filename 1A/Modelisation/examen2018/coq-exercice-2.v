Require Import Naturelle.
Section Session1_2018_Logique_Exercice_2.

Variable A B : Prop.

Theorem Exercice_2_Naturelle : ~(A /\ B) -> (~A \/ ~B).
Proof.
I_imp H.
absurde H1.
I_antiT (A/\B).
I_et.
absurde H2.
E_non (~ A \/ ~ B).
I_ou_g.
Hyp H2.
Hyp H1.
absurde H2.
E_non (~ A \/ ~ B).
I_ou_d.
Hyp H2.
Hyp H1.
Hyp H.
Qed.

Theorem Exercice_2_Coq : ~(A /\ B) -> (~A \/ ~B).
Proof.
intros.
cut .
intro.
Qed.

End Session1_2018_Logique_Exercice_2.

