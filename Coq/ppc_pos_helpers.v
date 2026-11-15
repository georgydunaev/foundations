(* ========================================================================= *)
(* Coq/ppc_pos_helpers.v                                                     *)
(* Structural Decomposition, Contravariance Lemmas, and Sufficient           *)
(* Conditions for the Open Self-Positivity Conjecture (ppc_pos)              *)
(*                                                                           *)
(* Companion to Coq/positive_foundations.v (does not mutate compiled .vo).   *)
(* Every helper lemma and sufficient condition in this file closes with Qed. *)
(* ========================================================================= *)

Require Import Coq.Bool.Bool.
Require Import Setoid.

(* ------------------------------------------------------------------------- *)
(* 1. Core Stratified EqualityType & ClassOf Definitions                     *)
(*    (Mirroring Coq/positive_foundations.v for self-contained checking)     *)
(* ------------------------------------------------------------------------- *)

Definition SoundPredOf (E : Type) (E_EQ : E -> E -> Prop) : (E -> Prop) -> Prop :=
  fun (P : E -> Prop) => forall w1 w2 : E, E_EQ w1 w2 -> P w1 -> P w2.

Inductive EqualityType : Type :=
  EqG (T : Type) (T_eq : T -> T -> Prop)
      (sound_left  : forall (t : T), SoundPredOf T T_eq (fun y => T_eq y t))
      (sound_right : forall (t : T), SoundPredOf T T_eq (T_eq t)) : EqualityType.

Definition Menge (ET : EqualityType) : Type :=
  match ET with EqG E _ _ _ => E end.

Definition Gleichung (ET : EqualityType) : (Menge ET) -> (Menge ET) -> Prop :=
  match ET with EqG _ f _ _ => f end.

Definition SoundPredicate (ET : EqualityType) : ((Menge ET) -> Prop) -> Prop :=
  match ET with EqG E f _ _ => SoundPredOf E f end.

Inductive ClassOf (ET : EqualityType) : Type :=
  Constr (f : (Menge ET) -> Prop) (p : SoundPredicate ET f) : ClassOf ET.

Definition Predicate {ET : EqualityType} (C : ClassOf ET) : (Menge ET) -> Prop :=
  match C with
  | Constr _ f _ => f
  end.

Definition ClassEqOf (ET : EqualityType) (A B : ClassOf ET) : Prop :=
  match A, B with
  | Constr _ fA _, Constr _ fB _ => forall (x : Menge ET), fA x <-> fB x
  end.

Theorem ClassOf_T_eq_sound_left (ET : EqualityType) :
  forall (t : ClassOf ET),
    SoundPredOf (ClassOf ET) (ClassEqOf ET) (fun y => ClassEqOf ET y t).
Proof.
  unfold SoundPredOf, ClassEqOf.
  intros t w1 w2 H H0.
  destruct w1, w2, t.
  intro x.
  rewrite <- (H x).
  rewrite <- (H0 x).
  reflexivity.
Qed.

Theorem ClassOf_T_eq_sound_right (ET : EqualityType) :
  forall (t : ClassOf ET),
    SoundPredOf (ClassOf ET) (ClassEqOf ET) (ClassEqOf ET t).
Proof.
  unfold SoundPredOf, ClassEqOf.
  intros t w1 w2 H H0.
  destruct w1, w2, t.
  intro x.
  rewrite <- (H x).
  rewrite <- (H0 x).
  reflexivity.
Qed.

Definition ClassETOf (ET : EqualityType) : EqualityType :=
  EqG (ClassOf ET) (ClassEqOf ET)
      (ClassOf_T_eq_sound_left ET)
      (ClassOf_T_eq_sound_right ET).

Definition intersect_func {ET1 : EqualityType}
  (P : Menge (ClassETOf (ClassETOf ET1))) : (Menge ET1) -> Prop :=
  fun (y : Menge ET1) =>
    forall (U : Menge (ClassETOf ET1)), (Predicate P U) -> (Predicate U y).

Theorem intersect_sound {ET1 : EqualityType}
  (P : Menge (ClassETOf (ClassETOf ET1))) :
  SoundPredicate ET1 (intersect_func P).
Proof.
  destruct ET1.
  unfold SoundPredicate, intersect_func, SoundPredOf.
  simpl.
  intros w1 w2 H H0 U H1.
  set (Q := H0 U H1).
  destruct U as [fU pU].
  simpl in *.
  unfold SoundPredOf in pU.
  exact (pU w1 w2 H Q).
Qed.

Definition intersect_class {ET1 : EqualityType}
  (P : Menge (ClassETOf (ClassETOf ET1))) : Menge (ClassETOf ET1) :=
  Constr ET1 (intersect_func P) (intersect_sound P).

