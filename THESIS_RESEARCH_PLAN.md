# Schrödinger kernels: research programme and working plan

This plan implements the programme attributed to Siegfried Beckus: establish the kernel foundations carefully, then study quantitative dependence on a compact dynamical parameter space. It uses twelve relative weeks, including two weeks reserved for revision and delays. No submission date or weekly workload has been supplied; dates and workload should be assigned before treating this as a calendar commitment.

## Scope and conventions

Fix a positive integer (d), Lebesgue measure on (mathbb R^d), and the nonnegative Laplacian (H_0=-\sum_j\partial_j^2) on its Fourier-defined self-adjoint domain in complex (L^2). The baseline potential is real and essentially bounded. Write (H=H_0+V). The free kernel is

\[
p_t(r)=(4\pi t)^{-d/2}e^{-|r|^2/(4t)},\qquad t>0.
\]

There are three separate tasks: an abstract criterion for **separate** kernel continuity; a concrete jointly continuous kernel for bounded measurable potentials; and regularity in a dynamical parameter. Proving the first does not automatically prove the second. Neither strong convergence of Trotter products nor equality of operators by itself provides pointwise convergence of kernels.

For the dynamical problem, (Z) is compact metric, (T:\mathbb R^d\times Z\to Z) is a continuous action, (v:Z\to\mathbb R) is Lipschitz, and

\[
d(T(g,z),T(g,w))\leq C(1+|g|)d(z,w),\qquad V_z(g)=v(T(g,z)).
\]

Compactness makes the potentials uniformly bounded. If (K_z(t,x,y)) is the full kernel and (k_t(z,r)=K_z(t,0,r)), this convention gives

\[
K_z(t,g,h)=k_t(T(g,z),h-g).
\]

The requested expression with (T(-g,z)) instead corresponds to defining (V_z(g)=v(T(-g,z))). Keep either convention consistently; do not mix their signs. The action is a parameterization of autonomous operators, not a time-dependent potential in a nonautonomous evolution equation.

## Source verification

The bibliography keys below are present in `references.bib`. Numbered results are distinguished from bibliographic records whose theorem pages remain unchecked.

