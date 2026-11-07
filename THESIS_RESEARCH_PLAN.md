# Schrödinger kernels: research programme and working plan

This plan implements the programme attributed to Siegfried Beckus: establish the kernel foundations carefully, then study quantitative dependence on a compact dynamical parameter space. It uses twelve relative weeks, including two weeks reserved for revision and delays. No submission date or weekly workload has been supplied; dates and workload should be assigned before treating this as a calendar commitment.

## Scope and conventions

Fix a positive integer \(d\), Lebesgue measure on \(\mathbb R^d\), and the nonnegative Laplacian \(H_0=-\sum_j\partial_j^2\) on its Fourier-defined self-adjoint domain in complex \(L^2\). The baseline potential is real and essentially bounded. Write \(H=H_0+V\). The free kernel is

\[
p_t(r)=(4\pi t)^{-d/2}e^{-|r|^2/(4t)},\qquad t>0.
\]

There are three separate tasks: an abstract criterion for **separate** kernel continuity; a concrete jointly continuous kernel for bounded measurable potentials; and regularity in a dynamical parameter. Proving the first does not automatically prove the second. Neither strong convergence of Trotter products nor equality of operators by itself provides pointwise convergence of kernels.

For the dynamical problem, \(Z\) is compact metric, \(T:\mathbb R^d\times Z\to Z\) is a continuous action, \(v:Z\to\mathbb R\) is Lipschitz, and

\[
d(T(g,z),T(g,w))\leq C(1+|g|)d(z,w),\qquad V_z(g)=v(T(g,z)).
\]

Compactness makes the potentials uniformly bounded. If \(K_z(t,x,y)\) is the full kernel and \(k_t(z,r)=K_z(t,0,r)\), this convention gives

\[
K_z(t,g,h)=k_t(T(g,z),h-g).
\]

The requested expression with \(T(-g,z)\) instead corresponds to defining \(V_z(g)=v(T(-g,z))\). Keep either convention consistently; do not mix their signs. The action is a parameterization of autonomous operators, not a time-dependent potential in a nonautonomous evolution equation.

## Source verification

The bibliography keys below are present in `references.bib`. Numbered results are distinguished from bibliographic records whose theorem pages remain unchecked.

