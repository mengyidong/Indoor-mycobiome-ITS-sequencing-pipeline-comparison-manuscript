# Indoor Mycobiome ITS2 vs Full‑Length ITS Comparison
This repository contains the data, code, and documentation supporting the manuscript: Benchmarking Short-Read ITS2 and Full-Length ITS Sequencing Reveals Pipeline-Dependent Biases in Indoor Fungal Community Profiling

Authors: Mengyi Dong1,2,3, Denene Blackwood4, Megan Lott5, Xavier Larkin2, Sherlynette Pérez Castro2, Thomas J. Clerkin2, Heather Hemric1, Jake Nash6,7, Yeon Ji Kim1, Jason W. Arnold1, Lawrence A. David1, Rytas J. Vilgalys4, Anthony A. Fodor8, Rachel T. Noble2

#Overview
This project presents a paired comparison of short‑read ITS2 and long‑read full‑length ITS sequencing for profiling fungal communities in the built environment. Using identical DNA extracts from indoor air and surface samples, we evaluate how amplicon length, primer targeting, and sequencing strategy influence fungal taxonomic resolution, community composition, and detection of health‑relevant taxa.
The analyses implement classifier parity, in‑silico ITS2 trimming of long‑read sequences, cross‑platform ASV mapping, and phylogenetic comparisons to disentangle the effects of amplicon length from sequencing platform.

Software Requirements

R (≥ 4.2 recommended)

Key R packages:

1. phyloseq
2. vegan
3. ggplot2
4. dplyr
5. tidyr
6. ape
