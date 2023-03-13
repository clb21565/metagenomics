#!/bin/bash
#SBATCH --time=10:00:00
#SBATCH --partition=normal_q
#SBATCH --account=prudenlab
#SBATCH -N 1
#SBATCH -n 32

OUTDIR='/projects/ciwars/pathogen_annotation/genome_epi/230224_VA_BACTERIA_3054_output'
DATABASEDIR='/projects/ciwars/pathogen_annotation/genome_epi/databases/diamond_dbs'
while read l in $lines
do

cat ${l}_1.fastq ${l}_2.fastq > ${l}_merged.fastq

DATABASEDIR=/projects/ciwars/pathogen_annotation/genome_epi/databases/diamond_dbs
DB
diamond blastx -d -k 1 --id 80 -q ${l}_merged.fastq --outfmt 6 qseqid sseqid pident bitscore slen qlen len



done < ${1}

