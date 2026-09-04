## Project2_Part3 Answers

## Lab notebook, in lab notebook repo. Found here: https://github.com/palimpsestkenlyn/Labnotebooks_623

specific lab notebook is called PR2_Labnotebook.md

10. package install details, see lab notebook. All pixi add. 

Environment:
[workspace]
channels = ["conda-forge", "bioconda"]
name = "Project2_QAA"
platforms = ["linux-64"]
version = "0.1.0"

[tasks]

[dependencies]
fastqc = ">=0.12.1,<0.13"
cutadapt = ">=5.2,<6"
trimmomatic = ">=0.41,<0.42"
matplotlib = ">=3.11.1,<4"
pandas = ">=3.0.5,<4"
star = ">=2.7.11b,<3"
samtools = ">=1.23.1,<2"
numpy = ">=2.5.2,<3"
htseq = ">=2.1.2,<3"
agat = ">=1.7.0,<2"
rom this section to Project2_Part3/Project2_Part3_answers.txt.**


13. 

```
TALAPAS n0097 (/gpfs/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris_sample.alignments) 09:45 PM $ python 621_count_mappedreads.py -f /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris_sample.alignments/Star_alignments/SRR25630303/SRR25630303_Aligned.out.sam
File: /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris_sample.alignments/Star_alignments/SRR25630303/SRR25630303_Aligned.out.sam
Mapped reads: 79621037
Unmapped reads: 3651623
TALAPAS n0097 (/gpfs/projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris_sample.alignments) 09:50 PM $ python 621_count_mappedreads.py -f /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris_sample.alignments/Star_alignments/SRR25630398/SRR25630398_Aligned.out.sam
File: /projects/bgmp/hodapp/bioinfo/Bi623/PR2/Project2_QAA/6_C_compressirostris_sample.alignments/Star_alignments/SRR25630398/SRR25630398_Aligned.out.sam
Mapped reads: 64341367
Unmapped reads: 4777469
```
SRR25630303:
Mapped reads: 79621037
Unmapped reads: 3651623
79,621,037 / (79,621,037 + 3,651,623) = 95.6% mapped

SRR25630398:
Mapped reads: 64341367
Unmapped reads: 4777469
64,341,367 / (64,341,367 + 4,777,469) = 93.1% mapped


14. Count reads that map to features using `htseq-count`. You should run htseq-count twice: once with `--stranded=yes` and again with `--stranded=reverse`. Use default parameters otherwise. You may need to use the `-i` parameter for this run.

| Sample      | Forward (yes)                      | Reverse                              |
| ----------- | ---------------------------------- | ------------------------------------ |
| SRR25630303 | 1,368,032 / 41,636,330 = **3.29%** | 24,841,228 / 41,636,330 = **59.67%** |
| SRR25630398 | 1,001,555 / 34,559,418 = **2.90%** | 18,653,979 / 34,559,418 = **53.98%** |

15. 

Counted totals, then counted everything mapped to a feature. Then math for % mapped.

awk '{sum+=$2} END {print sum}' SRR25630303_htseqcounts_forwardstranded.txt 
41636330
```

```
grep -v '^__' SRR25630303_htseqcounts_forwardstranded.txt | awk '{sum+=$2} END {print sum}'
1368032
```
mapped total: 1368032

SRR25630303_htseqcounts_reversestranded: 
total: 41636330
```
awk '{sum+=$2} END {print sum}' SRR25630303_htseqcounts_reversestranded.txt 
41636330
```

```
PM $ grep -v '^__' SRR25630303_htseqcounts_reversestranded.txt | awk '{sum+=$2} END {print sum}'
24841228
```
mapped total: 24841228


SRR25630398_htseqcounts_forwardstranded
```
awk '{sum+=$2} END {print sum}' SRR25630398_htseqcounts_forwardstranded.txt
34559418
```
total: 34559418


```
grep -v '^__' SRR25630398_htseqcounts_forwardstranded.txt | awk '{sum+=$2} END {print sum}'
1001555
```
mapped: 1001555
% mapped: (1001555/34559418)=

SRR25630398_htseqcounts_reversestranded
```
awk '{sum+=$2} END {print sum}' SRR25630398_htseqcounts_reversestranded.txt 
34559418
```
total: 34559418

```
grep -v '^__' SRR25630398_htseqcounts_reversestranded.txt | awk '{sum+=$2} END {print sum}'
18653979


I propose that these data are strand-specific because in both samples, the proportion of reads assigned to features was substantially higher under `--stranded=reverse` than under `--stranded=yes`. SRR25630303 showed 59.7% of reads counted under reverse-stranded settings versus 3.3% under forward/yes-stranded. SRR25630398 showed 54.0% under reverse versus 2.9% under forward/yes. This large asymmetry between the two settings would not be expected from an unstranded library. In the case of an unstranded library it would be likely that forward and reverse assignment proportions should be roughly comparable/equal. This data are consistent with the directional library prep kit used (NEXTFLEX Rapid Directional RNA-Seq Kit) mentioned, which preserves the original strand information, AKA is a stranded library prep. Based on this evidence and logic, `--stranded=reverse` is the correct parameter for counting reads in downstream differential gene expression analysis, since it reflects accurate feature read assignments rather than the mismatched, underrepresented counts produced under the incorrect (forward/yes) strand assumption.
