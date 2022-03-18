#!/bin/bash 
#SBATCH -t 140:00:00
#SBATCH -p largemem_q 
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 72

module load gcc/7.3.0
module load intel/18.2
module load jdk 
module load R/3.6.2 

source activate opera-ms 

operadir='/work/cascades/clb21565/OPERA-MS'
contigs='/work/cascades/clb21565/WW_Analysis/hsp/assemblies/coassembly/all/all_merged.contigs.fa'
r1='/groups/metastorm_cscee/for_justin/hospital_effluent/reads-1.fq'
r2='/groups/metastorm_cscee/for_justin/hospital_effluent/reads-2.fq'
nanopore='/work/cascades/clb21565/WW_Analysis/hsp/scripts/assembly/HYBRIDSPADES/hsp_nanopore.fasta' #/work/cascades/clb21565/WW_Analysis/hsp/nanopore/fastqs/merged.fq'
outdir='/work/cascades/clb21565/WW_Analysis/hsp/assemblies/ALL_OPERA-MS.3'

perl ${operadir}/OPERA-MS.pl --contig-file ${contigs} \
	--short-read1 $r1 --short-read2 $r2 --contig-len-thr 1000 --out-dir ${outdir} --long-read ${nanopore} \
	--num-processors 72 --long-read-mapper minimap2
