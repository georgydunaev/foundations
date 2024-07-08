
section \<open>Intuitionistic first-order logic\<close>

theory IFOLD
  imports Pure
  abbrevs "?<" = "\<exists>\<^sub>\<le>\<^sub>1"
begin
(*
ML_file \<open>~~/src/Tools/misc_legacy.ML\<close>
ML_file \<open>~~/src/Provers/splitter.ML\<close>
ML_file \<open>~~/src/Provers/hypsubst.ML\<close>
ML_file \<open>~~/src/Tools/IsaPlanner/zipper.ML\<close>
ML_file \<open>~~/src/Tools/IsaPlanner/isand.ML\<close>
ML_file \<open>~~/src/Tools/IsaPlanner/rw_inst.ML\<close>
ML_file \<open>~~/src/Provers/quantifier1.ML\<close>
ML_file \<open>~~/src/Tools/intuitionistic.ML\<close>
ML_file \<open>~~/src/Tools/project_rule.ML\<close>
ML_file \<open>~~/src/Tools/atomize_elim.ML\<close>
*)

subsection \<open>Syntax and axiomatic basis\<close>

setup Pure_Thy.old_appl_syntax_setup
setup \<open>Proofterm.set_preproc (Proof_Rewrite_Rules.standard_preproc [])\<close>

class "term"
default_sort \<open>term\<close>

typedecl o

judgment
  Trueprop :: \<open>o \<Rightarrow> prop\<close>  (\<open>(_)\<close> 5)


subsubsection \<open>Equality\<close>

axiomatization
  eq :: \<open>['a, 'a] \<Rightarrow> o\<close>  (infixl \<open>=\<close> 50)
where
  refl: \<open>a = a\<close> and
  subst: \<open>a = b \<Longrightarrow> P(a) \<Longrightarrow> P(b)\<close>


subsubsection \<open>Propositional logic\<close>

axiomatization
  False :: \<open>o\<close> and
  conj :: \<open>[o, o] => o\<close>  (infixr \<open>\<and>\<close> 35) and
  disj :: \<open>[o, o] => o\<close>  (infixr \<open>\<or>\<close> 30) and
  imp :: \<open>[o, o] => o\<close>  (infixr \<open>\<longrightarrow>\<close> 25)
where
  conjI: \<open>\<lbrakk>P;  Q\<rbrakk> \<Longrightarrow> P \<and> Q\<close> and
  conjunct1: \<open>P \<and> Q \<Longrightarrow> P\<close> and
  conjunct2: \<open>P \<and> Q \<Longrightarrow> Q\<close> and

  disjI1: \<open>P \<Longrightarrow> P \<or> Q\<close> and
  disjI2: \<open>Q \<Longrightarrow> P \<or> Q\<close> and
  disjE: \<open>\<lbrakk>P \<or> Q; P \<Longrightarrow> R; Q \<Longrightarrow> R\<rbrakk> \<Longrightarrow> R\<close> and

  impI: \<open>(P \<Longrightarrow> Q) \<Longrightarrow> P \<longrightarrow> Q\<close> and
  mp: \<open>\<lbrakk>P \<longrightarrow> Q; P\<rbrakk> \<Longrightarrow> Q\<close> and

  FalseE: \<open>False \<Longrightarrow> P\<close>


subsubsection \<open>Quantifiers\<close>

axiomatization
  All :: \<open>('a \<Rightarrow> o) \<Rightarrow> o\<close>  (binder \<open>\<forall>\<close> 10) and
  Ex :: \<open>('a \<Rightarrow> o) \<Rightarrow> o\<close>  (binder \<open>\<exists>\<close> 10) and
  exists :: \<open>'a \<Rightarrow> o\<close> and
  unique :: \<open>'a \<Rightarrow> o\<close> and
  defined :: \<open>'a \<Rightarrow> o\<close> and
  epsilon :: \<open>('a \<Rightarrow> o) \<Rightarrow> o\<close>
where
  allI: \<open>(\<And>x. P(x)) \<Longrightarrow> (\<forall>x. P(x))\<close> and
  spec: \<open>\<lbrakk>(\<forall>x. P(x)) \<and> (exists(x)) \<rbrakk> \<Longrightarrow> P(x)\<close> and
  exI: \<open>P(x) \<and> (exists(x)) \<Longrightarrow> (\<exists>x. P(x))\<close> and
  exE: \<open>\<lbrakk>\<exists>x. P(x); \<And>x. P(x) \<Longrightarrow> R\<rbrakk> \<Longrightarrow> R\<close>


axiomatization

where
  
subsubsection \<open>Definitions\<close>

definition \<open>True \<equiv> False \<longrightarrow> False\<close>

definition Not (\<open>\<not> _\<close> [40] 40)
  where not_def: \<open>\<not> P \<equiv> P \<longrightarrow> False\<close>

definition iff  (infixr \<open>\<longleftrightarrow>\<close> 25)
  where \<open>P \<longleftrightarrow> Q \<equiv> (P \<longrightarrow> Q) \<and> (Q \<longrightarrow> P)\<close>

definition Uniq :: "('a \<Rightarrow> o) \<Rightarrow> o"
  where \<open>Uniq(P) \<equiv> (\<forall>x y. P(x) \<longrightarrow> P(y) \<longrightarrow> y = x)\<close>

definition Ex1 :: \<open>('a \<Rightarrow> o) \<Rightarrow> o\<close>  (binder \<open>\<exists>!\<close> 10)
  where ex1_def: \<open>\<exists>!x. P(x) \<equiv> \<exists>x. P(x) \<and> (\<forall>y. P(y) \<longrightarrow> y = x)\<close>

axiomatization where  \<comment> \<open>Reflection, admissible\<close>
  eq_reflection: \<open>(x = y) \<Longrightarrow> (x \<equiv> y)\<close> and
  iff_reflection: \<open>(P \<longleftrightarrow> Q) \<Longrightarrow> (P \<equiv> Q)\<close>

abbreviation not_equal :: \<open>['a, 'a] \<Rightarrow> o\<close>  (infixl \<open>\<noteq>\<close> 50)
  where \<open>x \<noteq> y \<equiv> \<not> (x = y)\<close>
end