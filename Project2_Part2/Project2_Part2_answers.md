my files: /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/SRA_outputs

## Part 2 Adaptor trimming comparison, DUE 8/31


5.  
Environment: 
cutadapt version 5.2 (Python 3.12.14)
trimmomatic version 0.41

6.  What proportion of reads (both R1 and R2) were trimmed?

Proportions trimmed:

SRR25630303:

Read 1 with adapter: 1,767,108 / 41,934,422 (4.2%)
Read 2 with adapter: 2,066,337 / 41,934,422 (4.9%)

SRR25630398:

Read 1 with adapter: 4,844,719 / 34,878,180 (13.9%)
Read 2 with adapter: 4,978,371 / 34,878,180 (14.3%)
    
    Try to determine what the adapters are on your own. If you cannot (or if you do, and want to confirm), click here to see the actual adapter sequences used.

    For adapters:
I looked at fastqc outputs, only one of my files showed a prediction for adapter content.
File SRR25630303 shows almost no prediction or rise towards the 3' end. However the other file SRR25630398 does show adapter prediction for the Illumina Universal Adapter. I have looked up the sequence for that and will look for it in my files:

```
ALAPAS login2 (/gpfs/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/SRA_outputs) 09:18 PM $ zcat SRR25630303_1.fastq.gz | head -200 | grep -c "AGATCGGAAGAGC"
1
TALAPAS login2 (/gpfs/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/SRA_outputs) 09:19 PM $ zcat SRR25630303_1.fastq.gz | head -400 | grep -c "AGATCGGAAGAGC"
1
TALAPAS login2 (/gpfs/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/SRA_outputs) 09:19 PM $ zcat SRR25630303_1.fastq.gz | head -1000 | grep -c "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"
1
TALAPAS login2 (/gpfs/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/SRA_outputs) 09:20 PM $ zcat SRR25630398_1.fastq.gz | head -1000 | grep -c "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"
4
TALAPAS login2 (/gpfs/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/SRA_outputs) 09:21 PM $ zcat SRR25630398_1.fastq.gz | head -4000 | grep -c "AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"
24
TALAPAS login2 (/gpfs/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/SRA_outputs) 09:22 PM $ zcat SRR25630398_1.fastq.gz | head -4000 | grep -c "AGATCGGAAGAGC"
66
```

So somewhat as to be expected, there are more matches when I use a shorter sequence of the adapter. Also from the fastqc reports the 398 file shows more frequent matches than the 303 file when doing just some initital greping. However the presence in both files of the full sequence of the Illumina Universial Adapter even a few times in the start of the file, for me confirms this is the correct adapter. 


    R1: `AGATCGGAAGAGCACACGTCTGAACTCCAGTCA`

    R2: `AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT`



    - *Sanity check*: Use your Unix skills to search for the adapter sequences in your datasets and confirm the expected sequence orientations. Report the commands you used, the reasoning behind them, and how you confirmed the adapter sequences.
        To confirm my logic above in terms of orientation, I used the reverse Universal Illumina Adapter sequence to search in the reverse files (_2) and did find them. This confirms for me that the forward files (_1) have the Universal Illumina Adapter (AGATCGGAAGAGCACACGTCTGAACTCCAGTCA) and the reverse files (_2) have the reverse Universal Illumina Adapter (AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT).
```
TALAPAS login2 (/gpfs/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/SRA_outputs) 09:23 PM $ zcat SRR25630398_1.fastq.gz | head -4000 | grep -c "AGATCGGAAGAGC"
66
TALAPAS login2 (/gpfs/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/SRA_outputs) 09:29 PM $ zcat SRR25630303_1.fastq.gz | head -4000 | grep -c "AGATCGGAAGAGC"
15
```
Also the output from cutadapt says 3' adapters and found a lot of matches to trim, so seems right!

7.  Use `Trimmomatic` to quality trim your reads. Specify the following, **in this order**:

    - LEADING: quality of 3
    - TRAILING: quality of 3
    - SLIDING WINDOW: window size of 5 and required quality of 15
    - MINLENGTH: 35 bases

    Be sure to output compressed files and clear out all intermediate files.

8.  Plot the trimmed read length distributions for both paired R1 and paired R2 reads (on the same plot - yes, you will have to use Python or R to plot this. See ICA4 from Bi621). You can produce 2 different plots for your 2 different RNA-seq samples. There are a number of ways you could possibly do this. One useful thing your plot should show, for example, is whether R1s are trimmed more extensively than R2s, or vice versa. Comment on whether you expect R1s and R2s to be adapter-trimmed at different rates and why.
So first I need to get the lengths, then plot
```
zcat SRR25630303_1_paired.fastq.gz | sed -n '2~4p' | awk '{print length($0)}' | sort -n | uniq -c > 303R1_Pairedlength_dist.txt
zcat SRR25630303_2_paired.fastq.gz | sed -n '2~4p' | awk '{print length($0)}' | sort -n | uniq -c > 303R2_Pairedlength_dist.txt

zcat SRR25630398_1_paired.fastq.gz | sed -n '2~4p' | awk '{print length($0)}' | sort -n | uniq -c > 398R1_Pairedlength_dist.txt
zcat SRR25630398_2_paired.fastq.gz | sed -n '2~4p' | awk '{print length($0)}' | sort -n | uniq -c > 398R2_Pairedlength_dist.txt

```


9.  Bonus - Run `FastQC` on your trimmed data. Comment on differences you observe between the trimmed and untrimmed data. Include any figures needed to support your conclusions.
