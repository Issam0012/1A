Require Import Naturelle.
Section Session1_2019_Logique_Exercice_2.

Variable A B : Prop.

Theorem Exercice_2_Naturelle : (~A) \/ B -> (~A) \/ (A /\ B).
Proof.
I_imp H.
E_ou A(~A).
TE.
I_imp H1.
I_ou_d.
I_et.
Hyp H1.
E_ou (~A) B.
Hyp H.
I_imp H2.
absurde H3.
E_non A.
Hyp H1.
Hyp H2.
I_imp H2.
Hyp H2.
I_imp H1.
I_ou_g.
Hyp H1.
Qed.

Theorem Exercice_2_Coq : (~A) \/ B -> (~A) \/ (A /\ B).
Proof.

Qed.

End Session1_2019_Logique_Exercice_2.

