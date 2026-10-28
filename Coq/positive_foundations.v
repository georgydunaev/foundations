Require Import Coq.Bool.Bool.

Inductive Ens : Type :=
    sup : forall A : Type, (A -> Ens) -> Ens.


Definition Pair (A B:Ens) : Ens
 := sup bool (fun b : bool => if b then A else B).


(* Extensional equality of sets: Defines the equality relation between two sets, E1 and E2, by requiring that for every element in E1, there is a corresponding element in E2 and vice versa. *)
Fixpoint EQ (E1 E2: Ens) {struct E2}: Prop :=
  match E1, E2 with
  | sup A f, sup B g =>
           (forall x : A, exists y : B, EQ (f x) (g y)) /\
           (forall y : B, exists x : A, EQ (f x) (g y))
  end.


(* Membership on sets: Defines the membership relation between an element E1 and a set E2 by requiring that there exists an element y in the set A such that E1 is equal to f y. *)
Definition IN (E1 E2 : Ens) : Prop :=
  match E2 with
  | sup A f => exists y : A, EQ E1 (f y)
  end.


(* SoundPred: Defines a predicate P as sound if for any two sets w1 and w2, if w1 is equal to w2 and P holds for w1, then P also holds for w2. *)
Definition SoundPred
:= (fun (P:Ens->Prop)=>(forall w1 w2 : Ens, EQ w1 w2 -> P w1 -> P w2)).


(* SoundPred: Defines a predicate P as sound if for any two sets w1 and w2, if w1 is equal to w2 and P holds for w1, then P also holds for w2. *)
(* SoundPredOf: Defines a predicate P as sound for a type E with equality relation E_EQ if for any two elements w1 and w2 in E, if w1 is equal to w2 and P holds for w1, then P also holds for w2. *)
Definition SoundPredOf (E:Type) (E_EQ:E->E->Prop)
:= (fun (P:E->Prop)=>(forall w1 w2 : E, E_EQ w1 w2 -> P w1 -> P w2)).
(** From "Jech" repositiory BEGIN **)
Fixpoint EQ_tran (E1 E2 E3 : Ens) {struct E2}:
 EQ E1 E2 -> EQ E2 E3 -> EQ E1 E3.
Proof.
destruct E1 as [A1 f1], E2 as [A2 f2], E3 as [A3 f3].
intros E1eqE2 E2eqE3.
destruct E1eqE2 as [E12 E21].
destruct E2eqE3 as [E23 E32].
simpl in |- *.
split.
+ intro x1.
  destruct (E12 x1) as [x2 P12].
  destruct (E23 x2) as [x3 P23].
  exists x3. apply (EQ_tran (f1 x1) (f2 x2) (f3 x3) P12 P23).
+ intro x3.
  destruct (E32 x3) as [x2 P32].
  destruct (E21 x2) as [x1 P21].
  exists x1. apply (EQ_tran (f1 x1) (f2 x2) (f3 x3) P21 P32).
Defined.

Fixpoint EQ_sym (E1 E2 : Ens) {struct E2}: EQ E1 E2 -> EQ E2 E1.
Proof.
intro H.
destruct E1 as [A f], E2 as [B g].
simpl in * |- *.
destruct H as [A2B B2A]; split.
+ intro b. destruct (B2A b) as [a J]. exists a. apply EQ_sym with (1:=J).
+ intro a. destruct (A2B a) as [b J]. exists b. apply EQ_sym with (1:=J).
Defined.

(*Hint Resolve EQ_sym EQ_refl : zfc.*)

Theoremm EQ_sound_left (c a b : Ens) (aeqb : EQ a b)
 (H : EQ a c) : EQ b c.
Proof.
apply EQ_sym in aeqb.
eapply EQ_tran.
exact aeqb.
exact H.
Defined.
Definition EQ_sound_right (a b c : Ens) (aeqb : EQ b c)
 (H : EQ a b) : EQ a c 
:= EQ_tran _ _ _ H aeqb.

(** From "Jech" repositiory END **)


Theoremm Ens_EQ_sound_left : (forall (t:Ens), SoundPredOf Ens EQ (fun y => EQ y t) ).
Proof.
unfold SoundPredOf.
exact EQ_sound_left.
Defined.

Theoremm Ens_EQ_sound_right : (forall (t:Ens), SoundPredOf Ens EQ (EQ t) ).
Proof.
unfold SoundPredOf.
exact EQ_sound_right.
Defined.


