# REFEREE_RESPONSE.md — replication audit of the corrected repository
(commit bbfaad1 mirror; manuscript arXiv:2607.02812 v1)

Every number below was re-measured in this workspace (scratch clone for destructive
commands; committed JSON read directly; independent implementations where required).
`PASS` = claim reproduces; `FAIL` = claim contradicted by measurement; `FIXED` = defect
found and corrected in this response.

## 1. Claim-by-claim table

| # | claim as written (file) | measured here | verdict |
|---|---|---|---|
| P0.1 | `main_ua.py master` reproduces committed `temp_sweep_VSO_*.json` | a_signed/b_abs/c_paper/d_std/pair bit-identical (maxdiff 0.0, 52 fracs × 3 V_SO) | PASS |
| P0.2 | Tc⁻ limits 0.40004/0.50540/0.76112 | 0.4000428/0.5054035/0.7611174 | PASS |
| P0.3 | stage-1 group B Tc=0.5009/0.1399/0.0861, Δ_eff=0.6272/0.2840/0.2070 | exact to 4 decimals (solve_set, Nk=80) | PASS |
| P0.4 | stage-1 and ℓ-substitution algebra sound | stage-1 exact; ℓ-algebra after T0 fix ≤3.9e-4 (was 0.30–0.35 with the committed single-Jacobian reference) | PASS / FIXED |
| P1 | "(W+W_p)/W_N = 1 to 1e-4 above the true threshold" (README:18, COVER_NOTE:20, PDF pp.19–24, plotting_ua.py:184) | max(total−1) above threshold: 0.3487 (V_SO=0, T/Tc=0.84), 0.4054 (0.4082, 0.98), 0.5139 (0.8, 0.98); total at first pair-open point 1.3487 / 1.2578 (0.92) / 1.5139; spike at 0.4082: total(0.96,0.98,0.99)=1.1956, 1.4054, 1.0885 — all reproduce the referee's table exactly | FAIL as written → FIXED (see §2) |
| P1b | quadrature excluded as cause | S_pair at nell=6k/20k/30k/120k: 0.9448278241/…8252/…8253/…8252 (stable ~1e-9) | CONFIRMED |
| P2 | peaks 1.32–1.58 in (S_sc+S_pair)/S_N vs established Case-I physics | peaks reproduce; decision and mechanism in §3 | FIXED (wording + reference) |
| P2b | REPORT §1.3 "0≤C_a≤1 ⇒ W/W_N≤1 guaranteed" | logically invalid (bound on factor ≠ bound on ratio with differently-measured reference); repo's own 1.514 is the counterexample | FAIL → FIXED (REPORT §1.3 + App. A2) |
| P3-T0 | README "2.1e-4"; committed test actual 2.99e-1/3.40e-1/3.50e-1 | reproduced; root cause confirmed (reference integral carried E/ℓ only); with BOTH Jacobians: 3.89e-4/1.81e-4/8.29e-5 (ω=0.05/0.01/0.002), converging as ω→0. Referee's rebuilt residuals (1.37e-2/6.38e-3/2.88e-3) do NOT reproduce with the correct double-Jacobian reference | FAIL (test) → FIXED; README now ≤3.9e-4 |
| P3-T4 | "0.0 % violations" for all four variants while README says (b),(c) break bound | reproduced; sampling is vacuous (|ξξ′|≤EE′ identically). New T4: structured-grid bound residual 0.00e+00 for (a); ratio bound at Δ=0, ħω=0.2, T=1: (a),(d)=0.950082≤1, (b),(c)=1.900165=2R>1 | VACUOUS → REPLACED |
| P3-T6(1) | 8.7e-16 kernel identity | tautology under the code's definitions (branch-summed C_II vs MB kernel are the same algebra); retained as consistency check, now labelled as such | RELABELLED |
| P3-T6(2) | "Hebel–Slichter peak" = σ₁/σ_N | NOT σ₁/σ_N: repo column = Case-II ultrasonic-style ratio at ω=1e-4 (below the δ-smearing scale). ω-scan at T/Tc=0.85: repo 1.7814/3.4740/5.2919/7.1148/8.9378 for ω=1e-2…1e-6; independent clean-limit Mattis–Bardeen with same gap: 2.0470/3.7906/7.1180/15.4708/39.9361 — BOTH diverge as ω→0 (clean limit has no relaxation), so the referee's "true σ₁/σ_N(ω→0) finite" is itself regularisation-dependent; at ω=0.7 my MB gives 0.701/0.817/0.923/1.006 vs repo 0.001/0.055/0.109/0.162 (different observable entirely) | MISLABELLED → RELABELLED qualitative |
| P3-T3 | README "0.4–1.6 %" | per variant: (a) 9.8e-3–1.3e-2, (b) 8.4e-4–7.3e-3, (c) 2.5e-4–6.9e-3, (d) 1.5e-2–4.5e-1 | PARTIAL → README per-variant |
| P4.1 | η/case convention undocumented (paper p.10 −ΔΔ′/EE′ vs integrand +ηΔΔ′/EE′) | table added (REPORT App. A3): printed factor = Case-I signed (correct, used); printed integrand with η=+1 = (uu′+vv′)² = Case II (wrong for ultrasound) | FIXED |
| P4.2 | GAP_FIT hard-coded 3.434/0.553 vs gap_vs_T_fit.json p=3.674,q=0.556 @V_SO=0 | confirmed; per-V_SO refit effect measured: 2.17/1.33 % (V_SO=0), 2.47/1.43 % (0.4082), 3.36/2.11 % (0.8) at T/Tc=0.5/0.9; erratum E8 + code comment added | FIXED (documented, quantified) |
| P4.3 | U=−75t unphysical root still in citable outputs | Tc≈12.7–13.2t, Δ⁰≈17.8t, μ≈35t confirmed; figure moved to `ultrasonic/figures/non_citable/`, removed from SOCfigures, erratum E9 | FIXED |
| P5 | absolute paths; broken quick start; schema drift; no requirements/CI; font licence; README drift | all reproduced (NameError sc_params_at AND band_edge; `main_ua.py all` dropped total/two_Emin/Deff/D0_0/DS_0/hbar_omega/n_target then plotting KeyError 'total'; regen_all.sh absolute paths; README said 31 PNGs/18 Q&A/2.1e-4/0.4–1.6 %) | FIXED (see §4) |

