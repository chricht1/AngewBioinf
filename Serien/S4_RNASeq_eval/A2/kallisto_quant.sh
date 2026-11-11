# Kallisto RNA-Seq Quantification with Pseudo-Alignment for single-end reads:

# Input:
# Provide paths to following files as command line arguments
# 1. number of threads (>=1)
# 2. Genome fasta-File
# 3. estimated mean fragment length in bp unit
# 4. estimated standard deviation of fragment length
# 5. RNA-Seq fastq Files (can be gzipped)

# Output: (in current working directory)
# 1. genome index file needed for quantification named kallisto_idx
# 2. quantification results: abundance.h5, abundance.tsv
# 3. info file: run_info.json


# how to execute: 
# in the directory of this script run: chmod u+x kallisto_quant.sh
# execute the bash script with the input arguments 


#!/bin/bash
#arr=( "a" "b" c )
#echo ${arr[@]:1}
echo ${@:2}
kallisto index -t $1 -i kallisto_idx $2

# use --single because we have single end reads
kallisto quant -t $1 --single -l $3 -s $4 -i kallisto_idx ${@:5}