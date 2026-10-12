#!/bin/bash
#SBATCH --job-name=ITS2-pipeline
#SBATCH --mem=70000
#SBATCH --partition=partition.name
#SBATCH --out=ITS2-pipeline.out
#SBATCH --error=ITS2-pipeline.err

# Usage:
# sbatch 2_ITS2-pipeline.sh /path/to/wd /path/to/qiime2.sif

## Set up input, output directories ############################################
export MPLCONFIGDIR=$1 # this environment variable needs a writable directory

## Import ######################################################################

singularity exec --bind $1 $2 qiime tools import \
  --type 'SampleData[SequencesWithQuality]' \
  --input-path $1/QIIMEManifest.tsv \
  --output-path $1/ITS2_demux.qza \
  --input-format SingleEndFastqManifestPhred33V2

singularity exec --bind $1 $2 qiime demux summarize \
  --i-data $1/ITS2_demux.qza \
  --o-visualization $1/ITS2_demux.qzv

## Denoise sequences, quality filter, chimera filter, and ASV call #############
singularity exec --bind $1 $2 qiime dada2 denoise-single \
     --i-demultiplexed-seqs $1/ITS2_demux.qza \
     --p-trunc-len 0 \
     --output-dir $1/dada2out \
     --p-n-threads 0 \
     --o-table $1/ITS2_dada2table.qza \
     --o-representative-sequences $1/ITS2_dada2seqs.qza \
     --o-denoising-stats $1/ITS2_dada2denoising.qza

## Make feature table ##########################################################

singularity exec --bind $1 $2 qiime metadata tabulate \
     --m-input-file $1/ITS2_dada2denoising.qza \
     --o-visualization $1/ITS2_dada2denoising.qzv

singularity exec --bind $1 $2 qiime feature-table summarize \
     --i-table $1/ITS2_dada2table.qza \
     --o-visualization $1/ITS2_dada2table.qzv

singularity exec --bind $1 $2 qiime feature-table tabulate-seqs \
     --i-data $1/ITS2_dada2seqs.qza \
     --o-visualization $1/ITS2_dada2seqs.qzv


# move .err and .out files
cd ..
mkdir Reports
mv $1/ITS2-pipeline.out ./Reports/'ITS2-pipeline_'$SLURM_JOB_ID'.out'
mv $1/ITS2-pipeline.err ./Reports/'ITS2-pipeline_'$SLURM_JOB_ID'.err'