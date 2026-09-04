#!/bin/bash

#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --job-name=star_database
#SBATCH --output=star_database_%j.out
#SBATCH --time=3:00:00

# OUTPUT: the (currently empty) folder STAR will fill with the index
GENOME_DIR=/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris/Campylomormyrus_compressirostris.dryad_c59zw3rcj.STAR_2.7.11b
# INPUT 1: the genome sequence itself
FASTA=/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris/Input_data/campylomormyrus.fasta
# INPUT 2: the annotation (where genes/exons/introns sit on that sequence = map) 
GTF=/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris/Input_data/campylomormyrus.gtf


# THE OPERATION: read the two inputs, build the index/database, write it to the output 
/usr/bin/time -v pixi run STAR \
    --runThreadN 8 \
    --runMode genomeGenerate \
    --genomeDir $GENOME_DIR \
    --genomeFastaFiles $FASTA \
    --sjdbGTFfile $GTF \
    --genomeSAindexNbases 13 #added this after the first run memory failed, the slurm out contained an error and recomendation
    # use 8 threads, --runMode genomeGenerate = "build an index", output dir location, input1, input2