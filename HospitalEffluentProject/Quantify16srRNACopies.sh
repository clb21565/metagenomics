#!/bin/bash
#SBATCH -t 140:00:00
#SBATCH -p k80_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 32

#bowtie2 [options]* -x <bt2-idx> {-1 <m1> -2 <m2> | -U <r> | --interleaved <i> | --sra-acc <acc> | b <bam>} -S [<sam>]
#source of database='/work/cascades/clb21565/WW_Analysis/databases/gg_13_5.fasta'
source activate bowtie2
#SampleDir=''
#OutDir=''
SampleDir='/work/cascades/clb21565/WW_Analysis/hsp/data/merged'
OutDir='/work/cascades/clb21565/WW_Analysis/hsp/readmapping'
#dbdir='/work/cascades/clb21565/WW_Analysis/databases'
DB='/work/cascades/clb21565/WW_Analysis/databases/GreenGenes_13_5'

#cd ${SampleDir}
#samples=`ls *.final.fq | awk '{split($_,x,".final.fq"); print x[1]}' | sort | uniq`
#for sample in $samples
#do
#bowtie2 -x ${DB} -p 32 --very-sensitive --interleaved ${SampleDir}/${sample}.final.fq -S ${OutDir}/${sample}.sam 
#done 

SamDir=${OutDir}
source activate minimap2 
cd ${SamDIR} 

samples=`ls *.sam | awk '{split($_,x,".sam"); print x[1]}' | sort | uniq`
for sample in $samples
do
samtools view -bS ${sample}.sam > ${sample}.bam
samtools sort ${sample}.bam > ${sample}.sorted.bam
samtools stats -F 0x4 ${sample}.sorted.bam > ${sample}.summary.txt
done

## build settings for database
#bowtie2-build -f --threads 32  gg_13_5.fasta GreenGenes_13_5
