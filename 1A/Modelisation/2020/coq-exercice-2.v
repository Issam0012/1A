Require Import Naturelle.
Section Session1_2018_Logique_Exercice_2.

Variable A B C: Prop.

Theorem Exercice_2_Naturelle : (A->B)->(((~C)->(~B))->(A->C)).
Proof.
I_imp H.
I_imp H1.
I_imp H2.
absurde H3.
I_antiT B.
E_imp A.
Hyp H.
Hyp H2.
E_imp (~C).
Hyp H1.
Hyp H3.
Qed.

Theorem Exercice_2_Coq : (A->B)->(((~C)->(~B))->(A->C)).
Proof.
Qed.

End Session1_2018_Logique_Exercice_2.

