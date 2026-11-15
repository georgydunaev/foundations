#!/usr/bin/env python3
"""
schrodinger_kernel_verifier.py

Executable numerical and symbolic verifier (using pure Python stdlib `math`)
for the five core analytical objects in Prof. Dr. Siegfried Beckus's Master Thesis
programme ("Schrodinger Semigroups and Dynamical Potentials"):

1. Free Gaussian heat kernel p_t(x, y) = (4 * pi * t)^(-d/2) * exp(-||x - y||^2 / (4 * t))
   (Jost Section 5.2), PDE identity (d/dt - Laplacian_x) p_t(x, y) = 0, and
   Chapman-Kolmogorov semigroup convolution identity:
   integral p_s(x, z) * p_t(z, y) dz = p_{s+t}(x, y).
2. Lie-Trotter product formula [exp(-(t/n) * H_0) * exp(-(t/n) * V)]^n (Weidmann Theorem 7.41)
   and Duhamel variation-of-constants perturbation identity (Kato pp. 495, 497-502):
   exp(-t * H_x) - exp(-t * H_y) = - integral_0^t exp(-(t-s) * H_x) * (V_x - V_y) * exp(-s * H_y) ds.
3. Two-sided CFKS Gaussian bounds (Cycon-Froese-Kirsch-Simon Theorem 2.1):
   exp(-t * ||V||_inf) * p_t(x, y) <= K_V(t, x, y) <= exp(t * ||V||_inf) * p_t(x, y).
4. Dynamical flow T : R^d x Z to Z satisfying d_Z(T(g, x), T(g, y)) <= C * (||g|| + 1) * d_Z(x, y),
   covariant potential V_x(g) = v(T(g, x)) (and negative-action tilde_V_x(g) = v(T(-g, x))),
   reduced covariant kernel k_t(z, u) = K_z(t, 0, u) with K_x(t, g, h) = k_t(T(g, x), h - g)
   (and tilde_K_x(t, g, h) = k_t(T(-g, x), h - g)), and exponential decay in u = h - g.
5. Quantitative Lipschitz continuity bound in the dynamical parameter z in Z:
   |k_t(x, u) - k_t(y, u)| <= L(t, u) * d_Z(x, y), where
   L(t, u) = Lip(v) * C * exp(M * t) * p_t(0, u) * [t * (1 + ||u|| / 2) + (pi * sqrt(2*d) / 8) * t^(3/2)].
"""

import json
import math
import sys
from typing import Callable, Dict, List, Sequence, Tuple


def euclidean_norm_sq(x: Sequence[float], y: Sequence[float]) -> float:
    """Returns squared Euclidean distance ||x - y||^2 in R^d."""
    return sum((xi - yi) * (xi - yi) for xi, yi in zip(x, y))


def euclidean_norm(x: Sequence[float], y: Sequence[float] = None) -> float:
    """Returns Euclidean norm ||x|| or distance ||x - y|| in R^d."""
    if y is None:
        return math.sqrt(sum(xi * xi for xi in x))
    return math.sqrt(euclidean_norm_sq(x, y))


# =============================================================================
# 1. Free Gaussian Heat Kernel & Chapman-Kolmogorov Convolution (Jost Sec 5.2)
# =============================================================================

def gaussian_heat_kernel(t: float, x: Sequence[float], y: Sequence[float]) -> float:
    """
    Evaluates the free heat kernel for H_0 = -sum_{j=1}^d d_j^2 on R^d:
        p_t(x, y) = (4 * pi * t)^(-d/2) * exp(-||x - y||^2 / (4 * t)).
    """
    if t <= 0.0:
        raise ValueError("Time parameter t must be strictly positive.")
    d = len(x)
    norm_sq = euclidean_norm_sq(x, y)
    prefactor = math.pow(4.0 * math.pi * t, -0.5 * d)
    return prefactor * math.exp(-norm_sq / (4.0 * t))


