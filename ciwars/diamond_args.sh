#!/bin/bash
#SBATCH --time=140:00:00
#SBATCH --partition=normal_q
#SBATCH --account=prudenlab
#SBATCH -N 1
#SBATCH -n 128

OUTDIR='/projects/ciwars/pathogen_annotation/genome_epi/230224_VA_BACTERIA_3054_output'
DATABASEDIR='/projects/ciwars/pathogen_annotation/genome_epi/databases/diamond_dbs'
while read l in $lines
do
cat ${l}_1.fastq ${l}_2.fastq > ${l}_merged.fastq

#databases to search: ARGs_derep.dmnd,card311.dmnd,inti1_derep.dmnd,mobileOGdb_1.6.dmnd,plasmid_derep.dmnd

DB='ARGs_derep'
diamond blastx -d ${DATABASEDIR}/${DB} -k 5 --id 95 -q ${l}_merged.fastq --outfmt 6 qtitle sseqid pident bitscore slen qlen len -o ${OUTDIR}/${l}_${DB}.tsv
DB='card311'
diamond blastx -d ${DATABASEDIR}/${DB} -k 5 --id 95 -q ${l}_merged.fastq --outfmt 6 qtitle sseqid pident bitscore slen qlen len -o ${OUTDIR}/${l}_${DB}.tsv

#DB='inti1_derep'
#diamond blastx -d ${DATABASEDIR}/${DB} -k 5 --id 95 -q ${l}_merged.fastq --outfmt 6 qtitle sseqid pident bitscore slen qlen len -o ${OUTDIR}/${l}_${DB}.tsv
#DB='mobileOGdb_1.6'
#diamond blastx -d ${DATABASEDIR}/${DB} -k 5 --id 95 -q ${l}_merged.fastq --outfmt 6 qtitle sseqid pident bitscore slen qlen len -o ${OUTDIR}/${l}_${DB}.tsv
#DB='plasmid_derep'
#diamond blastx -d ${DATABASEDIR}/${DB} -k 5 --id 95 -q ${l}_merged.fastq --outfmt 6 qtitle sseqid pident bitscore slen qlen len -o ${OUTDIR}/${l}_${DB}.tsv

done < ${1}