| Source | Verified content and use |
| --- | --- |
| Barry Simon, *Schrödinger Semigroups*, Bull. AMS 7 (1982), 447–526; `Simon1982Semigroups` | A.1.3, pp. 450–451, characterizes separately continuous kernels through a bounded extension from finite measures to bounded continuous functions, with specified weak dual-pair continuity; full support gives uniqueness. B.7.1, p. 475, supplies the concrete joint-continuity result, including positive time, for a broader potential class. Simon uses \(H_0=-\tfrac12\sum_j\partial_j^2\), so normalize before comparing Gaussian constants. [Publication](https://doi.org/10.1090/S0273-0979-1982-15041-8); [author-uploaded text inspected](https://www.researchgate.net/publication/243072615_Schrodinger_semigroups). |
| Jürgen Jost, *Partial Differential Equations*, third edition, 2013; `Jost2013PDE` | Theorem 5.1.2, p. 93, is a whole-space maximum principle with a Gaussian growth bound. Uniqueness follows by applying it to both signs of a difference. Section 5.2, pp. 97–98, gives the Gaussian fundamental solution and initial trace. This is not an unrestricted assertion that “the Laplacian has a unique kernel.” [Publisher/edition](https://doi.org/10.1007/978-1-4614-4809-9); [third-edition text inspected](https://nnty.fun/downloads/books/TAEL/NATURAL%20SCIENCES/MATHEMATICS/CALCULUS/DIFFERENTIAL%20EQUATIONS/Partial%20Differential%20Equations%20-%20Jurgen%20Jost%202013.pdf). |
| Tosio Kato, *Perturbation Theory for Linear Operators*, 1995 reprint of the 1980 edition; `Kato1995Perturbation` | The cited pages match this edition: IX §1.8, p. 495, treats the free heat semigroup; IX §2.1, pp. 497–498, proves bounded perturbation by the integral equation and a factorially bounded series (Theorem 2.1). Pages 499–502 broaden perturbation and convergence hypotheses. For this thesis the bounded case already suffices; general unbounded perturbation machinery is optional. [Publisher](https://doi.org/10.1007/978-3-642-66282-9); [text inspected](https://webhomes.maths.ed.ac.uk/~v1ranick/papers/kato1.pdf). |
| Joachim Weidmann, *Linear Operators in Hilbert Spaces*, 1980, translated by Joseph Szücs; `Weidmann1980Operators` | Author, translator and edition verified. The supplied reference “Theorem 7.41” for the Trotter formula still needs checking against the theorem page; the accessible institutional excerpt contained front matter only. Do not treat the supplied number as independently verified. The required bounded-potential product formula is proved directly in `295_schrodinger_semigroups.tex`, uniformly on bounded time intervals in the strong operator topology. [Publisher](https://doi.org/10.1007/978-1-4612-6027-1). |
| H. F. Trotter, *On the Product of Semi-Groups of Operators*, Proc. AMS 10(4) (1959), 545–551; `Trotter1959Product` | Original product-formula publication. Bibliographic metadata checked against the publisher-deposited Crossref record and [the author’s Princeton bibliography](https://web.math.princeton.edu/WebCV/TrotterBib.html). The original AMS article text returned HTTP 403, so no theorem number or precise original hypotheses are claimed as inspected. The thesis proves its bounded-potential version directly. [Publication](https://doi.org/10.1090/S0002-9939-1959-0108732-6). |
| H. L. Cycon, R. G. Froese, W. Kirsch and B. Simon, *Schrödinger Operators*, 1987; `CyconFroeseKirschSimon1987` | Theorem 2.1, p. 13, in the publisher's 2008 reprint preview states boundedness of the semigroup from \(L^p\) to \(L^q\) for \(1\leq p\leq q\leq\infty\) when the potential belongs to the Kato class. This is a smoothing theorem, not itself a kernel-continuity theorem. Its free operator is \(-\sum_j\partial_j^2\), matching our normalization. The bounded-potential Gaussian bound supplies the required special case directly. [Publisher](https://link.springer.com/book/9783540167587); [theorem page inspected](https://page-one.springer.com/pdf/preview/10.1007/978-3-540-77522-5_2). |

A.1.3 needs a careful reading on noncompact spaces: finite countably additive Radon measures form the relevant dual pair with \(C_b\), but are not its entire norm dual. The thesis should explicitly specify the measure class, full-support assumption when used, boundedness of the kernel, and the meaning of continuity on both sides. The concrete application on Euclidean space can be stated cleanly with Lebesgue measure.

Broderix, Hundertmark and Leschke, `BroderixHundertmarkLeschke2000`: Theorems 5.1, 6.1, 6.3 and 6.5 were checked in the [authors' final preprint](https://arxiv.org/html/math-ph/9808004v2). Theorem 5.1, equations (5.4)–(5.9), assumes local Kato convergence of the squared vector-potential differences, their divergence differences and the scalar-potential differences, together with uniform small-scale Kato control of the approximating negative parts. It gives operator-norm convergence after a compact-set indicator on either side, for every \(1\le p\le q\le\infty\), uniformly on compact positive-time intervals; when \(p=q\), the interval may include zero. Theorem 6.1 constructs the jointly continuous interior kernel. Theorem 6.3 extends it to the closure of a regular domain, with zero boundary values. Theorem 6.5 gives uniform continuity in time and both spatial variables on a compact positive-time interval times the entire domain closure, under global Kato-type assumptions and uniform domain regularity. Equation (6.9) also provides a Brownian-bridge route to our quantitative bounded-potential estimate: the exponential difference inequality followed by the Gaussian bridge moment gives the rate. This is a consequence of their representation, not a verbatim dynamical theorem; our proof uses pointwise Duhamel. These latter two results concern a fixed potential, rather than additional potential-approximation theorems. Items 6.2 and 6.4 are remarks. The paper assumes \(d\ge2\) and kinetic normalization \(-\tfrac12\Delta\); our direct proofs cover \(d=1\) as well and use \(-\Delta\).

**Consequence for the present comparison, derived rather than quoted verbatim:** uniformly bounded, locally uniformly converging real potentials satisfy the scalar hypotheses of Theorem 5.1 with zero vector potential. Specifically, write \(g_\rho(x)=\mathbf1_{\{|x|<\rho\}}(-\log|x|)\) for \(d=2\) and \(g_\rho(x)=\mathbf1_{\{|x|<\rho\}}|x|^{2-d}\) for \(d\ge3\), with \(0<\rho\le1\). The paper's Kato norm is \(\|f\|_{\mathcal K}=\sup_x\int g_1(x-y)|f(y)|\,dy\). Then \(\|(V_n-V)\mathbf1_K\|_{\mathcal K}\le\|g_1\|_1\sup_K|V_n-V|\to0\), while a common bound \(M\) gives uniform negative-part control by \(M\|g_\rho\|_1\to0\). Apply Theorem 5.1 at \((p,q)=(1,\infty)\), localizing to a closed ball with zero in its interior, not the measure-zero singleton \(\{0\}\). Approximate point masses and the continuous representatives from Theorem 6.1 turn the operator-norm bound into a bound for all interior output points and all input points. Hence the canonical rows converge uniformly in \(t\in[\tau,b]\) and all \(r\). After normalization, their differences have the uniform weighted tail bound

\[
2e^{Mb}(4\pi\tau)^{-d/2}\exp\!\left(a|r|-\frac{|r|^2}{4b}\right),\qquad a\ge0.
\]

Splitting into a ball and its complement proves convergence in every \(C_a\) norm uniformly on compact positive-time intervals. Thus qualitative weighted canonical-kernel continuity under continuous sampling already follows from these prior results and Gaussian bounds. The manuscript's comparison must emphasize its explicit dynamical Lipschitz/Hölder rates and constants, and its explicit localized \(L^2\) Lipschitz bound including time zero; the latter topology and time interval are already covered qualitatively by Theorem 5.1. Bibliographic novelty of these quantitative estimates remains unclaimed.

Beckus and Takase, *Spectral estimates of dynamically-defined and amenable operator families*, J. Spectr. Theory 15 (2025), 563–610, `BeckusTakase2025Spectral`: [published Theorem 1.3(a)](https://ems.press/content/serial-article-files/50714) was inspected. It assumes regularity and decay of kernels and proves a spectral estimate; it does not construct the heat kernels. The final subsection of Chapter 4 proves the Euclidean heat-kernel case directly, specializing the averaged-localization method in their Lemmas 4.2–4.3 and Theorem 4.6 (also inspected). It obtains an explicit constant from smooth cutoffs, Gaussian moments, and the proved input-localized operator estimate. An equivalent-metric argument separately verifies the hypotheses of their general theorem. The resulting square-root Hausdorff estimate concerns closed heat-spectrum unions over invariant subsystems. The bottom of the subsystem spectrum inherits a Hölder bound by taking the logarithm of the maximal heat-spectrum point, with a uniform lower bound away from zero. A worked shear example distinguishes the limiting invariant circle from the orbit of its limiting phase and exhibits phase spectral discontinuity. The localization method is explicitly attributed; the Euclidean proof is supplied in detail. The result is not a continuity estimate between arbitrary individual phases or an unweighted Hausdorff estimate for unbounded generator spectra.

## Proof dependencies and completion criteria

1. **Free heat equation.** Establish Gaussian normalization, convolution, the differential equation, the initial trace for bounded continuous data, and whole-space uniqueness in a stated growth class. Identify the \(L^2\) semigroup through Fourier–Plancherel, keeping its norm initial condition distinct from a pointwise PDE condition.
2. **Abstract kernel criterion.** Prove the appropriate precise version of A.1.3 in both directions, including the measure extension, recovery through point masses, and uniqueness. Identify any strengthened local hypotheses relative to the printed statement.
3. **Bounded potentials.** Prove self-adjointness on the unchanged domain, the spectral semigroup, Duhamel's formula, the bounded-potential Trotter formula, and the convergent kernel series. Check joint continuity without differentiating the merely measurable potential. Obtain symmetry, composition, positivity and Gaussian bounds as pointwise statements for the chosen continuous kernel.
4. **Dynamical family.** Derive covariance with the selected sign convention. Prove a quantitative estimate for \(k_t(z,r)-k_t(w,r)\), with every constant's dependence on \(d,t,C,\|v\|_\infty,\operatorname{Lip}(v)\) stated. Distinguish fixed positive time, compact positive-time intervals, and behavior near zero.
5. **Decay and parameter regularity together.** Use a weighted kernel norm, for example 
   \(\|q\|_a=\sup_r e^{a|r|}|q(r)|\), with \(a>0\). Gaussian domination implies finiteness for fixed \(t>0\), but the parameter-difference estimate must be proved in that same norm. A spatially growing bound on \(V_z-V_w\) cannot simply be replaced by a uniform \(L^\infty\) Lipschitz estimate.
6. **Spectral application.** Prove the averaged cutoff commutator estimate and localize approximate eigenvectors. Recenter before matching nearby invariant subsystems, use the input-localized operator bound, and track the explicit square-root constant. Distinguish spectral unions from individual phases and bounded heat spectra from unbounded generator spectra.
7. **Research contribution.** Compare the resulting theorem with existing potential-continuity results, determine whether the quantitative metric hypothesis gives a useful refinement, and document what is known versus newly proved here. A new proof in the manuscript is not automatically a new theorem in the literature.

## Current manuscript status

The core proofs have now been written and independently reviewed within the agent team. This is mathematical manuscript review, not advisor approval or a claim of research novelty.

| File | Completed and reviewed proof content |
| --- | --- |
| `293_heat_equation.tex` | Gaussian normalization and convolution, Fourier multiplier calculation, bounded continuous initial data, cylinder and whole-space maximum principles, uniqueness, uniform initial trace on bounded uniformly continuous functions, and the failure of that trace on general bounded continuous functions. |
| `294_kernel_criterion.tex` | Precise measure-extension criterion, finite-measure regularity, point-mass recovery, separate continuity and full-support uniqueness; wider measure conventions and an example showing why norm boundedness alone does not replace weak continuity. |
| `295_schrodinger_semigroups.tex` | Bounded self-adjoint perturbation, Duhamel and Dyson constructions, joint continuity, symmetry, composition, positivity, Gaussian bounds and all-endpoint smoothing; the strong heat-equation solution class, continuous first spatial derivatives, uniform initial traces and strong semigroups on C0/BUC with the maximal initial-trace space characterized, smooth time dependence and a non-C2 example; strong Trotter convergence uniform on bounded time intervals. |
| `296_dynamical_schrodinger_kernels.tex` | Covariance and its sign counterexample; pointwise comparison, potential order and scalar shifts; Gaussian bridge estimates, weighted Lipschitz and Hölder bounds, isometric and exponentially distorted actions; qualitative weighted-kernel and localized operator continuity under continuous sampling, quantitative localized Lipschitz bounds, strong continuity, and exact global operator-norm discontinuity on a shear torus; averaged spectral localization with an explicit subsystem Hölder bound and qualitative uniform continuity under merely continuous sampling and action, continuity of the spectral bottom, and a worked phase-spectrum discontinuity. |

The baseline proof still uses the explicitly declared Fourier–Plancherel and self-adjoint spectral-calculus inputs. It does not purport to rebuild all of functional analysis from scratch. The manuscript proves the bounded-potential case; it does not reproduce the full Kato-class generality of Simon or CFKS. Strong Trotter convergence is not asserted to imply pointwise kernel convergence: the kernel series supplies the latter construction independently.

Remaining source work is specific: check Weidmann's supplied theorem number against the actual page and inspect Trotter's original theorem before attributing precise hypotheses or a theorem number to it. Neither task is a dependency of the bounded-potential product formula proved here. Retain the edition/printing qualification for the CFKS preview, and compare the precise dynamical estimate with the later potential-continuity literature before making a novelty claim. The standalone thesis compilation and final integration are checked separately from this proof-status record. Advisor review, selection of a research contribution, and submission preparation remain future work.

The schedule below is the proposed twelve-week research and revision programme, not a claim that its first seven weeks still require writing these proofs from nothing. Existing proofs give those weeks a starting manuscript to study, verify and refine; the two revision weeks remain reserved.

The final spectral argument uses the already declared self-adjoint spectral calculus and proves the Euclidean localization estimate directly. Beckus–Takase supplies the attributed method and a broader group-theoretic comparison, rather than an additional unproved premise of the Euclidean corollary.

## Twelve-week schedule

| Week | Work and concrete deliverable |
| --- | --- |
| 1 | Fix notation, action sign, dimensions, function spaces and intended strength of every result. Obtain the unchecked Weidmann theorem page and record the CFKS printing. Deliver an assumption table and corrected source map. |
| 2 | Write the free Gaussian and PDE maximum-principle chapter. Deliver complete calculations and growth-class uniqueness, with the \(L^2\) interpretation separately stated. |
| 3 | Prove the abstract measure-extension kernel criterion. Deliver both implications, the point-mass reconstruction and a note on separate versus joint continuity. |
| 4 | Complete bounded self-adjoint perturbation and semigroup foundations. Deliver domain proofs, Duhamel's formula with strong-integral justification, and the strong Trotter limit with its compact-orbit uniformity argument. |
| 5 | Complete the kernel series, Gaussian bounds and continuity. Deliver all dominated-convergence and time-endpoint estimates; prove uniqueness of the continuous representative. |
| 6 | Derive covariance and the dynamical Duhamel comparison. Deliver a checked formula with matching signs and constants, including the constant-potential and free cases. |
| 7 | Prove the Lipschitz or Hölder estimate in the specified kernel norm. Deliver a theorem with uniformity ranges in time and spatial decay; record any hypothesis needed to close the estimate. |
| 8 | Study and assess the completed Hölder-sampling extension, including its normalized Gaussian-bridge Jensen proof and weighted estimate. This planned extension is now proved and independently reviewed; use this week to decide its role in the thesis and compare its sharpness with the Lipschitz case. |
| 9 | Conduct the focused novelty comparison and sharpen examples. Deliver a table comparing assumptions, topology, rate and constants with the primary literature; decide which extension belongs in the final thesis. |
| 10 | Produce the complete thesis draft: introduction, proofs, examples, source attribution and conclusion. Deliver a draft suitable for the advisor's mathematical review. |
| 11 | Buffer for substantive corrections, missing references and proof repairs. Recheck every limit exchange, domain statement, covariance sign and quantifier. |
| 12 | Buffer for final revision, notation, bibliography, compilation and submission preparation. Freeze optional extensions and deliver the final reviewed manuscript. |

At the end of each week keep a short proof log: completed statements, unresolved gaps, sources actually checked, and next week's exact target. Request advisor feedback at the scope decision, completion of the baseline kernel proof, and selection of the research extension. If time is reduced, preserve the complete bounded-potential and dynamical arguments and drop optional extensions before sacrificing the two revision weeks.