| Source | Verified content and use |
| --- | --- |
| Barry Simon, *Schrödinger Semigroups*, Bull. AMS 7 (1982), 447–526; `Simon1982Semigroups` | A.1.3, pp. 450–451, characterizes separately continuous kernels through a bounded extension from finite measures to bounded continuous functions, with specified weak dual-pair continuity; full support gives uniqueness. B.7.1, p. 475, supplies the concrete joint-continuity result, including positive time, for a broader potential class. Simon uses (H_0=-\tfrac12\sum_j\partial_j^2), so normalize before comparing Gaussian constants. [Publication](https://doi.org/10.1090/S0273-0979-1982-15041-8); [author-uploaded text inspected](https://www.researchgate.net/publication/243072615_Schrodinger_semigroups). |
| Jürgen Jost, *Partial Differential Equations*, third edition, 2013; `Jost2013PDE` | Theorem 5.1.2, p. 93, is a whole-space maximum principle with a Gaussian growth bound. Uniqueness follows by applying it to both signs of a difference. Section 5.2, pp. 97–98, gives the Gaussian fundamental solution and initial trace. This is not an unrestricted assertion that “the Laplacian has a unique kernel.” [Publisher/edition](https://doi.org/10.1007/978-1-4614-4809-9); [third-edition text inspected](https://nnty.fun/downloads/books/TAEL/NATURAL%20SCIENCES/MATHEMATICS/CALCULUS/DIFFERENTIAL%20EQUATIONS/Partial%20Differential%20Equations%20-%20Jurgen%20Jost%202013.pdf). |
| Tosio Kato, *Perturbation Theory for Linear Operators*, 1995 reprint of the 1980 edition; `Kato1995Perturbation` | The cited pages match this edition: IX §1.8, p. 495, treats the free heat semigroup; IX §2.1, pp. 497–498, proves bounded perturbation by the integral equation and a factorially bounded series (Theorem 2.1). Pages 499–502 broaden perturbation and convergence hypotheses. For this thesis the bounded case already suffices; general unbounded perturbation machinery is optional. [Publisher](https://doi.org/10.1007/978-3-642-66282-9); [text inspected](https://webhomes.maths.ed.ac.uk/~v1ranick/papers/kato1.pdf). |
| Joachim Weidmann, *Linear Operators in Hilbert Spaces*, 1980, translated by Joseph Szücs; `Weidmann1980Operators` | Author, translator and edition verified. The supplied reference “Theorem 7.41” for the Trotter formula still needs checking against the theorem page; the accessible institutional excerpt contained front matter only. Do not treat the supplied number as independently verified. The required bounded-potential product formula is proved directly in `295_schrodinger_semigroups.tex`, uniformly on bounded time intervals in the strong operator topology. [Publisher](https://doi.org/10.1007/978-1-4612-6027-1). |
| H. L. Cycon, R. G. Froese, W. Kirsch and B. Simon, *Schrödinger Operators*, 1987; `CyconFroeseKirschSimon1987` | Theorem 2.1, p. 13, in the publisher's 2008 reprint preview states boundedness of the semigroup from \(L^p\) to \(L^q\) for \(1\leq p\leq q\leq\infty\) when the potential belongs to the Kato class. This is a smoothing theorem, not itself a kernel-continuity theorem. Its free operator is \(-\sum_j\partial_j^2\), matching our normalization. The bounded-potential Gaussian bound supplies the required special case directly. [Publisher](https://link.springer.com/book/9783540167587); [theorem page inspected](https://page-one.springer.com/pdf/preview/10.1007/978-3-540-77522-5_2). |

A.1.3 needs a careful reading on noncompact spaces: finite countably additive Radon measures form the relevant dual pair with (C_b), but are not its entire norm dual. The thesis should explicitly specify the measure class, full-support assumption when used, boundedness of the kernel, and the meaning of continuity on both sides. The concrete application on Euclidean space can be stated cleanly with Lebesgue measure.

The later primary paper by Broderix, Hundertmark and Leschke studies continuity in potentials and jointly continuous kernels in a more general magnetic setting. It is relevant to the novelty check; matching hypotheses and the topology of its continuity conclusion is necessary before claiming that a dynamical estimate is new. [Authors' preprint](https://arxiv.org/abs/math-ph/9808004).

## Proof dependencies and completion criteria

1. **Free heat equation.** Establish Gaussian normalization, convolution, the differential equation, the initial trace for bounded continuous data, and whole-space uniqueness in a stated growth class. Identify the (L^2) semigroup through Fourier–Plancherel, keeping its norm initial condition distinct from a pointwise PDE condition.
2. **Abstract kernel criterion.** Prove the appropriate precise version of A.1.3 in both directions, including the measure extension, recovery through point masses, and uniqueness. Identify any strengthened local hypotheses relative to the printed statement.
3. **Bounded potentials.** Prove self-adjointness on the unchanged domain, the spectral semigroup, Duhamel's formula, the bounded-potential Trotter formula, and the convergent kernel series. Check joint continuity without differentiating the merely measurable potential. Obtain symmetry, composition, positivity and Gaussian bounds as pointwise statements for the chosen continuous kernel.
4. **Dynamical family.** Derive covariance with the selected sign convention. Prove a quantitative estimate for (k_t(z,r)-k_t(w,r)), with every constant's dependence on (d,t,C,\|v\|_\infty,\operatorname{Lip}(v)) stated. Distinguish fixed positive time, compact positive-time intervals, and behavior near zero.
5. **Decay and parameter regularity together.** Use a weighted kernel norm, for example 
   \(\|q\|_a=\sup_r e^{a|r|}|q(r)|\), with (a>0). Gaussian domination implies finiteness for fixed (t>0), but the parameter-difference estimate must be proved in that same norm. A spatially growing bound on (V_z-V_w) cannot simply be replaced by a uniform (L^\infty) Lipschitz estimate.
6. **Research contribution.** Compare the resulting theorem with existing potential-continuity results, determine whether the quantitative metric hypothesis gives a useful refinement, and document what is known versus newly proved here. A new proof in the manuscript is not automatically a new theorem in the literature.

The working manuscript splits these tasks between `293_heat_equation.tex`, `294_kernel_criterion.tex`, `295_schrodinger_semigroups.tex` and `296_dynamical_schrodinger_kernels.tex`. These are proof drafts subject to independent review and integration; their presence is not a claim that a thesis has been examined or that novelty has been established.

## Twelve-week schedule

| Week | Work and concrete deliverable |
| --- | --- |
| 1 | Fix notation, action sign, dimensions, function spaces and intended strength of every result. Obtain the unchecked Weidmann theorem page and record the CFKS printing. Deliver an assumption table and corrected source map. |
| 2 | Write the free Gaussian and PDE maximum-principle chapter. Deliver complete calculations and growth-class uniqueness, with the (L^2) interpretation separately stated. |
| 3 | Prove the abstract measure-extension kernel criterion. Deliver both implications, the point-mass reconstruction and a note on separate versus joint continuity. |
| 4 | Complete bounded self-adjoint perturbation and semigroup foundations. Deliver domain proofs, Duhamel's formula with strong-integral justification, and the strong Trotter limit with its compact-orbit uniformity argument. |
| 5 | Complete the kernel series, Gaussian bounds and continuity. Deliver all dominated-convergence and time-endpoint estimates; prove uniqueness of the continuous representative. |
| 6 | Derive covariance and the dynamical Duhamel comparison. Deliver a checked formula with matching signs and constants, including the constant-potential and free cases. |
| 7 | Prove the Lipschitz or Hölder estimate in the specified kernel norm. Deliver a theorem with uniformity ranges in time and spatial decay; record any hypothesis needed to close the estimate. |
| 8 | Examine one controlled extension: a Hölder sampling function or a different explicit growth bound for the action. Deliver a proof or a counterexample, not an unsupported conjectural strengthening. |
| 9 | Conduct the focused novelty comparison and sharpen examples. Deliver a table comparing assumptions, topology, rate and constants with the primary literature; decide which extension belongs in the final thesis. |
| 10 | Produce the complete thesis draft: introduction, proofs, examples, source attribution and conclusion. Deliver a draft suitable for the advisor's mathematical review. |
| 11 | Buffer for substantive corrections, missing references and proof repairs. Recheck every limit exchange, domain statement, covariance sign and quantifier. |
| 12 | Buffer for final revision, notation, bibliography, compilation and submission preparation. Freeze optional extensions and deliver the final reviewed manuscript. |

At the end of each week keep a short proof log: completed statements, unresolved gaps, sources actually checked, and next week's exact target. Request advisor feedback at the scope decision, completion of the baseline kernel proof, and selection of the research extension. If time is reduced, preserve the complete bounded-potential and dynamical arguments and drop optional extensions before sacrificing the two revision weeks.
