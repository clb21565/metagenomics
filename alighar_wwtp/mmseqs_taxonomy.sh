#!/bin/bash
#SBATCH -t 24:00:00
#SBATCH -p normal_q
#SBATCH -N 1 
#SBATCH -n 128
samples=$1
GTDB='/projects/ciwars/gtdb/' # here is an mmseqs2 formatted version of the GTDB 
mmseqs createdb $samples contigs
mmseqs taxonomy contigs $GTDB assignments tmpFolder --tax-lineage 1 --majority 0.5 --vote-mode 1 --lca-mode 3 --orf-filter 1
mmseqs createtsv contigs assignments assignRes2.tsv

# example output:
#120942_S3-contigs       43012   genus   Chryseomicrobium        1       1       1       1.000   d_Bacteria;p_Firmicutes;c_Bacilli;o_Bacillales A;f_Planococcaceae;g_Chryseomicrobium
#120974_S3-contigs       6694    species Brevundimonas sp002979535       1       1       1       1.000   d_Bacteria;p_Proteobacteria;c_Alphaproteobacteria;o_Caulobacterales;f_Caulobacteraceae;g_Brevundimonas;s_Brevundimonas sp00297
