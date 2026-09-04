#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --job-name=star_align_SRR25630398
#SBATCH --output=star_align_SRR25630398_%j.out
#SBATCH --time=6:00:00

# INPUT 1: the reads RNA (shared class data, referenced not copied)
READ1=/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/4_trimmomatic_outputs/SRR25630398_1_paired.fastq.gz
READ2=/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/4_trimmomatic_outputs/SRR25630398_2_paired.fastq.gz
# INPUT 2: the genome index built yesterday (output then, input now)
GENOME_DIR=/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris/Campylomormyrus_compressirostris.dryad_c59zw3rcj.STAR_2.7.11b
# OUTPUT: prefix STAR sticks on the front of every file it writes. 
OUT_PREFIX=SRR25630398_

cd /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris/Star_alignments/SRR25630398

# THE OPERATION: align the reads to the index, write SAM file w/ perameters set to match 621_PS8 
/usr/bin/time -v pixi run STAR \
    --runThreadN 8 \
    --runMode alignReads \
    --outFilterMultimapNmax 3 \
    --outSAMunmapped Within KeepPairs \
    --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
    --readFilesCommand zcat \
    --readFilesIn $READ1 $READ2 \
    --genomeDir $GENOME_DIR \
    --outFileNamePrefix $OUT_PREFIX