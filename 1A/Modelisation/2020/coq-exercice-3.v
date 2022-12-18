Require Import Naturelle.
Section Session1_2019_Logique_Exercice_2.

Variable A B C: Prop.

Theorem Exercice_2_Naturelle : ((A->B)/\(B->C))->(A->C).
Proof.
I_imp H.
I_imp H1.
E_imp B.
E_et_d (A->B).
Hyp H.
E_imp A.
E_et_g (B->C).
Hyp H.
Hyp H1.
Qed.

Theorem Exercice_2_Coq : ((A->B)/\(B->C))->(A->C).
Proof.
intros.
destruct H.
cut B.
exact H1.
cut A.
exact H.
exact H0.
Qed.

End Session1_2019_Logique_Exercice_2.