Definition binter_func {ET : EqualityType}
  (A B : Menge (ClassETOf ET)) : (Menge ET) -> Prop :=
  fun x => (Predicate A x) /\ (Predicate B x).

Theorem binter_sound {ET : EqualityType}
  (A B : Menge (ClassETOf ET)) :
  SoundPredicate ET (binter_func A B).
Proof.
  unfold SoundPredicate.
  destruct ET.
  unfold SoundPredOf, binter_func, Predicate.
  destruct A as [fA pA], B as [fB pB].
  simpl in *.
  unfold SoundPredOf in *.
  intros w1 w2 H [HA HB].
  split.
  - exact (pA w1 w2 H HA).
  - exact (pB w1 w2 H HB).
Qed.

Definition binter (ET : EqualityType)
  (A B : Menge (ClassETOf ET)) : Menge (ClassETOf ET) :=
  Constr ET (binter_func A B) (binter_sound A B).

Definition positive {ET1 : EqualityType}
  (P : Menge (ClassETOf (ClassETOf ET1))) : Prop :=
  forall (phi : Menge (ClassETOf (ClassETOf ET1))),
    (Predicate P) (intersect_class (binter _ phi P)).

Theorem positive_sound {ET1 : EqualityType} :
  SoundPredicate (ClassETOf (ClassETOf ET1)) positive.
Proof.
  unfold SoundPredicate, SoundPredOf, positive.
  intros w1 w2 Heq Hpos phi.
  destruct w1 as [f1 p1], w2 as [f2 p2].
  simpl in *.
  assert (HeqI : ClassEqOf ET1
    (intersect_class (binter (ClassETOf ET1) phi (Constr (ClassETOf ET1) f1 p1)))
    (intersect_class (binter (ClassETOf ET1) phi (Constr (ClassETOf ET1) f2 p2)))).
  {
    unfold ClassEqOf, intersect_class, intersect_func.
    intro x. simpl.
    split; intros H U [Hphi HU]; apply H; split; try exact Hphi; apply (Heq U); exact HU.
  }
  assert (Hf2_I1 : f2 (intersect_class (binter (ClassETOf ET1) phi (Constr (ClassETOf ET1) f1 p1)))).
  {
    apply (Heq (intersect_class (binter (ClassETOf ET1) phi (Constr (ClassETOf ET1) f1 p1)))).
    exact (Hpos phi).
  }
  unfold SoundPredicate, SoundPredOf in p2.
  exact (p2 _ _ HeqI Hf2_I1).
Qed.

Definition ppc {ET1 : EqualityType} :
  Menge (ClassETOf (ClassETOf (ClassETOf ET1))) :=
  Constr (ClassETOf (ClassETOf ET1)) positive positive_sound.

(* ------------------------------------------------------------------------- *)
(* 2. Inclusion Relations and Contravariance of Conglomerate Intersection    *)
(* ------------------------------------------------------------------------- *)

Definition subClass {ET : EqualityType} (A B : Menge (ClassETOf ET)) : Prop :=
  forall x : Menge ET, Predicate A x -> Predicate B x.

Theorem subClass_refl {ET : EqualityType} (A : Menge (ClassETOf ET)) :
  subClass A A.
Proof.
  unfold subClass; intros x Hx; exact Hx.
Qed.

Theorem subClass_trans {ET : EqualityType}
  (A B C : Menge (ClassETOf ET)) :
  subClass A B -> subClass B C -> subClass A C.
Proof.
  unfold subClass; intros HAB HBC x Hx; exact (HBC x (HAB x Hx)).
Qed.

(** Contravariance of intersect_class:
    If conglomerate A is contained in conglomerate B (subClass A B),
    then the intersection over B is contained in the intersection over A. *)
Theorem intersect_class_contravariant {ET1 : EqualityType}
  (A B : Menge (ClassETOf (ClassETOf ET1))) :
  subClass A B -> subClass (intersect_class B) (intersect_class A).
Proof.
  unfold subClass, intersect_class, intersect_func.
  simpl.
  intros HAB x HB U HUA.
  apply HB.
  exact (HAB U HUA).
Qed.

(** Monotonicity of binary intersection in the right argument. *)
Theorem binter_mono_right {ET : EqualityType}
  (psi A B : Menge (ClassETOf ET)) :
  subClass A B -> subClass (binter ET psi A) (binter ET psi B).
Proof.
  unfold subClass, binter, binter_func.
  simpl.
  intros HAB x [Hpsi HA].
  split.
  - exact Hpsi.
  - exact (HAB x HA).
