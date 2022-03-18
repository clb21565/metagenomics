#!/bin/bash
#SBATCH -t 140:00:00
#SBATCH -p k80_q
#SBATCH -A prudenlab
#SBATCH -n 32
#SBATCH -N 1

source activate krakken

#sampledir=/work/cascades/clb21565/WW_Analysis/hsp/data/merged

KRAKEN_DB=/groups/apruden_lab/kraken2_db/
KMER_LEN=35
READ_LEN=150
KRAKEN_INSTALLATION=~/.conda/envs/krakken/bin/
THREADS=32
THRESHOLD=0

sampledir=/work/cascades/clb21565/WW_Analysis/hsp/taxonomy
outdir=/work/cascades/clb21565/WW_Analysis/hsp/taxonomy

cd $sampledir 

samples=`ls *report | awk '{split($_,x,".report"); print x[1]}' | sort | uniq`

for sample in $samples
do
#kraken2 --output ${outdir}/${sample}.out --report ${outdir}/${sample}.report --db $KRAKEN_DB ${sample}.final.fq
bracken -d ${KRAKEN_DB} -i ${sample}.report -o bracken/${sample}.order.bracken -r ${READ_LEN} -l O -t ${THRESHOLD}
bracken -d ${KRAKEN_DB} -i ${sample}.report -o bracken/${sample}.phylum.bracken -r ${READ_LEN} -l P -t ${THRESHOLD}
bracken -d ${KRAKEN_DB} -i ${sample}.report -o bracken/${sample}.genus.bracken -r ${READ_LEN} -l G -t ${THRESHOLD}
bracken -d ${KRAKEN_DB} -i ${sample}.report -o bracken/${sample}.family.bracken -r ${READ_LEN} -l P -t ${THRESHOLD}
bracken  -d ${KRAKEN_DB} -i ${sample}.report -o bracken/${sample}.species.bracken -r ${READ_LEN} -l S -t ${THRESHOLD}
done

#bracken-build -d ${KRAKEN_DB} -t ${THREADS} -k ${KMER_LEN} -l ${READ_LEN} -x ${KRAKEN_INSTALLATION}
#kraken2-build --db=${KRAKEN_DB} --threads=$THREADS
#THRESHOLD=0

#samples=`ls *_R1_001.fastq.gz.all.report | awk '{split($_,x,"_R1_001.fastq.gz.all.report"); print x[1]}' | sort | uniq`

#for sample in $samples
#do
#bracken -d ${KRAKEN_DB} -i ${sample}_R1_001.fastq.gz.all.report -o ${sample}.phylum.bracken -r ${READ_LEN} -l P -t ${THRESHOLD}
#bracken -d ${KRAKEN_DB} -i ${sample}_R1_001.fastq.gz.all.report -o ${sample}.genus.bracken -r ${READ_LEN} -l G -t ${THRESHOLD}
#done




#samples=`ls *_R1_001.fastq.gz.all.report | awk '{split($_,x,"_R1_001.fastq.gz.all.report"); print x[1]}' | sort | uniq`
#for sample in $samples
#do
#bracken -d ${KRAKEN_DB} -i ${sample}_R1_001.fastq.gz.all.report -o ${sample}.species.bracken -r ${READ_LEN} -t ${THRESHOLD}
#done

#module load Anaconda
#source activate krakken 

#samples=*R1*

#for sample in $samples 
#do
#kraken2 --output ${sample}.virus.report --report ${sample}.virus.report --gzip-compressed --db ~/.conda/envs/krakken/db ${sample} 
#done