(** Generalisation **)

Inductive EqualityType : Type :=
  EqG (T:Type) (T_eq: T -> T -> Prop)
 (sound_left  : forall (t:T), SoundPredOf T T_eq (fun y => T_eq y t) )
 (sound_right : forall (t:T), SoundPredOf T T_eq      (T_eq t)       ) : EqualityType
.

Definition Menge (ET: EqualityType) := match ET with EqG E _ _ _ => E end.
Definition Gleichung (ET: EqualityType) : ((Menge ET)->(Menge ET)->Prop) := match ET with EqG _ f _ _ => f end.

Fail (* SoundPred: Defines a predicate P as sound if for any two sets w1 and w2, if w1 is equal to w2 and P holds for w1, then P also holds for w2. *)
Definition SoundPredicate (ET:EqualityType)  := match ET with EqG E f _ _ => (SoundPredOf E f) end.
(*unnecessary*)

(* getter of the statement:*)
(* SoundPred: Defines a predicate P as sound if for any two sets w1 and w2, if w1 is equal to w2 and P holds for w1, then P also holds for w2. *)
Definition SoundPredicate (ET:EqualityType) :((Menge ET)->Prop)->Prop  := match ET with EqG E f _ _ => (SoundPredOf E f) end.

Theoremm A_eq_sound_left (A:Type): (forall (t:A), SoundPredOf A (@eq A) (fun y => @eq A y t) ).
Proof.
intros.
unfold SoundPredOf.
intros.
destruct H, H0.
reflexivity.
Defined.

Theoremm A_eq_sound_right (A:Type): (forall (t:A), SoundPredOf A (@eq A) (@eq A t) ).
Proof.
intros.
unfold SoundPredOf.
intros.
destruct H, H0.
reflexivity.
Defined.

(*
classes on equality type are exactly well-defined predicates respecting the equality
*)
Inductive ClassOf (ET:EqualityType) : Type :=
  Constr (f: (Menge ET) -> Prop) (p:SoundPredicate ET f): ClassOf ET. (* f is an indicatior function of a class *)
(** but it is only the support , we need to build a new equality type based on given **)


Definition Predicate {ET:EqualityType} : (ClassOf ET) -> ((Menge ET) -> Prop) :=
  fun C => 
  match C with
    Constr _ f p => f
  end
.

Definition ClassEqOf (ET:EqualityType) : ((ClassOf ET)->(ClassOf ET)->Prop)  :=
fun A B => match A, B with
| (Constr _ fA _), (Constr _ fB _) => forall (x:Menge ET), fA x <-> fB x (** OR => fA = fB  if we enjoy funext and propext **)
end.
Check true.

Require Import Setoid.

Theoremm ClassOf_T_eq_sound_left (ET:EqualityType): (forall (t:ClassOf ET), SoundPredOf (ClassOf ET) (ClassEqOf ET) (fun y => (ClassEqOf ET) y t) ).
Proof.
(* simple exercise *)
unfold SoundPredOf.
unfold ClassEqOf.
intros.
destruct w1, w2, t.
intros.
rewrite <- (H x).
rewrite <- (H0 x).
reflexivity.
Defined.

Theoremm ClassOf_T_eq_sound_right (ET:EqualityType): (forall (t:ClassOf ET), SoundPredOf (ClassOf ET) (ClassEqOf ET) ((ClassEqOf ET) t) ).
Proof.
(* simple exercise *)
unfold SoundPredOf.
unfold ClassEqOf.
intros.
destruct w1, w2, t.
intros.
rewrite <- (H x).
rewrite <- (H0 x).
reflexivity.
Defined.


Definition ClassETOf (ET:EqualityType) : EqualityType := 
  EqG (ClassOf ET) (ClassEqOf ET) (ClassOf_T_eq_sound_left ET) (ClassOf_T_eq_sound_right ET).

(* All types have usual equality: *)
Definition TYPE (A:Type): EqualityType := EqG A (@eq A) (A_eq_sound_left A) (A_eq_sound_right A).
(* Hierarchy: *)
Definition SET          : EqualityType := EqG Ens EQ Ens_EQ_sound_left Ens_EQ_sound_right.
Definition CLASS        : EqualityType := ClassETOf SET.
Definition CONGLOMERATE : EqualityType := ClassETOf CLASS.
(* and so on... *)

Fixpoint Universe (n:nat) : EqualityType :=
match n with
  0   => SET
| S n => ClassETOf (Universe n)
end.

