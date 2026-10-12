#!/bin/bash
#SBATCH --job-name=ITS2-taxclassifier
#SBATCH --mem=100000
#SBATCH --partition=partition.name
#SBATCH --out=ITS2-taxclassifier.out
#SBATCH --error=ITS2-taxclassifier.err

# Usage:
# sbatch /path/to/3_ITS2-taxclassifier_ASV.sh /path/to/inputfile /path/to/qiime2.sif

###Taxonomy classification with pre-trained taxonomic classifier for the UNITE database of full length ITS sequences####
wget https://github.com/colinbrislawn/unite-train/releases/download/v9.0-v25.07.2023-qiime2-2023.9/unite_ver9_dynamic_all_25.07.2023-Q2-2023.9.qza -O unite_ver9_dynamic_all_25.07.2023-Q2-2023.9.qza

singularity exec --bind $1 $2 qiime feature-classifier classify-sklearn \
  --i-classifier $1/unite_ver9_dynamic_all_25.07.2023-Q2-2023.9.qza \
  --i-reads $1/ITS2_dada2seqs.qza \
  --o-classification $1/ITS2_Dada2_taxonomy.qza \
  --p-n-jobs -1

###Export data#######################################################
singularity exec --bind $1 $2 qiime tools extract \
  --input-path $1/ITS2_Dada2_taxonomy.qza \
  --output-path $1/ITS2_Dada2_taxonomy

singularity exec --bind $1 $2 qiime tools export \
  --input-path $1/ITS2_dada2table.qza \
  --output-path $1/QIIME_exported_files

biom convert -i $1/QIIME_exported_files/feature-table.biom -o $1/QIIME_exported_files/ITS2_OTUTable.tsv --to-tsv

cp $1/ITS2_Dada2_taxonomy/*/data/taxonomy.tsv $1/QIIME_exported_files/ITS2_Dada2_taxonomy.tsv

singularity exec --bind $1 $2 qiime tools export \
  --input-path $1/ITS2_dada2seqs.qza \
  --output-path $1/QIIME_exported_files

mv $1/QIIME_exported_files/dna-sequences.fasta $1/QIIME_exported_files/ITS2_dada2seqs.fasta

# move .err and .out files
cd ..
mv $1/ITS2-taxclassifier.out ./Reports/'ITS2-taxclassifier_'$SLURM_JOB_ID'.out'
mv $1/ITS2-taxclassifier.err ./Reports/'ITS2-taxclassifier_'$SLURM_JOB_ID'.err'
