# Indoor Mycobiome ITS2 vs Full‑Length ITS Comparison
This repository contains code, processed data, metadata, and supporting files for:
 
"Benchmarking Short-Read ITS2 and Long-Read Full-Length ITS Sequencing Reveals Pipeline-Dependent Biases in Indoor Fungal Community Profiling"

Authors: Mengyi Dong1,2,3, Denene Blackwood4, Megan Lott5, Sherlynette Pérez Castro2, Javier Gallard-Góngora2, Thomas J. Clerkin2, Heather Hemric1, Jake Nash6,7, Yeon Ji Kim1, Jason W. Arnold1, Lawrence A. David1, Rytas J. Vilgalys4, Anthony A. Fodor8, Rachel T. Noble2

Overview
This project presents a paired comparison of short‑read ITS2 and long‑read full‑length ITS sequencing for profiling fungal communities in the built environment. Using identical DNA extracts from indoor air and surface samples, we evaluate how amplicon length, primer targeting, and sequencing strategy influence fungal taxonomic resolution, community composition, and detection of health‑relevant taxa.
The analyses implement classifier parity, in‑silico ITS2 trimming of long‑read sequences, cross‑platform ASV mapping, and phylogenetic comparisons to disentangle the effects of amplicon length from sequencing platform.

# Repository Contents
 
## Repository Structure

### metadata.tsv

Metadata file that link accession number to file name and sample ID.

### Illumina/

Files derived from the ITS2 (Illumina) sequencing workflow.

| File | Description |
|------|-------------|
| Illumina_ITS2_tree.nwk | Maximum-likelihood phylogenetic tree generated from mapped ITS2 ASVs. |
| illumina_blast_hits_allpacbio.tsv | BLAST mapping results linking ITS2 ASVs to full-length ITS ASVs. |
| illumina_filt_refseq.fasta | Filtered representative ITS2 ASV sequences used in downstream analyses. |
| illumina_filt_taxonomy.tsv | Taxonomic classifications for filtered ITS2 ASVs. |
| illumina_taxonomy_filt.csv | Filtered taxonomy table used in comparative analyses. |
| illumina_taxonomy_mapped_agreement.csv | Taxonomy comparison results for mapped ASVs between pipelines. |
| illumina_taxonomy_mapped_sankey.csv | Taxonomic reassignment table used for Sankey diagrams in Figure 5. |
| matched_ITS2_filt_refseqs.fasta | ITS2 representative sequences that successfully mapped to full-length ITS ASVs. |
| ps_Illumina_ITS2_sklearn.rds | Phyloseq object containing ITS2 ASV table, taxonomy, and metadata. |

---

### PacBio/

Files derived from the full-length ITS (PacBio HiFi) sequencing workflow.

| File | Description |
|------|-------------|
| PacBio_ITS_tree.nwk | Maximum-likelihood phylogenetic tree generated from mapped full-length ITS ASVs. |
| matched_ITS_filt_refseqs.fasta | Full-length ITS representative sequences that successfully mapped to ITS2 ASVs. |
| pacbio_filt_refseq.fasta | Filtered representative full-length ITS ASV sequences. |
| pacbio_filt_taxonomy.tsv | Taxonomic classifications for filtered full-length ITS ASVs. |
| ps_PacBio_Fungi_match_sklearn.rds | Phyloseq object containing PacBio full-length ITS ASVs, taxonomy, and metadata. |
| ps_PacBio_ITS2_match.rds | Phyloseq object containing full-length ITS trimmed ITS2 ASVs, taxonomy, and metadata. |

---

### Analysis Scripts

| File | Description |
|------|-------------|
| Rcode_main.Rmd | Main manuscript workflow generating analyses, figures, and tables reported in the manuscript. |
| Rcode_ResponseToReviewer1_DepthRarefaction.Rmd | Rarefaction and sequencing-depth analyses performed in response to Reviewer 1 (Figure S10). |
| Rcode_ResponseToReviewer2_PairedOrdination.Rmd | CLR-transformed Euclidean (Aitchison) ordination analyses performed in response to Reviewer 2 (Figure S8a). |
| MS_IndoorMycobiome.Rproj | RStudio project file used to organize the analysis workflow. |

---

## Reproducing Analyses

1. Download all repository contents.
2. Open `MS_IndoorMycobiome.Rproj` in RStudio.
3. Load the required packages listed in Rcode_main.Rmd.
4. Run `Rcode_main.Rmd` to reproduce the main manuscript analyses.
5. Reviewer-response analyses can be reproduced using:
   - `Rcode_ResponseToReviewer1_DepthRarefaction.Rmd`
   - `Rcode_ResponseToReviewer2_PairedOrdination.Rmd`
  
 ### Software Requirements

R (≥ 4.2 recommended)

Key R packages:

1. phyloseq
2. vegan
3. ggplot2
4. dplyr
5. tidyr
6. ape

---

## Data Availability

Raw sequence data have been deposited under BioProject: **PRJNA1294855**.

Sample metadata linking sequencing accessions to samples are provided in `metadata.tsv`.
 


