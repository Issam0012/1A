Require Import Naturelle.
Section Session1_2018_Logique_Exercice_1.

Variable A B : Prop.

Theorem Exercice_1_Naturelle : ~(A \/ B) -> (~A /\ ~B).
Proof.
I_imp H.
I_et.
I_non H1.
I_antiT (A\/B).
I_ou_g.
Hyp H1.
Hyp H.
I_non H1.
I_antiT (A\/B).
I_ou_d.
Hyp H1.
Hyp H.
Qed.

Theorem Exercice_1_Coq : ~(A \/ B) -> (~A /\ ~B).
Proof.
intros.
split.
intro H1.
elim H.
left.
Hyp H1.
intro H1.
elim H.
right.
Hyp H1.
Qed.

End Session1_2018_Logique_Exercice_1.

