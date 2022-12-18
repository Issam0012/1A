(* Les règles de la déduction naturelle doivent être ajoutées à Coq. *) 
Require Import Naturelle. 

(* Ouverture d'une section *) 
Section LogiqueProposition. 

(* Déclaration de variables propositionnelles *) 
Variable A B C E Y R : Prop. 

Theorem Thm_0 : A /\ B -> B /\ A.
I_imp HAetB.
I_et.
E_et_d A.
Hyp HAetB.
E_et_g B.
Hyp HAetB.
Qed.

Theorem Thm_1 : ((A \/ B) -> C) -> (B -> C).
I_imp HAouBimpC.
I_imp HBimpC.
E_imp (A \/ B).
Hyp HAouBimpC.
I_ou_d.
Hyp HBimpC.
Qed.

Theorem Thm_2 : A -> ~~A.
I_imp HAimpnonnonA.
I_non nonnonA.
I_antiT A.
Hyp HAimpnonnonA.
Hyp nonnonA.
Qed.

Theorem Thm_3 : (A -> B) -> (~B -> ~A).
I_imp HAimpB.
I_imp nonB.
I_non nonA.
E_non B.
E_imp A.
Hyp HAimpB.
Hyp nonA.
Hyp nonB.
Qed.

Theorem Thm_4 : (~~A) -> A.
I_imp nonnonAimpA.
absurde HA.
I_antiT (~A).
Hyp HA.
Hyp nonnonAimpA.
Qed.

Theorem Thm_5 : (~B -> ~A) -> (A -> B).
I_imp nonBimpnonA.
I_imp HA.
absurde HB.
E_non A.
Hyp HA.
E_imp (~B).
Hyp nonBimpnonA.
Hyp HB.
Qed.

Theorem Thm_6 : ((E -> (Y \/ R)) /\ (Y -> R)) -> ~R -> ~E.
I_imp H_grand.
I_imp HnonR.
I_non HE.
E_non R.
E_ou Y R.
E_imp E.
E_et_g (Y -> R).
Hyp H_grand.
Hyp HE.
E_et_d (E -> Y \/ R).
Hyp H_grand.
I_imp HR.
Hyp HR.
Hyp HnonR.
Qed.

(* Version en Coq *)

Theorem Coq_Thm_0 : A /\ B -> B /\ A.
intro H.
destruct H as (HA,HB).  (* élimination conjonction *)
split.                  (* introduction conjonction *)
exact HB.               (* hypothèse *)
exact HA.               (* hypothèse *)
Qed.


Theorem Coq_E_imp : ((A -> B) /\ A) -> B.
intro H.
destruct H as (H1,H2).
cut A.
exact H1.
exact H2.
Qed.

Theorem Coq_E_et_g : (A /\ B) -> A.
intro H.
destruct H as (HA,HB).
exact HA.
Qed.

Theorem Coq_E_ou : ((A \/ B) /\ (A -> C) /\ (B -> C)) -> C.
intro H.
destruct H as (H5,H6).
destruct H5 as [H1|H2].
destruct H6 as (H3,H4).
cut A.
exact H3.
exact H1.
cut B.
destruct H6 as (H3,H4).
exact H4.
exact H2.
Qed.

Theorem Coq_Thm_7 : ((E -> (Y \/ R)) /\ (Y -> R)) -> (~R -> ~E).
intro H1.
destruct H1 as (H4,H5).
intro H2.
intro H3.
absurd R.
exact H2.
destruct H4 as [H6|H7].
exact H3.
cut Y.
exact H5.
exact H6.
exact H7.
Qed.

End LogiqueProposition.