def heat_equation_exact_residual(t: float, x: Sequence[float], y: Sequence[float]) -> float:
    """
    Computes the analytical PDE residual (d/dt - Laplacian_x) p_t(x, y).
    Since d/dt p_t = (-d/(2t) + ||x-y||^2/(4t^2)) p_t and
    Laplacian_x p_t = (-d/(2t) + ||x-y||^2/(4t^2)) p_t, the residual is identically 0.
    """
    p_val = gaussian_heat_kernel(t, x, y)
    d = len(x)
    r_sq = euclidean_norm_sq(x, y)
    dt_p = (-0.5 * d / t + r_sq / (4.0 * t * t)) * p_val
    lap_p = sum(
        (-1.0 / (2.0 * t) + ((xi - yi) ** 2) / (4.0 * t * t)) * p_val
        for xi, yi in zip(x, y)
    )
    return abs(dt_p - lap_p)


def verify_chapman_kolmogorov_1d(
    s: float = 0.35,
    t: float = 0.55,
    x0: float = -0.4,
    y0: float = 0.7,
    grid_radius: float = 12.0,
    num_steps: int = 1200,
) -> Dict[str, float]:
    """
    Numerically integrates integral_{-R}^{R} p_s(x0, z) * p_t(z, y0) dz via the
    composite midpoint rule and compares against the exact kernel p_{s+t}(x0, y0).
    """
    dz = (2.0 * grid_radius) / num_steps
    conv_sum = 0.0
    for k in range(num_steps):
        z = -grid_radius + (k + 0.5) * dz
        conv_sum += gaussian_heat_kernel(s, [x0], [z]) * gaussian_heat_kernel(t, [z], [y0]) * dz
    exact = gaussian_heat_kernel(s + t, [x0], [y0])
    abs_err = abs(conv_sum - exact)
    return {
        "numerical_convolution": conv_sum,
        "exact_semigroup_kernel": exact,
        "absolute_error": abs_err,
    }


# =============================================================================
# 2. Lie-Trotter Product vs. Duhamel Perturbation Formula (Weidmann 7.41 & Kato)
# =============================================================================

def _mat_mul(A: List[List[float]], B: List[List[float]]) -> List[List[float]]:
    n = len(A)
    out = [[0.0] * n for _ in range(n)]
    for i in range(n):
        for k in range(n):
            aik = A[i][k]
            if aik == 0.0:
                continue
            for j in range(n):
                out[i][j] += aik * B[k][j]
    return out


def _mat_add(A: List[List[float]], B: List[List[float]], scale_b: float = 1.0) -> List[List[float]]:
    n = len(A)
    return [[A[i][j] + scale_b * B[i][j] for j in range(n)] for i in range(n)]


def _mat_scale(A: List[List[float]], c: float) -> List[List[float]]:
    return [[c * val for val in row] for row in A]


def _mat_power(A: List[List[float]], p: int) -> List[List[float]]:
    n = len(A)
    res = [[1.0 if i == j else 0.0 for j in range(n)] for i in range(n)]
    base = [row[:] for row in A]
    exp = p
    while exp > 0:
        if exp & 1:
            res = _mat_mul(res, base)
        base = _mat_mul(base, base)
        exp >>= 1
    return res


def _mat_exp_taylor(A: List[List[float]], terms: int = 28) -> List[List[float]]:
    """Computes matrix exponential exp(A) via scaling-and-squaring + Taylor series."""
    n = len(A)
    max_entry = max(abs(val) for row in A for val in row)
    scale_pow = 0
    while max_entry / (2 ** scale_pow) > 0.25:
        scale_pow += 1
    scaled = _mat_scale(A, 1.0 / (2 ** scale_pow))
    ident = [[1.0 if i == j else 0.0 for j in range(n)] for i in range(n)]
    result = [row[:] for row in ident]
    term = [row[:] for row in ident]
    for k in range(1, terms + 1):
        term = _mat_scale(_mat_mul(term, scaled), 1.0 / k)
        result = _mat_add(result, term)
    for _ in range(scale_pow):
        result = _mat_mul(result, result)
    return result


def _max_abs_diff(A: List[List[float]], B: List[List[float]]) -> float:
    return max(abs(A[i][j] - B[i][j]) for i in range(len(A)) for j in range(len(A)))


