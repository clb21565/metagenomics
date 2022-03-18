#!/bin/bash
#SBATCH -t 140:00:00
#SBATCH -p k80_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 32

module load Anaconda
#source activate minimap2
sampledir='/work/cascades/clb21565/WW_Analysis/hsp/assemblies/OUT'
woutdir='/groups/cs6824_f19/tmp_sams'
datadir='/work/cascades/clb21565/WW_Analysis/hsp/data/merged'

cd ${sampledir}

samples=`ls *.fasta | awk '{split($_,x,".fasta"); print x[1]}' | sort | uniq`
#samples='AAOLJ3001L'
for sample in $samples
do
source activate minimap2
minimap2 -a ${sampledir}/${sample}.fasta ${datadir}/${sample}.final.fq > ${sampledir}/${sample}.sam
samtools view -T ${sampledir}/${sample}.sam -b ${sample}.sam > ${sample}.bam
samtools sort ${sample}.bam -o ${sample}.sorted.bam
rm ${sample}.sam
rm ${sample}.bam
source activate /home/clb21565/miniconda3/envs/metabat2
runMetaBat.sh --seed 1 -m 1500 -t 32 ${sample}.fasta ${sample}.sorted.bam
done 