Qed.

(* ------------------------------------------------------------------------- *)
(* 3. Structural Decomposition of positive (@ppc ET1)                        *)
(* ------------------------------------------------------------------------- *)

(** For a superconglomerate phi, define the restricted intersection
    I_ppc(phi) := intersect_class (binter _ phi (@ppc ET1)). *)
Definition I_ppc {ET1 : EqualityType}
  (phi : Menge (ClassETOf (ClassETOf (ClassETOf ET1)))) :
  Menge (ClassETOf (ClassETOf ET1)) :=
  intersect_class (binter (ClassETOf (ClassETOf ET1)) phi (@ppc ET1)).

(** Complete unfolding characterization of positive (@ppc ET1):
    positive (@ppc ET1) holds if and only if for every superconglomerate phi,
    every conglomerate psi, and every positive conglomerate U in phi,
    U contains intersect_class (binter _ psi (I_ppc phi)). *)
Theorem ppc_pos_unfold_iff {ET1 : EqualityType} :
  positive (@ppc ET1) <->
  (forall (phi : Menge (ClassETOf (ClassETOf (ClassETOf ET1))))
          (psi : Menge (ClassETOf (ClassETOf ET1)))
          (U   : Menge (ClassETOf (ClassETOf ET1))),
     Predicate phi U ->
     positive U ->
     Predicate U (intersect_class (binter (ClassETOf ET1) psi (I_ppc phi)))).
Proof.
  unfold positive, ppc, I_ppc.
  simpl.
  split.
  - intros H phi psi U HphiU HposU.
    exact (H phi psi U (conj HphiU HposU)).
  - intros H phi psi U [HphiU HposU].
    exact (H phi psi U HphiU HposU).
Qed.

(** Every positive conglomerate U in phi contains I_ppc(phi) as a subconglomerate. *)
Theorem I_ppc_sub_member {ET1 : EqualityType}
  (phi : Menge (ClassETOf (ClassETOf (ClassETOf ET1))))
  (U   : Menge (ClassETOf (ClassETOf ET1))) :
  Predicate phi U ->
  positive U ->
  subClass (I_ppc phi) U.
Proof.
  intros HphiU HposU W HW.
  unfold I_ppc, intersect_class, intersect_func in HW.
  simpl in HW.
  apply (HW U).
  split.
  - exact HphiU.
  - exact HposU.
Qed.

(** Crucial Inclusion Lemma:
    Because I_ppc(phi) is a subconglomerate of every positive U in phi,
    the inner intersection intersect_class (binter _ psi U) (which is guaranteed
    to lie in U by `positive U`) is a SUBCLASS of the target class
    intersect_class (binter _ psi (I_ppc phi)). *)
Theorem inner_intersection_sub_target {ET1 : EqualityType}
  (phi : Menge (ClassETOf (ClassETOf (ClassETOf ET1))))
  (psi U : Menge (ClassETOf (ClassETOf ET1))) :
  Predicate phi U ->
  positive U ->
  subClass
    (intersect_class (binter (ClassETOf ET1) psi U))
    (intersect_class (binter (ClassETOf ET1) psi (I_ppc phi))).
Proof.
  intros HphiU HposU.
  apply intersect_class_contravariant.
  apply binter_mono_right.
  exact (I_ppc_sub_member phi U HphiU HposU).
Qed.

(* ------------------------------------------------------------------------- *)
(* 4. Verified Sufficient Conditions for ppc_pos                             *)
(* ------------------------------------------------------------------------- *)

(** Condition A: Upward-Closed Conglomerates (Filter Positivity).
    A conglomerate U is upward-closed if whenever A is a subclass of B
    and A belongs to U, B also belongs to U. *)
Definition upward_closed {ET1 : EqualityType}
  (U : Menge (ClassETOf (ClassETOf ET1))) : Prop :=
  forall A B : Menge (ClassETOf ET1),
    subClass A B -> Predicate U A -> Predicate U B.

(** Theorem: For any superconglomerate phi whose positive members are
    upward-closed, I_ppc(phi) is unconditionally positive! *)
Theorem I_ppc_positive_if_upward_closed {ET1 : EqualityType}
  (phi : Menge (ClassETOf (ClassETOf (ClassETOf ET1)))) :
  (forall U : Menge (ClassETOf (ClassETOf ET1)),
     Predicate phi U -> positive U -> upward_closed U) ->
  positive (I_ppc phi).
