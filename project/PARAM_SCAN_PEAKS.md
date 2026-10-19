# Parameter scans of W/W_N(U, V_SO, Δ_t): peaks and non-monotonic features

Scripts: `ultrasonic/param_scans_peaks.py` (coarse fixed-T/Tc survey),
`ultrasonic/param_scan_features.py` (fixed-T ensembles, peak detection, refinement,
artifact checks), `ultrasonic/make_param_figures.py` (figures).
Data: `ultrasonic/results/param_scans_coarse.json`, `param_features.json`,
`param_features_summary.json`, `param_features_peaks.json`, logs `param_scans_log.txt`,
`param_features_log.txt`.  Reproduce: `python param_scans_peaks.py &&
python param_scan_features.py && python make_param_figures.py` (~15 min, 2 cores).

## 0. Honest summary

* **Primary channel (η=+1, signed ξξ′, scattering only — the standing convention of this
  project): NO peaks.**  Of 1320 curves (8 channels × 3 scans × families), 1292 are
  strictly monotone; 15 fail strict monotonicity only inside numerically flat tails
  (|values| < 10⁻⁶, e.g. the exponentially suppressed side); 13 prominent local maxima
  exist **only in the physical total attenuation** (scattering + pair creation).
* **The physical total W/W_N = (S_sc + S_pair)/S_N at fixed temperature shows sharp,
  robust peaks of height 1.32–1.58** — above the normal-state value 1 — located in the
  wedge where the superconducting dome is open (T_c ≳ T) *and* the pair-creation channel
  is open (2 E_min < ħω).  Positions are stable under 13- and 25-point refinement
  (shifts ≤ 0.06 in Δ_t, ≤ 0.012 in V_SO; ≤ 1.3 in U where the coarse step is 7.5).
* **Case-II channel (η=−1 kernel): no resonance peaks** in the scanned ranges at fixed T
  (monotone); the Hebel–Slichter resonance of this model lives in the T-direction at
  fixed ω (already documented, T6), not in these parameter directions.
* Nothing was tuned to manufacture peaks: the peak mechanism below is a consequence of
  the model's own gap structure and of the pair channel that REPORT Appendix A derives.

## 1. Why the primary channel cannot peak (mechanism of the monotone curves)

The quasiparticle gap is E_min = |D0 − b·μ|/κ with b = Δˢ/4t.  The ridge E_min → 0
(D0 = b·μ, i.e. the effective gap Δ̄(ε) = D0 − b·ε vanishing at the Fermi energy) is
where one would naively expect a gapless peak.  The stage-1 solution shows that this
ridge **coincides with the collapse of the superconducting dome**: e.g. at (U=95,
V_SO=0) the ridge is reached at Δ_t ≈ 3.0–3.25 where T_c = 3·10⁻⁴ t, and at
(U≈180–200, Δ_t=4.5) where T_c = 4·10⁻⁴ t.  At fixed T/T_c both Δ(T) and T shrink
there, and the ratio dies smoothly (≈ 2f(Δ/T) with Δ/T finite); at fixed T the state
becomes normal and the ratio saturates at the normal golden-rule value.  Hence every
primary-channel curve is monotone or sigmoidal (dome crossing), see
`figures/param_scan_diagnostics.png`(a,b,d) and panels (a),(b) of the three scan figures.

## 2. The peaks: physical total (scattering + pair creation) at fixed T

When 2 E_min(T) < ħω the physical attenuation acquires the pair-creation channel
(S_pair, weight 1−f−f′, coherence 1−C_I; REPORT Appendix A; the PP channel of Sardwal
et al., arXiv:2608.19079, Eqs. A6–A9).  Inside the pair-open window the constructive
pair coherence factor makes the total **exceed** the normal-state absorption (W/W_N > 1,
a coherence-enhancement overshoot), while

* on the small-gap side the dome collapses and the Δ→0 sum rule forces the total → 1
  (the exact plateaux at 1.00 in the figures), and
* on the large-gap side the threshold 2 E_min = ħω closes the pair channel and the
  scattering part is exponentially suppressed → total → 0.

A sharp maximum therefore sits just inside the pair-open wedge.  Refined peaks:

| scan | fixed (·,·) | T/t | x* | W/W_N | parab. vertex | dense re-scan | shift | dev nell×2 | dev k-space |
|---|---|---|---|---|---|---|---|---|---|
| U | V_SO=0, Δ_t=4.5 | 0.10 | 105.0 | 1.561 | 105.60 | 104.58 | 1.02 | 1e-10 | 2.7e-3 |
| U | V_SO=0, Δ_t=4.5 | 0.20 | 98.8 | 1.389 | 99.33 | 98.13 | 1.21 | 1e-08 | 2.4e-3 |
| U | V_SO=0.4082, Δ_t=4.5 | 0.10 | 116.3 | 1.492 | 116.85 | 115.52 | 1.33 | 2e-09 | 1.3e-2 |
| U | V_SO=0.4082, Δ_t=4.5 | 0.20 | 108.8 | 1.363 | 109.34 | 108.65 | 0.69 | 1e-07 | 3.8e-2 |
| V_SO | U=125, Δ_t=4.5 | 0.10 | 0.552 | 1.399 | 0.544 | 0.556 | 0.012 | 6e-09 | 1.8e-2 |
| V_SO | U=125, Δ_t=4.5 | 0.20 | 0.567 | 1.576 | 0.573 | 0.569 | 0.003 | 2e-05 | 1.5e-1 |
| Δ_t | U=95, V_SO=0 | 0.10 | 4.250 | 1.560 | 4.230 | 4.260 | 0.030 | 1e-10 | 2.3e-3 |
| Δ_t | U=95, V_SO=0 | 0.20 | 4.417 | 1.405 | 4.398 | 4.420 | 0.023 | 2e-08 | 9.3e-3 |
| Δ_t | U=95, V_SO=0.4082 | 0.10 | 4.000 | 1.480 | 3.981 | 4.028 | 0.047 | 2e-09 | 1.3e-2 |
| Δ_t | U=125, V_SO=0 | 0.10 | 4.958 | 1.552 | 4.939 | 4.976 | 0.037 | 1e-10 | 2.7e-3 |
| Δ_t | U=125, V_SO=0 | 0.20 | 5.125 | 1.377 | 5.106 | 5.149 | 0.043 | 2e-08 | 3.0e-3 |
| Δ_t | U=125, V_SO=0.4082 | 0.10 | 4.667 | 1.467 | 4.647 | 4.705 | 0.058 | 2e-09 | 1.3e-2 |
| Δ_t | U=125, V_SO=0.4082 | 0.20 | 4.833 | 1.323 | 4.814 | 4.868 | 0.054 | 1e-07 | 1.4e-2 |

**Movement of the peak (the systematics the professor asked for):**

* **U\*** grows with V_SO (105 → 116 at T=0.1t) and decreases with T (105 → 99 at
  V_SO=0): stronger Rashba splitting pushes the dome-edge (and the threshold crossing)
  to stronger coupling; higher T widens the pair-open wedge towards weaker coupling.
* **V_SO\*** at U=125: 0.544 (T=0.1t), 0.573 (T=0.2t) — the wedge enters at mid-Rashba.
* **Δ_t\*** grows with U (4.23 → 4.94 at V_SO=0, T=0.1t), decreases with V_SO
  (4.23 → 3.98 at U=95; 4.94 → 4.65 at U=125), and grows with T (+0.17…+0.20):
  Δ_t controls b = Δˢ/4t, hence both E_min and the dome edge.
* **Heights** 1.32–1.58, largest at T=0.1t (sharper wedge); the overshoot above 1 is the
  constructive pair coherence factor, absent in the normal state.

## 3. Artifact checks

* Quadrature: doubling nell (20000→40000) changes the peak height by ≤ 2·10⁻⁵.
* Independent k-space evaluation (bruteforce lattice sums, N_k=320, Gaussian-δ widths
  0.08/0.05/0.03 with Richardson for the scattering leg; the new `S_pair_bf` at w=0.005
  for the pair leg — Richardson is invalid there because the pair integrand carries two
  BCS edge singularities ν(E)ν(ω−E), and the unordered-pair factor ½ is included):
  deviations 0.2–3.8 % for 12/13 peaks; the single 15 % outlier is the V_SO*=0.567 point
  where E_min is smallest and the lattice pair sum needs w < 0.005 (its *position* is the
  most stable of all, shift 0.003).