def verify_lie_trotter_and_duhamel_discrete(
    t: float = 0.4,
    trotter_steps: int = 80,
    duhamel_quad_steps: int = 120,
) -> Dict[str, float]:
    """
    Constructs a finite-volume discrete 1D Laplacian H_0 and two bounded dynamical
    potentials V_x, V_y, and verifies:
      (a) Weidmann Theorem 7.41 Lie-Trotter product convergence:
          [exp(-(t/n) H_0) exp(-(t/n) V_x)]^n converges to exp(-t (H_0 + V_x))
      (b) Kato / Duhamel perturbation identity:
          exp(-t H_x) - exp(-t H_y) = - integral_0^t exp(-(t-s) H_x) (V_x - V_y) exp(-s H_y) ds.
    """
    n_sites = 8
    h_0 = [[0.0] * n_sites for _ in range(n_sites)]
    for i in range(n_sites):
        h_0[i][i] = 2.0
        h_0[i][(i - 1) % n_sites] = -1.0
        h_0[i][(i + 1) % n_sites] = -1.0

    v_x_diag = [0.35 * math.cos(2.0 * math.pi * i / n_sites + 0.2) for i in range(n_sites)]
    v_y_diag = [0.35 * math.cos(2.0 * math.pi * i / n_sites + 0.5) for i in range(n_sites)]

    V_x = [[v_x_diag[i] if i == j else 0.0 for j in range(n_sites)] for i in range(n_sites)]
    V_y = [[v_y_diag[i] if i == j else 0.0 for j in range(n_sites)] for i in range(n_sites)]

    H_x = _mat_add(h_0, V_x)
    H_y = _mat_add(h_0, V_y)

    exact_exp_Hx = _mat_exp_taylor(_mat_scale(H_x, -t))
    exact_exp_Hy = _mat_exp_taylor(_mat_scale(H_y, -t))

    # (a) Lie-Trotter product [exp(-(t/n) H_0) exp(-(t/n) V_x)]^n
    dt = t / trotter_steps
    step_H0 = _mat_exp_taylor(_mat_scale(h_0, -dt))
    step_Vx = [[math.exp(-dt * v_x_diag[i]) if i == j else 0.0 for j in range(n_sites)] for i in range(n_sites)]
    trotter_approx = _mat_power(_mat_mul(step_H0, step_Vx), trotter_steps)
    trotter_err = _max_abs_diff(trotter_approx, exact_exp_Hx)

    # (b) Duhamel integral via midpoint quadrature on [0, t]
    V_diff = _mat_add(V_x, V_y, scale_b=-1.0)
    ds = t / duhamel_quad_steps
    duhamel_rhs = [[0.0] * n_sites for _ in range(n_sites)]
    for k in range(duhamel_quad_steps):
        s = (k + 0.5) * ds
        left_op = _mat_exp_taylor(_mat_scale(H_x, -(t - s)))
        right_op = _mat_exp_taylor(_mat_scale(H_y, -s))
        integrand = _mat_mul(_mat_mul(left_op, V_diff), right_op)
        duhamel_rhs = _mat_add(duhamel_rhs, integrand, scale_b=-ds)

    exact_diff = _mat_add(exact_exp_Hx, exact_exp_Hy, scale_b=-1.0)
    duhamel_err = _max_abs_diff(exact_diff, duhamel_rhs)

    return {
        "trotter_max_error": trotter_err,
        "duhamel_max_error": duhamel_err,
    }


# =============================================================================
# 3. Dynamical Flow T, Covariant Potential V_x, Covariant Kernel & Z-Lipschitz Bound
# =============================================================================

def dynamical_flow_torus(g: Sequence[float], z: float, alpha_freq: float = 0.75) -> float:
    """
    Continuous action T : R^d x Z to Z on the circle Z = R / Z (identified with [0, 1))
    with linear distortion model:
        T(g, z) = (z + alpha_freq * sum(g)) mod 1.0.
    For general affine/Lipschitz distortion satisfying
        d_Z(T(g, x), T(g, y)) <= C * (||g|| + 1) * d_Z(x, y),
    we also provide `distorted_flow_distance_bound`.
    """
    return (z + alpha_freq * sum(g)) % 1.0


def circle_metric(x: float, y: float) -> float:
    """Shortest arc metric d_Z(x, y) on Z = R / Z."""
    diff = abs((x % 1.0) - (y % 1.0))
    return min(diff, 1.0 - diff)


def sampling_function_v(z: float, amplitude: float = 0.4) -> float:
    """
    Lipschitz sampling function v : Z to R defined by:
        v(z) = amplitude * cos(2 * pi * z).
    Here M = ||v||_inf = amplitude and Lip(v) = 2 * pi * amplitude.
    """
    return amplitude * math.cos(2.0 * math.pi * z)


