#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --job-name=htseq_SRR25630398_reverse
#SBATCH --output=htseq_SRR25630398_reverse_%j.out
#SBATCH --time=2:00:00

cd /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris_sample.alignments/3_Star_alignments/SRR25630398

GFF=/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris_sample.alignments/1_Input_data/campylomormyrus.gff
SAM=SRR25630398_Aligned.out.sam
OUTDIR=/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris_sample.alignments/4_htseq_counts

/usr/bin/time -v pixi run htseq-count \
    --stranded=reverse \
    -i Parent \
    $SAM \
    $GFF \
    > $OUTDIR/SRR25630398_htseqcounts_reversestranded.txt