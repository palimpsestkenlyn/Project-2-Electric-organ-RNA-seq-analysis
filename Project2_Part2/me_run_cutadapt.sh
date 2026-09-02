#!/bin/bash
#SBATCH --time=01:00:00
#SBATCH --partition=bgmp
#SBATCH --account=bgmp
#SBATCH --job-name=cutadapt_trim
#SBATCH --output=cutadapt_trim_%j.out

cd /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA

# Sample 1: SRR25630303
/usr/bin/time -v pixi run cutadapt \
  -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
  -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
  -o /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/trimmed_outputs/SRR25630303_1_trimmed.fastq.gz \
  -p /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/trimmed_outputs/SRR25630303_2_trimmed.fastq.gz \
  /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/SRA_outputs/SRR25630303_1.fastq.gz \
  /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/SRA_outputs/SRR25630303_2.fastq.gz

# Sample 2: SRR25630398
/usr/bin/time -v pixi run cutadapt \
  -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
  -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
  -o /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/trimmed_outputs/SRR25630398_1_trimmed.fastq.gz \
  -p /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/trimmed_outputs/SRR25630398_2_trimmed.fastq.gz \
  /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/SRA_outputs/SRR25630398_1.fastq.gz \
  /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/SRA_outputs/SRR25630398_2.fastq.gz