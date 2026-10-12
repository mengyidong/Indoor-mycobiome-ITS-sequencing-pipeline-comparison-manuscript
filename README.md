# Indoor Mycobiome ITS2 vs Full‑Length ITS Comparison
This repository contains data, metadata, bioinformatic workflows, command code, and statistical analyses supporting the manuscript:
"Benchmarking Short-Read ITS2 and Long-Read Full-Length ITS Sequencing Reveals Pipeline-Dependent Biases in Indoor Fungal Community Profiling"

Authors: Mengyi Dong1,2,3, Denene Blackwood4, Megan Lott5, Sherlynette Pérez Castro2, Javier Gallard-Góngora2, Thomas J. Clerkin2, Heather Hemric1, Jake Nash6,7, Yeon Ji Kim1, Jason W. Arnold1, Lawrence A. David1, Rytas J. Vilgalys4, Anthony A. Fodor8, Rachel T. Noble2

# Repository Overview
This project presents a paired comparison of short‑read ITS2 and long‑read full‑length ITS sequencing for profiling fungal communities in the built environment. Using identical DNA extracts from indoor air and surface samples, we evaluate how amplicon length, primer targeting, and sequencing strategy influence fungal taxonomic resolution, community composition, and detection of health‑relevant taxa.
The analyses implement classifier parity, in‑silico ITS2 trimming of long‑read sequences, cross‑platform ASV mapping, and phylogenetic comparisons to disentangle the effects of amplicon length from sequencing platform.
 
# Repository Structure

## metadata.tsv

Tab-delimited sample metadata file that link accession number to file name and sample ID.

## SequenceDataProcessing/

Contains bioinformatic workflows used to process raw sequence data.

### SequenceDataProcessing/Illumina-ITS2-processing/
Illumina ITS2 processing workflow.

| File | Description |
|------|-------------|
| 1_ITS2-SequencePretreat.txt | Read preprocessing and sequence preparation steps. |
| 2_ITS2-pipeline.sh | Main ITS2 sequence-processing pipeline. |
| 3_ITS2-ClusterDada2.sh | DADA2 denoising and ASV inference workflow. |
| 4_ITS2-taxclassifier.sh | Taxonomic assignment workflow. |

---

### SequenceDataProcessing/PacBio-ITS-processing/
PacBio HiFi full-length ITS processing workflow.

| File | Description |
|------|-------------|
| R_PacBio_ITS_pipeline.Rmd | DADA2-based PacBio ITS processing and analysis workflow. |
| PacBio_ITS_sklearn_TaxonomyClassifier.sh | Taxonomic classification workflow and outputs |

---
## QIMME2_Output
QIIME2 artifacts generated during processing and taxonomic assignment.
| File | Description |
|------|-------------|
| illumina_refseq.qza | Representative ITS2 ASV sequences. |
| illumina_blast_hits.qza | BLAST-mapped ITS2 sequences against the generated full-length ITS reference database. |
| illumina_taxonomy.qza | ITS2 taxonomic assignments. |
| illumina_taxonomy.qzv | Interactive taxonomy visualization. |
| pacbio_ITS2_taxonomy.qza | PacBio-derived ITS2 taxonomy from trimmed ITS2 region. |
| pacbio_ITS_taxonomy_sklearn.qza | Full-length ITS taxonomy assignments. |
| pacbio_refseq_sklearn.qza | PacBio representative sequences used for PacBio_ITS_sklearn_TaxonomyClassifier.sh |

These files can be viewed in QIIME2 View: https://view.qiime2.org

---

## Illumina/

Data files derived from the ITS2 (Illumina) sequencing workflow and used in data analysis (Rcode_main.Rmd).

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

## PacBio/

Data files derived from the full-length ITS (PacBio HiFi) sequencing workflow and used in data analysis (Rcode_main.Rmd).

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
| Command_BLAST_PacBio_db | Command-line workflow used to generate a BLAST database from PacBio full-length ITS ASVs, BLAST ITS2 representative sequences against the PacBio database|

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
 


