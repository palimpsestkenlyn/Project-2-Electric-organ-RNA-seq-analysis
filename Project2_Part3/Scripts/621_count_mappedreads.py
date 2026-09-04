#!/usr/bin/env python
import argparse

parser = argparse.ArgumentParser(description="Count mapped and unmapped primary alignments in a SAM file.")
parser.add_argument("-f", "--file", required=True, help="Path to input SAM file")
args = parser.parse_args()


# Two counters for final answer.
mapped_count = 0
unmapped_count = 0

# Open the ORIGINAL sam file (all chromosomes, not the chr1-filtered one).
with open(args.file, "r") as fh:

    for line in fh:

        # Skip header lines: they start with "@" and describe the reference, not reads.
        if not line.startswith("@"):

            # Split the tab-separated line into a list of fields so can get just flags to use
            fields = line.split("\t")
            flag = int(fields[1])   # field 2 is the FLAG but a str and need int for math in flag

            # STEP 1: is this a SECONDARY alignment? (the bit worth 256)
            # (flag & 256) == 256 means the secondary bit is ON, so it's a duplicate and want to skip this line.
            # Only proceed when that bit is OFF (a primary line: exactly one per read).
            if (flag & 256) != 256:

                # STEP 2 (mapped test): did this read map? (the bit worth 4 = "unmapped")
                # (flag & 4) != 4 means the unmapped bit is OFF, so the read mapped.
                if (flag & 4) != 4:
                    mapped_count += 1
                else:
                    unmapped_count += 1

# Print the two numbers for Answers.md.
print(f"File: {args.file}")
print("Mapped reads:", mapped_count)
print("Unmapped reads:", unmapped_count)