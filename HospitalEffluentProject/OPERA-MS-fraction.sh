#!/bin/bash 
#SBATCH -t 140:00:00
#SBATCH -p normal_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 32

module load gcc/7.3.0
module load intel/18.2
module load jdk 
module load R/3.6.2 
source activate opera-ms

operadir='/work/cascades/clb21565/OPERA-MS'
#nanopore='/work/cascades/clb21565/WW_Analysis/hsp/nanopore/fastqs/merged.fq'
nanopore='/work/cascades/clb21565/WW_Analysis/hsp/scripts/assembly/HYBRIDSPADES/hsp_nanopore.fasta'
sampledir='/work/cascades/clb21565/WW_Analysis/hsp/data/merged'
workdir='/work/cascades/clb21565/WW_Analysis/hsp/scripts/assembly'
outdir='/work/cascades/clb21565/WW_Analysis/hsp/assemblies/final_effluent'
#outdir='/work/cascades/clb21565/WW_Analysis/hsp/assemblies/mixed_liquor'

sample='FE'
#for sample in $samples
#do
#sample='rush'


mkdir ${outdir}
mkdir ${outdir}/${sample}
while read l; do cp ${sampledir}/${l}*fastq.gz ${outdir}/${sample}/; done < finaleffluent.txt
cd ${outdir}/${sample}
cat *R1* > merged.r1.fq 
cat *R2* > merged.r2.fq 
rm *R*.fastq 
perl ${operadir}/OPERA-MS.pl --long-read-mapper minimap2 --short-read1 ${outdir}/${sample}/merged.r1.fq --short-read2 ${outdir}/${sample}/merged.r2.fq --out-dir ${outdir}/${sample} --long-read ${nanopore} --num-processors 32 
#done
