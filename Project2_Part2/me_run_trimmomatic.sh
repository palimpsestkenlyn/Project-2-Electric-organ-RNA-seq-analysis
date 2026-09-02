#!/bin/bash
#SBATCH --time=01:00:00
#SBATCH --partition=bgmp
#SBATCH --account=bgmp
#SBATCH --job-name=trimmomatic_trim
#SBATCH --output=trimmomatic_trim_%j.out

cd /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA

# Sample 1: SRR25630303
/usr/bin/time -v pixi run trimmomatic PE \
  cutadapt_outputs/SRR25630303_1_trimmed.fastq.gz \
  cutadapt_outputs/SRR25630303_2_trimmed.fastq.gz \
  trimmomatic_outputs/SRR25630303_1_paired.fastq.gz \
  trimmomatic_outputs/SRR25630303_1_unpaired.fastq.gz \
  trimmomatic_outputs/SRR25630303_2_paired.fastq.gz \
  trimmomatic_outputs/SRR25630303_2_unpaired.fastq.gz \
  LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35

# Sample 2: SRR25630398
/usr/bin/time -v pixi run trimmomatic PE \
  cutadapt_outputs/SRR25630398_1_trimmed.fastq.gz \
  cutadapt_outputs/SRR25630398_2_trimmed.fastq.gz \
  trimmomatic_outputs/SRR25630398_1_paired.fastq.gz \
  trimmomatic_outputs/SRR25630398_1_unpaired.fastq.gz \
  trimmomatic_outputs/SRR25630398_2_paired.fastq.gz \
  trimmomatic_outputs/SRR25630398_2_unpaired.fastq.gz \
  LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35