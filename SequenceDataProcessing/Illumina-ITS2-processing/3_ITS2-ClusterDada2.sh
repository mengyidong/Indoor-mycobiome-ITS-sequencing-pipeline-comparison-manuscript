#!/bin/bash
#SBATCH --job-name=ITS2-ClusterDada2
#SBATCH --mem=50000
#SBATCH --partition=partition.name
#SBATCH --out=ITS2-ClusterDada2.out
#SBATCH --error=ITS2-ClusterDada2.err

# Usage:
# sbatch 3_ITS2-ClusterDada2.sh /path/to/inputfile /path/to/qiime2.sif

## Set up input, output directories ############################################
export MPLCONFIGDIR=$1 # this environment variable needs a writable directory

## VSearch clustering at 97% similarity#########################################
singularity exec --bind $1 $2 qiime vsearch cluster-features-de-novo \
        --i-sequences $1/ITS2_dada2seqs.qza\
	--i-table $1/ITS2_dada2table.qza \
	--p-perc-identity 0.97 \
	--p-threads 0 \
	--o-clustered-table $1/ITS2_Dada2_table97.qza \
	--o-clustered-sequences $1/ITS2_Dada2_repseqs97.qza

singularity exec --bind $1 $2 qiime feature-table summarize \
	--i-table $1/ITS2_Dada2_table97.qza \
	--o-visualization $1/ITS2_Dada2_table97.qzv

singularity exec --bind $1 $2 qiime feature-table tabulate-seqs \
	--i-data $1/ITS2_Dada2_repseqs97.qza \
	--o-visualization $1/ITS2_Dada2_repseqs97.qzv

# move .err and .out files
cd ..
mv $1/ITS2-ClusterDada2.out ./Reports/'ITS2-ClusterDada2_'$SLURM_JOB_ID'.out'
mv $1/ITS2-ClusterDada2.err ./Reports/'ITS2-ClusterDada2_'$SLURM_JOB_ID'.err'