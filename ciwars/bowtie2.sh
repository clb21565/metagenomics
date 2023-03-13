#!/bin/bash
#SBATCH -t 140:00:00
#SBATCH -p normal_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 128

function pbt2(){
n=$(basename "$1")

	OUTDIR='/projects/ciwars/pathogen_annotation/genome_epi/230224_VA_BACTERIA_3054_output'
	BT2DIR='/projects/ciwars/pathogen_annotation/genome_epi/databases/bt2'
	
	#bowtie2 --mm --very-sensitive -X 1000 -x $BT2DIR/ARG_ctg99 -1 ${1}_1.fastq -2 ${1}_2.fastq | samtools view -b | samtools sort -o $OUTDIR/${1}.argctgs.sorted.bam
	#bowtie2 --mm --very-sensitive -X 1000 -x $BT2DIR/plasmids_mgeContigs -1 ${1}_1.fastq -2 ${1}_2.fastq | samtools view -b | samtools sort -o $OUTDIR/${1}.plasmidctgs.sorted.bam
	#bowtie2 --mm --very-sensitive -X 1000 -x $BT2DIR/inti1_mgeContigs -1 ${1}_1.fastq -2 ${1}_2.fastq | samtools view -b | samtools sort -o $OUTDIR/${1}.inti1ctgs.sorted.bam
	bowtie2 --mm --very-sensitive -X 1000 -x $BT2DIR/otus -1 ${1}_1.fastq -2 ${1}_2.fastq | samtools view -b | samtools sort -o $OUTDIR/${1}.otusctgs.sorted.bam

}

export -f pbt2

find . -maxdepth 1 -type f -name "*_1.fastq" | sed 's/_1.fastq//g' | sed 's|^./| |' | sort | uniq | parallel -j 128 pbt2{}


