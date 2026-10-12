# Taxonomy assignment for full-length ITS sequences using QIIME 2 in a Singularity container.
#
# Purpose:
# Assign taxonomy to processed full-length ITS representative sequences after raw-read processing.
# Taxonomic assignment is performed in QIIME 2 using the classify-sklearn method rather than within DADA2.
#
# Method:
# - QIIME 2 plugin: feature-classifier classify-sklearn
# - Database: UNITE full-length ITS reference database
# - Classifier: pre-trained taxonomic classifier for full-length ITS sequences
#
# Runtime environment:
# - Executed inside a Singularity container containing QIIME 2
# - Example:
#   singularity exec --bind <bind_path> <container.sif> qiime feature-classifier classify-sklearn ...


#!/bin/bash
#SBATCH --job-name=TaxonomyClassifier
#SBATCH --mem=100000
#SBATCH --partition=partition.name
#SBATCH --cpus-per-task=4
#SBATCH --time=12:00:00
#SBATCH --out=TaxonomyClassifier.out
#SBATCH --error=TaxonomyClassifier.err

# Usage:
# sbatch /path/to/TaxonomyClassifier.sh /path/to/inputfile /path/to/qiime2.sif


### Set a custom temporary directory
export TMPDIR=./tmp_qiime2
mkdir -p $TMPDIR

###Convert fasta to qza
singularity exec --bind $1 $2 qiime tools import \
  --input-path $1/pacbio_refseq.fasta \
  --output-path $1/pacbio_refseq.qza \
  --type 'FeatureData[Sequence]'

###Taxonomy classification with pre-trained taxonomic classifier for the UNITE database of full length ITS sequences####
singularity exec --bind $1 $2 qiime feature-classifier classify-sklearn \
  --i-classifier $1/unite_ver9_dynamic_all_25.07.2023-Q2-2023.9.qza \
  --i-reads $1/pacbio_refseq.qza \
  --o-classification $1/pacbio_ITS_taxonomy.qza \
  --p-n-jobs -4

###Export data#######################################################
singularity exec --bind $1 $2 qiime tools extract \
  --input-path $1/pacbio_ITS_taxonomy.qza \
  --output-path $1/ITS_taxonomy
