#!/bin/bash
#SBATCH --account=bgmp
#SBATCH --partition=bgmp
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --job-name=gff_to_gtf
#SBATCH --output=gff_to_gtf_%j.out
#SBATCH --time=3:00:00


/usr/bin/time -v pixi run agat_convert_sp_gff2gtf.pl --gff campylomormyrus.gff -o campylomormyrus.gtf