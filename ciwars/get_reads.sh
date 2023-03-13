#!/bin/bash
#SBATCH -t 140:00:00
#SBATCH -p normal_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 128


dmnd_out=${1}
fq_dir='/projects/ciwars/pathogen_annotation/genome_epi/230224_VA_BACTERIA_3054'
#fq_dir=${2} # for generalizability 
out_dir='/projects/ciwars/pathogen_annotation/genome_epi/extracted_reads'

SRA=`echo ${dmnd_out} | sed "s,_ARGs_derep.tsv,,g"`
FASTQ=`echo ${dmnd_out} | sed "s,_ARGs_derep.tsv,_merged.fastq,g"`

cut -f 1 ${dmnd_out} | sort | uniq > ${dmnd_out}_READS
seqkit grep -f ${dmnd_out}_READS -n -w 0 -o ${out_dir}/${SRA}_assembledARG_Reads_out.fq ${fq_dir}/${FASTQ}