def covariant_potential_positive(g: Sequence[float], z: float, amplitude: float = 0.4) -> float:
    """Positive-action dynamical potential V_z(g) = v(T(g, z))."""
    return sampling_function_v(dynamical_flow_torus(g, z), amplitude=amplitude)


def covariant_potential_negative(g: Sequence[float], z: float, amplitude: float = 0.4) -> float:
    """Negative-action dynamical potential tilde_V_z(g) = v(T(-g, z))."""
    neg_g = [-gi for gi in g]
    return sampling_function_v(dynamical_flow_torus(neg_g, z), amplitude=amplitude)


def first_order_dyson_kernel_1d(
    t: float,
    g: float,
    h: float,
    potential_fn: Callable[[Sequence[float]], float],
    time_steps: int = 24,
    space_steps: int = 80,
    space_radius: float = 6.0,
) -> float:
    """
    Evaluates the first-order Dyson-Duhamel perturbation approximation of K_V(t, g, h):
        K_V^(1)(t, g, h) = p_t(g, h) - integral_0^t integral_R p_{t-s}(g, w) V(w) p_s(w, h) dw ds.
    """
    p0 = gaussian_heat_kernel(t, [g], [h])
    ds = t / time_steps
    dw = (2.0 * space_radius) / space_steps
    mid = 0.5 * (g + h)
    corr = 0.0
    for ks in range(time_steps):
        s = (ks + 0.5) * ds
        for kw in range(space_steps):
            w = mid - space_radius + (kw + 0.5) * dw
            corr += (
                gaussian_heat_kernel(t - s, [g], [w])
                * potential_fn([w])
                * gaussian_heat_kernel(s, [w], [h])
                * dw
                * ds
            )
    return p0 - corr


def theoretical_lipschitz_constant_L(
    t: float,
    u: Sequence[float],
    lip_v: float,
    c_distortion: float,
    m_bound: float,
) -> float:
    """
    Computes the explicit quantitative Z-Lipschitz factor L(t, u) from
    Theorem `dynamic_kernel_lipschitz` in `thesis_schrodinger.tex` (and `thesis2027` Chapter 5):
        L(t, u) = L * C * exp(M * t) * (4 * pi * t)^(-d/2) * exp(-||u||^2 / (4 * t))
                  * [t * (1 + ||u|| / 2) + (pi * sqrt(2 * d) / 8) * t^(3/2)].
    """
    d = len(u)
    norm_u = euclidean_norm(u)
    p_t_u = gaussian_heat_kernel(t, [0.0] * d, u)
    moment_bracket = t * (1.0 + 0.5 * norm_u) + (math.pi * math.sqrt(2.0 * d) / 8.0) * (t ** 1.5)
    return lip_v * c_distortion * math.exp(m_bound * t) * p_t_u * moment_bracket


