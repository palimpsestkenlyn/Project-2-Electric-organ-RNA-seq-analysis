#!/bin/bash
#SBATCH --time=03:00:00
#SBATCH --partition=bgmp
#SBATCH --account=bgmp
#SBATCH --job-name=trimmomatic_trim2.0
#SBATCH --output=trimmomatic_trim2.0_%j.out

cd /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA

# Sample 1: SRR25630303
# already complete in last run, sample 2 timed out. rerun. here. 

# Sample 2: SRR25630398
/usr/bin/time -v pixi run trimmomatic PE \
  cutadapt_outputs/SRR25630398_1_trimmed.fastq.gz \
  cutadapt_outputs/SRR25630398_2_trimmed.fastq.gz \
  trimmomatic_outputs/SRR25630398_1_paired.fastq.gz \
  trimmomatic_outputs/SRR25630398_1_unpaired.fastq.gz \
  trimmomatic_outputs/SRR25630398_2_paired.fastq.gz \
  trimmomatic_outputs/SRR25630398_2_unpaired.fastq.gz \
  LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35