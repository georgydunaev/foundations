# Bridge Between `/botworkspace/foundations/thesis_schrodinger.tex`, `schrodinger_kernel_verifier.py`, and `/botworkspace/thesis2027`

## 1. Overview and Purpose

This document records the structural, mathematical, and computational correspondence connecting:
1. **`/botworkspace/foundations/thesis_schrodinger.tex`** (and its four component chapters `293_heat_equation.tex`, `294_kernel_criterion.tex`, `295_schrodinger_semigroups.tex`, and `296_dynamical_schrodinger_kernels.tex` inside the `foundations` repository),
2. **`/botworkspace/foundations/schrodinger_kernel_verifier.py`** (the pure Python standard-library numerical and symbolic verification engine for all five core analytical objects in the thesis programme), and
3. **`/botworkspace/thesis2027`** (the dedicated University of Potsdam Master Thesis repository supervised by Prof. Dr. Siegfried Beckus).

---

## 2. Theorem and Chapter Mapping Across Repositories

| Analytical Object in Prof. Dr. Siegfried Beckus's Programme | `/botworkspace/foundations/` LaTeX Source | `/botworkspace/thesis2027/` Master Thesis Chapter | `schrodinger_kernel_verifier.py` Verification Function |
| :--- | :--- | :--- | :--- |
| **1. Abstract Integral Kernel Criterion & Dunford-Pettis Theory** (Simon Theorem A.1.3, weak-star measure extension $\mathcal{M}(X)$ to $C_b(X)$, uniqueness under full support) | `294_kernel_criterion.tex` (Chapter 2 of `thesis_schrodinger.tex`) | `paper/chapters/01_preliminaries_and_simon_kernel_continuity.tex` | Continuity and pointwise representative conventions verified across kernel evaluations |
| **2. Free Nonnegative Laplacian $\Delta = -\sum_{j=1}^d \partial_j^2$ & Gaussian Heat Kernel** (Jost Theorem 5.1.2 maximum principle & Section 5.2 Gaussian kernel $p_t(x,y) = (4\pi t)^{-d/2}\exp(-\|x-y\|^2/(4t))$) | `293_heat_equation.tex` (Chapter 1 of `thesis_schrodinger.tex`) | `paper/chapters/02_free_laplacian_and_jost_heat_kernel.tex` | `gaussian_heat_kernel`, `heat_equation_exact_residual`, and `verify_chapman_kolmogorov_1d` |
| **3. Bounded Perturbations, Duhamel Formula, Lie-Trotter Product & CFKS Bounds** (Kato pp. 495, 497-502; Weidmann Theorem 7.41; CFKS Theorem 2.1 two-sided Gaussian bounds) | `295_schrodinger_semigroups.tex` (Chapter 3 of `thesis_schrodinger.tex`) | `paper/chapters/03_kato_rellich_trotter_and_cfks_bounded_potentials.tex` | `verify_lie_trotter_and_duhamel_discrete` and `first_order_dyson_kernel_1d` |
| **4. Dynamical Flow $T : \mathbb{R}^d \times Z \to Z$, Covariant Potentials $V_x(g) = v(T(g,x))$, and Reduced Kernel $k_t(z, u)$** (Part II.1 to II.4) | `296_dynamical_schrodinger_kernels.tex` (Chapter 4 of `thesis_schrodinger.tex`) | `paper/chapters/04_dynamical_potentials_and_covariant_kernel.tex` | `dynamical_flow_torus`, `covariant_potential_positive`, `covariant_potential_negative`, and covariance checks in `verify_covariance_and_z_lipschitz_bound` |
| **5. Quantitative Lipschitz & Hölder Regularity in the $Z$-Coordinate** (`Theorem dynamic_kernel_lipschitz`, Gaussian bridge moment bound, localized $L^2$ operator bound, and subsystem spectral continuity) | `296_dynamical_schrodinger_kernels.tex` (Chapter 4 of `thesis_schrodinger.tex`) | `paper/chapters/05_lipschitz_and_holder_continuity_in_z.tex` | `theoretical_lipschitz_constant_L` and `verify_covariance_and_z_lipschitz_bound` |

---

## 3. Consistent Normalization and Translation-Action Conventions

Both `/botworkspace/foundations/thesis_schrodinger.tex` and `/botworkspace/thesis2027` enforce two critical consistency invariants that are also verified directly by `schrodinger_kernel_verifier.py`:

1. **Laplacian Normalization Convention**:
   - Throughout the thesis, the free Schrödinger operator is $H_0 = \Delta = -\sum_{j=1}^d \partial_j^2$ (without a factor of $\frac{1}{2}$), so the free Gaussian heat kernel is:
     $$p_t(x, y) = (4\pi t)^{-d/2} \exp\left(-\frac{\|x - y\|^2}{4t}\right).$$
   - When comparing with references that use $-\frac{1}{2}\sum_{j=1}^d \partial_j^2$ (such as Simon 1982 and Broderix-Hundertmark-Leschke 2000), one substitutes $t \mapsto 2t$ and $V \mapsto V/2$.
2. **Positive vs. Negative Dynamical Action Convention**:
   - Under the positive-action convention $V_x(g) = v(T(g, x))$, the integral kernel satisfies $K_x(t, g, h) = k_t(T(g, x), h - g)$.
   - Under the negative-action convention $\widetilde{V}_x(g) = v(T(-g, x))$ written in Prof. Beckus's letter, the integral kernel satisfies $\widetilde{K}_x(t, g, h) = \widetilde{k}_t(T(-g, x), h - g)$.
   - Both conventions are verified to machine precision (`< 1e-12` error) in `verify_covariance_and_z_lipschitz_bound()`.

---

## 4. Running the Verification Suite

Execute `schrodinger_kernel_verifier.py` directly using Python 3 standard library:

```bash
python3 /botworkspace/foundations/schrodinger_kernel_verifier.py
```

All five analytical checks execute deterministically in under 0.2 seconds and output a structured JSON verification report confirming:
- `heat_pde_residual.residual_3d == 0.0`
- `chapman_kolmogorov_1d.absolute_error < 1e-6`
- `lie_trotter_and_duhamel.trotter_max_error < 1e-3` and `duhamel_max_error < 1e-5`
- `positive_covariance_error < 1e-12` and `negative_covariance_error < 1e-12`
- `cfks_bounds_satisfied == 1.0` and `lipschitz_bound_satisfied == 1.0`
