Require Import Naturelle.
Section Session1_2019_Logique_Exercice_1.

Variable A B C : Prop.

Theorem Exercice_1_Naturelle :  ((~A)/\(A\/B))->B.
Proof.
I_imp H.
E_ou A B.
E_et_d (~A).
Hyp H.
I_imp H1.
E_antiT.
I_antiT A.
Hyp H1.
E_et_g (A\/B).
Hyp H.
I_imp H1.
Hyp H1.
Qed.

Theorem Exercice_1_Coq :  ((~A)/\(A\/B))->B.
Proof.
intros.
destruct H.
destruct H0.
elim H.
exact H0.
exact H0.
Qed.

End Session1_2019_Logique_Exercice_1.

