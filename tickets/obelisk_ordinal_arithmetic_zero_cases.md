# Obelisk: specify zero cases in ordinal arithmetic

Status: proposed upstream mathematical correction; generated files remain untouched.

## Evidence

The local checkout `../obeliskproofassistant.github.io/docs/axioms/ordinals.md`,
read on 2026-11-07, states all three exponentiation recurrences without a
restriction on the base, and labels the addition-of-exponents law as verified:

\[
\alpha^0=1,\qquad \alpha^{\beta+1}=\alpha^\beta\cdot\alpha,
\qquad \alpha^\lambda=\sup_{\beta<\lambda}\alpha^\beta,
\]
\[
\alpha^{\beta+\gamma}=\alpha^\beta\cdot\alpha^\gamma.
\]

## Concrete incompatibility

Even when limit stages are restricted to nonzero limits, the displayed
recurrences imply `0^n=0` for every positive finite `n`, but `0^omega=1`:
the supremum includes the term `0^0=1`. Using `1+omega=omega`, the asserted
addition-of-exponents law at base `0`, exponents `1,omega` would then give

\[
1=0^{1+\omega}=0^1\cdot0^\omega=0\cdot1=0.
\]

Thus the full package of displayed statements cannot hold as written.
This is not resolved merely by calling the exponentiation convention
nonstandard; at least one claimed law or recurrence must be restricted.

## Proposed correction

For the ordinary ordinal arithmetic intended by the dossier:

- Define `0^0=1` and `0^beta=0` for `beta>0` separately.
- Use the supremum recurrence for exponentiation at **nonzero limit**
  exponents when the base is **positive**.
- Make every addition and exponentiation limit clause explicitly require
  a nonzero limit. The book's limit-ordinal convention includes zero;
  applying the addition limit clause at zero would otherwise conflict
  with `alpha+0=alpha` for nonzero `alpha`.
- State the domain of each arithmetic law and verify the zero cases
  separately, rather than relying on monotonicity in the exponent at
  base zero.

If a different arithmetic is intentional, preserve its definition but
restrict or replace the incompatible laws and describe that local setting.
Check the actual kernel definitions and proof dependencies before renewing
the dossier's verification claims; this ticket establishes an inconsistency
in the displayed prose specification, not an inspected kernel derivation.

## Acceptance checks

Confirm `0^0=1`, `0^1=0`, `0^omega=0`, `1^omega=1`,
`2^omega=omega`, and `alpha+0=alpha`. Confirm that the exponent-addition
law handles base zero and that no limit rewrite can override the zero
equations. Regenerate exports only through their owning source pipeline.
