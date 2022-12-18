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
(* A COMPLETER *)
Qed.

Theorem Thm_6 : ((E -> (Y \/ R)) /\ (Y -> R)) -> ~R -> ~E.
(* A COMPLETER *)
Qed.

(* Version en Coq *)

Theorem Coq_Thm_0 : A /\ B -> B /\ A.
destruct H as (HA,HB).  (* élimination conjonction *)
split.                  (* introduction conjonction *)
exact HB.               (* hypothèse *)
exact HA.               (* hypothèse *)
Qed.


Theorem Coq_E_imp : ((A -> B) /\ A) -> B.
(* A COMPLETER *)
Qed.

Theorem Coq_E_et_g : (A /\ B) -> A.
(* A COMPLETER *)
Qed.

Theorem Coq_E_ou : ((A \/ B) /\ (A -> C) /\ (B -> C)) -> C.
(* A COMPLETER *)
Qed.

Theorem Coq_Thm_7 : ((E -> (Y \/ R)) /\ (Y -> R)) -> (~R -> ~E).
(* A COMPLETER *)
Qed.

End LogiqueProposition.