Check Constr.

(* heterogeneoue membership with 1 level difference ... todo refactoring *)
Definition MEM {ET:EqualityType} : (Menge ET) -> (ClassOf ET) -> Prop := (fun x C => (Predicate C) x).
(* better not use it until it's good *)


(*forall (phi:Class -),*)
(** Defining the intersection of a conglomerate of classes **)
Section Intersection.
Context {ET1:EqualityType}. (* ET=CLASS*)
Local Definition ET2:=(ClassETOf ET1).
Local Definition ET3:=(ClassETOf ET2).
Context (P:Menge ET3).
(*
Context (P:Menge CONGLOMERATE).
*)

Definition intersect_func (* (P:Menge CONGLOMERATE)*):=
  (fun (y:Menge ET1) => forall (U:Menge ET2), ((Predicate P) U) -> ((Predicate U) y) ).

Check Constr.
Print SoundPredicate.
Check (intersect_func).

End Intersection.

Print ET3.

(* ET3:= (ClassETOf (ClassETOf ET1))*)
Theoremm intersect_sound {ET1:EqualityType} (P:Menge ET3) : SoundPredicate ET1 (intersect_func P).
Proof.
destruct ET1.
unfold SoundPredicate.
unfold intersect_func.
unfold SoundPredOf.
simpl.
intros.
set (Q:= H0 U H1).
destruct U.
simpl.
simpl in p.
simpl in * |- *.
unfold SoundPredOf in * |- *.
refine (p _ _ _ _).
exact H.
exact Q.
Defined.

Check intersect_func.
Check intersect_sound.
Check fun {ET1:EqualityType} (P:Menge ET3) 
  => Constr ET1 (intersect_func P) (intersect_sound P).

Definition intersect_class {ET1:EqualityType} (P:Menge ET3) 
  := Constr ET1 (intersect_func P) (intersect_sound P).



Section TheClassOfAllSets.

Definition V_func := (fun x : Menge SET => True).

Theoremm V_sound : SoundPredicate SET V_func.
Proof.
unfold SoundPredicate.
unfold SoundPredOf.
unfold V_func.
simpl.
trivial.
Defined.

Check Constr SET V_func V_sound.

Definition V: Menge CLASS := Constr SET V_func V_sound.

End TheClassOfAllSets.


Definition binter_func {ET:EqualityType} (A B:Menge (ClassETOf ET))
 := fun x => ((Predicate A) x) /\ ((Predicate B) x).

Theoremm binter_sound {ET:EqualityType} (A B:Menge (ClassETOf ET)) : SoundPredicate ET (binter_func A B).
Proof.
unfold SoundPredicate.
destruct ET.
unfold SoundPredOf.
unfold binter_func.
unfold Predicate.
destruct A.
destruct B.
simpl.
unfold SoundPredOf in * |- *.
intros.
destruct H0.

unfold SoundPredicate in * |- *.
unfold SoundPredOf in * |- *.
split.
+ refine (p _ _ H H0).
+ refine (p0 w1 w2 H H1).
Defined.

Definition binter (ET:EqualityType) (A B:Menge (ClassETOf ET)):= Constr ET (binter_func A B) (binter_sound A B).

Check Constr.
(*
Definition positive (P:Menge CONGLOMERATE) : Prop 
  := forall (phi:Menge CONGLOMERATE), (Predicate P) (intersect_class (binter phi P)).
*)

Definition positive {ET1: EqualityType}(P:Menge (ClassETOf (ClassETOf ET1))) : Prop 
  := forall (phi:Menge (ClassETOf (ClassETOf ET1))), (Predicate P) (intersect_class (binter _ phi P)).


Theoremm positive_sound {ET1: EqualityType} : 
SoundPredicate (ClassETOf (ClassETOf ET1)) positive.
Proof.
(* simple exercise *)
Admitted.

Check fun {ET1: EqualityType} => Constr (ClassETOf (ClassETOf ET1)) positive positive_sound.

(* superconglomerate of positive properties of classes*)
Definition ppc {ET1: EqualityType} := Constr (ClassETOf (ClassETOf ET1)) positive positive_sound.
Check ppc.

Theoremm ppc_pos {ET1: EqualityType} : positive (@ppc ET1).
Proof.
unfold positive.
unfold ppc.
(*...*)
Admitted.

Axiom Positivity : forall (P:Menge CONGLOMERATE), (positive P) -> ((Predicate P) V).



