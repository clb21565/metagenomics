#!/bin/bash

minimap2 -t 3 -x sr -a ${1} ${2} | samtools view -S -b | samtools sort -o ${3}.sorted.bam

#1 -> fasta file with contigs that have ARGs
#2 -> read files (fastq); I personally would recommend using interleaved fastq files
#3 -> out prefix for the data  
