#!/bin/bash
#SBATCH -t 140:00:00
#SBATCH -p largemem_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 32

source activate bowtie
module load parallel/20180222
#bowtie2-build --large-index -f --threads 32 --seed 05121994 ../assemblies/ALL_OPERA-MS/contigs.fasta coassembly_index

sampledir=/work/cascades/clb21565/WW_Analysis/hsp/data/merged
BOWTIEIDX=/work/cascades/clb21565/WW_Analysis/hsp/bowtie/coassembly_index 

cd $sampledir 

#samples=`ls *final.fq | awk '{split($_,x,".final.fq"); print x[1]}' | sort | uniq`
outdir='/work/cascades/clb21565/WW_Analysis/hsp/bowtie'

#function pbowie2() {
#n=$(basename "$1")
#while read l; 

for sample in $samples
do
bowtie2 -p 32 --very-sensitive -S $l.sam --un . --interleaved ${sample}.final.fq -x coassembly_index 
done
#done < $1 
#}

#export -f pbowie2 

#find . -maxdepth 1 -type f -name "x*" | parallel -j 32 pbowie2 {}