Proof.
  intros Hup psi U [HphiU HposU].
  assert (Hsub : subClass
    (intersect_class (binter (ClassETOf ET1) psi U))
    (intersect_class (binter (ClassETOf ET1) psi (I_ppc phi)))).
  {
    exact (inner_intersection_sub_target phi psi U HphiU HposU).
  }
  assert (HU_inner : Predicate U (intersect_class (binter (ClassETOf ET1) psi U))).
  {
    exact (HposU psi).
  }
  exact (Hup U HphiU HposU
           (intersect_class (binter (ClassETOf ET1) psi U))
           (intersect_class (binter (ClassETOf ET1) psi (I_ppc phi)))
           Hsub HU_inner).
Qed.

(** Condition B: Principal / Singleton-Like Superconglomerate phi.
    If phi is generated by a single positive conglomerate U0 (up to ClassEqOf),
    then I_ppc(phi) is extensionally equal to U0 and therefore positive. *)
Theorem I_ppc_positive_if_principal {ET1 : EqualityType}
  (phi : Menge (ClassETOf (ClassETOf (ClassETOf ET1))))
  (U0  : Menge (ClassETOf (ClassETOf ET1))) :
  Predicate phi U0 ->
  positive U0 ->
  (forall U : Menge (ClassETOf (ClassETOf ET1)),
     Predicate phi U -> positive U ->
     forall W : Menge (ClassETOf ET1), Predicate U0 W -> Predicate U W) ->
  positive (I_ppc phi).
Proof.
  intros Hphi0 Hpos0 Hmin.
  assert (Heq : ClassEqOf (ClassETOf ET1) U0 (I_ppc phi)).
  {
    destruct U0 as [f0 p0].
    unfold I_ppc, ClassEqOf, intersect_class, intersect_func.
    intro W. simpl.
    split.
    - intros Hf0 U [HphiU HposU].
      exact (Hmin U HphiU HposU W Hf0).
    - intros Hall.
      apply (Hall (Constr (ClassETOf ET1) f0 p0)).
      split; [exact Hphi0 | exact Hpos0].
  }
  exact (@positive_sound ET1 U0 (I_ppc phi) Heq Hpos0).
Qed.

(* ------------------------------------------------------------------------- *)
(* 5. Complete Unconditional Proof of ppc_pos (Self-Positivity of ppc)       *)
(* ------------------------------------------------------------------------- *)

(** Absorption Lemma:
    Because I_ppc(phi) is contained in every U in phi /\ ppc, intersecting
    binter psi (I_ppc phi) with U yields a conglomerate whose intersection class
    is extensionally equal (ClassEqOf ET1) to intersect_class (binter psi (I_ppc phi)). *)
Theorem intersect_binter_absorption {ET1 : EqualityType}
  (phi : Menge (ClassETOf (ClassETOf (ClassETOf ET1))))
  (psi U : Menge (ClassETOf (ClassETOf ET1))) :
  Predicate phi U ->
  positive U ->
  ClassEqOf ET1
    (intersect_class (binter (ClassETOf ET1) (binter (ClassETOf ET1) psi (I_ppc phi)) U))
    (intersect_class (binter (ClassETOf ET1) psi (I_ppc phi))).
Proof.
  intros HphiU HposU.
  unfold ClassEqOf, intersect_class, intersect_func, binter, binter_func.
  intro x. simpl.
  split.
  - intros Hlhs W [HpsiW HIW].
    apply (Hlhs W).
    split.
    + split; [exact HpsiW | exact HIW].
    + exact (I_ppc_sub_member phi U HphiU HposU W HIW).
  - intros Hrhs W [[HpsiW HIW] _].
    apply (Hrhs W).
    split; [exact HpsiW | exact HIW].
Qed.

(** Main Theorem (ppc_pos):
    The superconglomerate ppc of all positive conglomerates is itself positive. *)
Theorem ppc_pos_unconditional {ET1 : EqualityType} :
  positive (@ppc ET1).
Proof.
  apply ppc_pos_unfold_iff.
  intros phi psi U HphiU HposU.
  set (chi := binter (ClassETOf ET1) psi (I_ppc phi)).
  assert (Hpos_chi : Predicate U (intersect_class (binter (ClassETOf ET1) chi U))).
  {
    exact (HposU chi).
  }
  assert (Heq : ClassEqOf ET1
    (intersect_class (binter (ClassETOf ET1) chi U))
    (intersect_class (binter (ClassETOf ET1) psi (I_ppc phi)))).
  {
    exact (intersect_binter_absorption phi psi U HphiU HposU).
  }
  destruct U as [fU pU].
  unfold SoundPredicate, SoundPredOf in pU.
  simpl in Hpos_chi, pU |- *.
  exact (pU _ _ Heq Hpos_chi).
Qed.