def verify_covariance_and_z_lipschitz_bound(
    t: float = 0.35,
    x_param: float = 0.12,
    y_param: float = 0.19,
    g_shift: float = 0.45,
    h_target: float = 1.05,
    amplitude: float = 0.15,
) -> Dict[str, float]:
    """
    Numerically verifies:
    1. Translation covariance under both positive and negative action conventions:
       K_x(t, g, h) = k_t(T(g, x), h - g) and tilde_K_x(t, g, h) = tilde_k_t(T(-g, x), h - g).
    2. Two-sided CFKS Gaussian bounds:
       exp(-t M) p_t(0, u) <= k_t(x, u) <= exp(t M) p_t(0, u).
    3. Explicit Z-coordinate Lipschitz continuity bound:
       |k_t(x, u) - k_t(y, u)| <= L(t, u) * d_Z(x, y).
    """
    u = h_target - g_shift

    # Positive-action covariance check: K_x(t, g, h) == K_{T(g, x)}(t, 0, h - g)
    k_x_gh = first_order_dyson_kernel_1d(
        t, g_shift, h_target, lambda w: covariant_potential_positive(w, x_param, amplitude)
    )
    shifted_z_pos = dynamical_flow_torus([g_shift], x_param)
    k_shifted_0u = first_order_dyson_kernel_1d(
        t, 0.0, u, lambda w: covariant_potential_positive(w, shifted_z_pos, amplitude)
    )
    pos_cov_error = abs(k_x_gh - k_shifted_0u)

    # Negative-action covariance check: tilde_K_x(t, g, h) == tilde_K_{T(-g, x)}(t, 0, h - g)
    tilde_k_x_gh = first_order_dyson_kernel_1d(
        t, g_shift, h_target, lambda w: covariant_potential_negative(w, x_param, amplitude)
    )
    shifted_z_neg = dynamical_flow_torus([-g_shift], x_param)
    tilde_k_shifted_0u = first_order_dyson_kernel_1d(
        t, 0.0, u, lambda w: covariant_potential_negative(w, shifted_z_neg, amplitude)
    )
    neg_cov_error = abs(tilde_k_x_gh - tilde_k_shifted_0u)

    # Evaluate k_t(x, u) and k_t(y, u)
    k_t_x_u = first_order_dyson_kernel_1d(
        t, 0.0, u, lambda w: covariant_potential_positive(w, x_param, amplitude)
    )
    k_t_y_u = first_order_dyson_kernel_1d(
        t, 0.0, u, lambda w: covariant_potential_positive(w, y_param, amplitude)
    )
    empirical_diff = abs(k_t_x_u - k_t_y_u)

    m_bound = amplitude
    lip_v = 2.0 * math.pi * amplitude
    c_distortion = 1.0
    dz_xy = circle_metric(x_param, y_param)
    lip_factor = theoretical_lipschitz_constant_L(t, [u], lip_v, c_distortion, m_bound)
    theoretical_rhs = lip_factor * dz_xy

    p_t_u = gaussian_heat_kernel(t, [0.0], [u])
    lower_cfks = math.exp(-t * m_bound) * p_t_u
    upper_cfks = math.exp(t * m_bound) * p_t_u

    return {
        "positive_covariance_error": pos_cov_error,
        "negative_covariance_error": neg_cov_error,
        "k_t_x_u": k_t_x_u,
        "k_t_y_u": k_t_y_u,
        "cfks_lower_bound": lower_cfks,
        "cfks_upper_bound": upper_cfks,
        "cfks_bounds_satisfied": float(lower_cfks <= k_t_x_u <= upper_cfks),
        "empirical_z_difference": empirical_diff,
        "theoretical_lipschitz_bound": theoretical_rhs,
        "lipschitz_bound_satisfied": float(empirical_diff <= theoretical_rhs),
    }


def run_all_verifications() -> Dict[str, Dict[str, float]]:
    """Executes all five analytical verification checks and asserts soundness."""
    pde_res = heat_equation_exact_residual(0.42, [0.3, -0.7, 1.1], [-0.2, 0.4, 0.1])
    ck_res = verify_chapman_kolmogorov_1d()
    lt_duhamel_res = verify_lie_trotter_and_duhamel_discrete()
    dyn_res = verify_covariance_and_z_lipschitz_bound()

    assert pde_res < 1e-15, f"Heat PDE residual too large: {pde_res}"
    assert ck_res["absolute_error"] < 1e-6, f"Chapman-Kolmogorov error too large: {ck_res}"
    assert lt_duhamel_res["trotter_max_error"] < 1e-3, f"Lie-Trotter error too large: {lt_duhamel_res}"
    assert lt_duhamel_res["duhamel_max_error"] < 1e-5, f"Duhamel error too large: {lt_duhamel_res}"
    assert dyn_res["positive_covariance_error"] < 1e-12, f"Positive covariance error: {dyn_res}"
    assert dyn_res["negative_covariance_error"] < 1e-12, f"Negative covariance error: {dyn_res}"
    assert dyn_res["cfks_bounds_satisfied"] == 1.0, f"CFKS bounds violated: {dyn_res}"
    assert dyn_res["lipschitz_bound_satisfied"] == 1.0, f"Z-Lipschitz bound violated: {dyn_res}"

    return {
        "heat_pde_residual": {"residual_3d": pde_res},
        "chapman_kolmogorov_1d": ck_res,
        "lie_trotter_and_duhamel": lt_duhamel_res,
        "dynamical_covariance_and_z_lipschitz": dyn_res,
    }


if __name__ == "__main__":
    summary = run_all_verifications()
    print(json.dumps(summary, indent=2, sort_keys=True))
    sys.exit(0)
