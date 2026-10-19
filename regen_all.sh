#!/bin/bash
# regen_all.sh -- after run_production.py: fan out results, regenerate every figure and PDF.
set -e
R=/home/user/power-absorbed-corrected/project
cd $R/ultrasonic && python3 export_results.py
cd /home/user/wwn_eta1 && python3 figures.py
cd /home/user/paper_fix && python3 make_paper_figs.py
# repository figures
cd $R/ultrasonic && python3 plotting_ua.py all pair
cd $R/sc_params && python3 plotting_tc.py
cd $R/ultrasonic_U && python3 plotting_ua_u.py
cp /home/user/wwn_eta1/fig_branch_decomposition.png $R/ultrasonic/figures/branch_decomposition.png
cp /home/user/wwn_eta1/fig_limits.png               $R/ultrasonic/figures/W_WN_limits.png
cp /home/user/paper_fix/figs/fig_group_A.png $R/ultrasonic_U/figures/W_WN_U_attractive_sweep.png
cp /home/user/paper_fix/figs/fig_group_B.png $R/ultrasonic_U/figures/W_WN_U_temperature_sweep.png
cp /home/user/paper_fix/figs/fig_group_C.png $R/ultrasonic/figures/W_WN_groups_Dt_scan.png
cp /home/user/paper_fix/figs/fig_group_D.png $R/ultrasonic/figures/W_WN_groups_VSO_scan.png
cp /home/user/paper_fix/figs/fig_scan_U95.png  $R/ultrasonic/figures/W_WN_vs_VSO_U95.png
cp /home/user/paper_fix/figs/fig_scan_U125.png $R/ultrasonic/figures/W_WN_vs_VSO_U125.png
cp /home/user/paper_fix/figs/fig_scan_Um75.png $R/ultrasonic/figures/W_WN_vs_VSO_Um75.png
cp /home/user/paper_fix/figs/fig_group_*.png /home/user/power-absorbed-corrected/project/paper_correction/figures/
cp /home/user/paper_fix/figs/fig_scan_*.png  /home/user/power-absorbed-corrected/project/paper_correction/figures/
# PDFs
cd /home/user/paper_fix && python3 build_pdf.py && python3 build_pdf_fa.py
cp /home/user/paper_fix/arXiv_2607.02812_corrected.pdf $R/paper_correction/results/
cp /home/user/paper_fix/corrections_fa.pdf            $R/paper_correction/results/
echo REGEN_ALL_DONE
