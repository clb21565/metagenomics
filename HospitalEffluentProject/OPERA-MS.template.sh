#!/bin/bash 
#SBATCH -t 140:00:00
#SBATCH -p largemem_q 
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 32

module load gcc/7.3.0
module load intel/18.2
module load jdk 
module load R/3.6.2 

source activate opera-ms

operadir='/work/cascades/clb21565/OPERA-MS'
nanopore='/work/cascades/clb21565/WW_Analysis/hsp/nanopore/fastqs/merged.fq'
outdir='/work/cascades/clb21565/WW_Analysis/hsp/assemblies/reactor_specific'
#samples='o1 o2 o3 p1 p2 p3'
samples='p2 p3'
#samples='TEN ZERO'
sampledir='/work/cascades/clb21565/WW_Analysis/hsp/data/merged'
workdir='/work/cascades/clb21565/WW_Analysis/hsp/scripts/assembly'
#outdir='/work/cascades/clb21565/WW_Analysis/hsp/assemblies/condition'
for sample in $samples
do
mkdir ${outdir}/${sample}
while read l; do cp ${sampledir}/${l}*fastq ${outdir}/${sample}/; done < ${workdir}/${sample}.txt.ux
cd ${outdir}/${sample}
cat *R1* > merged.r1.fq 
cat *R2* > merged.r2.fq 
rm *R*.fastq 
perl ${operadir}/OPERA-MS.pl --short-read1 ${outdir}/${sample}/merged.r1.fq --short-read2 ${outdir}/${sample}/merged.r2.fq --out-dir ${outdir}/${sample} --long-read ${nanopore} --num-processors 32 
done