## 2. Corrected sum rule (required output of Part 1)

C_I + (1−C_I) = 1 per (E,E′) shell. With the matched quasiparticle reference

  W_N^QP = ∫∫ dE dE′ (E/ℓ)(E′/ℓ′) N(ε_E) N(ε_E′) δ(E′−E−ħω)[f(E)−f(E′)],

(W+W_p)/W_N^QP = 1 EXACTLY for all Δ, ħω, T, V_SO. The band reference W_N =
∫N(ε)N(ε+ħω)(f−f′)dε (μ_N) imposes band-energy conservation while W imposes
quasiparticle-energy conservation; at Δ≠0 these differ, so (W+W_p)/W_N(band) ≠ 1:
it exceeds 1 above 2E_min=ħω (measured maxima 1.349/1.405/1.514) and →1.004–1.006 as
Δ→0 where the references coincide (T1 = 100.0000 %). What is conserved is the per-shell
spectral weight, not the ratio against the band reference. Removed/restated in: README
headline+gallery, COVER_NOTE.md item 3, PDF addendum pp.19–24 (rebuilt, 24 pp),
plotting_ua.py figure title (+ regenerated sum_rule_and_thresholds.png),
PARAM_SCAN_PEAKS.md §8, REPORT App. A2.

## 3. Pair-channel decision (Part 2): option (a), with the corrected reference

The pair channel belongs to the same ultrasonic W (phonon → two quasiparticles absorbs
sound; same η=+1 weight 1−f−f′ as Sardwal et al. arXiv:2608.19079 Eqs. A6–A9). Totals >1
are therefore physical finite-ω pair-breaking enhancement measured against the band
reference, not an inconsistency; with W_N^QP the identity is exact. The 1.3–1.6 peaks are
deviations of the band reference at ħω=0.7t (~10³× physical ultrasound frequencies, where
2E_min>ħω always and W/W_N≤1, Levy). NOT option (b) (our pair channel is η=+1, not Case II)
and NOT merely (c) (the identity is per-shell, but the ω→Tc limit statement came from the
band reference and is withdrawn). Files changed: those listed in §2 plus REPORT §1.3.

## 4. Reproducibility patch (Part 5)

regen_all.sh rewritten relative-path with sibling-checkout guards; physics_ua.py quick
start fixed (sc_loader.sc_params_at, band_edge import); scanning_ua.temp_sweep now writes
the full committed schema (total, two_Emin, Deff, D0_0, DS_0, hbar_omega, n_target) —
`main_ua.py all` + `plotting_ua.py` verified end-to-end in a fresh clone; requirements.txt
(numpy>=2 for np.trapezoid, scipy, matplotlib); .gitignore; Makefile (test/master/figures);
FONT_NOTE.md for BNazanin.ttf (proprietary, not MIT, delete before redistribution);
README drift corrected (36 PNGs, 22 Q&A, T0/T3/T4/sum-rule lines). Known residual: the PDF
builder still emits into the paper_fix working directory by design (documented).

## 5. Referee verdict

The corrected W/W_N (η=+1 signed, scattering-only, inside 2E_min>ħω) is defensible as it
stands: it reproduces Levy (3e-6), the Mattis–Bardeen kernel identity, the Sardwal-style
dual-formulation triangle (≤1.3 %, Nk-independent), and its stage-1 is exact; every defect
found by this audit was in "claims about" the computation (sum-rule wording, vacuous or
mislabelled tests, README drift, packaging), none in the primary channel's arithmetic, and
all are now corrected with measured numbers. The >1 totals and 1.3–1.6 peaks are genuine
finite-ω pair-breaking physics of the model at ħω=0.7t, correctly restated against the
matched reference. The single experiment that would settle the remaining physics: a
threshold-crossing measurement of ultrasonic attenuation at ħω ≈ 2Δ (high-frequency
acoustic resonance or monochromatic phonons in a low-gap superconductor), where the
scattering-only and scattering+pair formulations differ in the onset shape; within theory,
the corresponding closure is a finite-q vertex with Rashba spinor overlaps (inter-helicity
weight ~q²v_F²/Δ_SO²), which would also close the 10–25 % vertex systematic of the SOC
magnitude at strong coupling.