* The peak survives both refinements with sub-grid shifts; it is a property of the
  continuum integrals, not of the discretisation.

## 4. What was explored and where no peaks exist

* Ranges: U ∈ [50, 200] t (step 7.5–10), V_SO ∈ [0, 1.0] t (step 0.1, +0.4082),
  Δ_t ∈ [0.5, 6.0] t (step 0.25–0.5), at n = 1.885 (paper filling), ħω = 0.7 t,
  ensembles T/T_c = 0.5, 0.9 and fixed T = 0.1 t, 0.2 t; channels a_signed (primary),
  total (sc+pair), Case-II.  U = −75 excluded (unphysical strong-coupling root, errata E7).
* No peaks: primary channel in all three directions and both ensembles; Case-II channel
  in all three directions at fixed T; any channel at fixed T/T_c (the wedge is invisible
  there because T scales with T_c).
* Directions likely to show further structure if the study is extended: the T-direction
  at fixed parameters (Hebel–Slichter peak of the Case-II channel, T6); the ω-direction
  at fixed parameters (threshold at 2E_min); the filling n towards the van-Hove point
  n=1; finite τ/ql (Tsuneto-type kernel, outside the present model).

## 5. Figures

* `ultrasonic/figures/param_scan_U.png`, `param_scan_VSO.png`, `param_scan_Dt.png` —
  2×2 each: (a) primary T/T_c=0.5, (b) primary T=0.1t, (c) total T=0.1t with pair-open
  shading (SC region only) and peak stars, (d) total T=0.2t.
* `ultrasonic/figures/param_scan_diagnostics.png` — (a) T_c(U) dome with the T lines,
  (b) E_min(T=0.1t) vs ħω/2 threshold, (c) Case-II monotone, (d) primary T/T_c=0.9.

## 6. Standing convention

The in-range answer (2Δ > ħω, i.e. pair channel closed) remains the scattering-only
signed ratio; the total including S_pair is reported here *only* as the physical
attenuation of parameter regions where the pair channel is open, clearly labelled and
shaded in the figures — never merged into the in-range curves.

## 7. Addendum — extending U below 50: a primary-channel local maximum

The original U grid was [50, 200] t. Extending to U ∈ [15, 150] t
(`ultrasonic/make_uvso_families.py`, figure `WWN_vs_U_families_VSO.png`, data
`results/uvso_families.json`) reveals a **genuine local maximum of the primary
(scattering-only) ratio vs U** at U* ≈ 19–21 t for V_SO = 0–0.2 (and at T/T_c ≥ 0.9 also
for V_SO = 0.4), at every T/T_c:

| V_SO | T/T_c | 0.3 | 0.5 | 0.7 | 0.9 | 0.999 |
|---|---|---|---|---|---|---|
| 0 | W/W_N at U* | 0.058 | 0.311 | 0.597 | 0.873 | 0.999 |
| 0.2 | W/W_N at U* | 0.059 | 0.314 | 0.600 | 0.873 | 0.999 |

Mechanism (two opposing monotone factors at fixed T/T_c): (i) the suppression exponent
Δ⁰₀/T_c falls with U (1.10 at U=15 → 0.41 at U=25 → 0.06–0.11 at U=45–55), lifting the
ratio; (ii) the normal-state anchor R(ħω, T = (T/T_c)·T_c(U)) falls with U because T_c(U)
falls (ω/T grows), pulling it down. Their competition places an interior maximum at
U* ≈ 20. For V_SO ≥ 0.6 the SOC-driven T_c(U) is flat at small U, the two factors no
longer compete, and the curves are monotone (maximum at the U=15 endpoint).
The V_SO direction (U = 30…115, figure `WWN_vs_VSO_families_U.png`) and the Δ_t direction
remain monotone in the primary channel. The §0/§2 statement "no peaks in the primary
channel" therefore holds for the originally scanned range U ≥ 50 and for the V_SO/Δ_t
directions; the low-U maximum is an additional, now documented, feature of the U direction.
Flagged mean-field roots in these scans: U=55 at V_SO=0.4 and 0.6 (Δ⁰ ≪ Δ), U=150 at
V_SO=0 (dome edge, T_c=0.011 t).
