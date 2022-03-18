#!/bin/bash
#SBATCH -t 140:00:00
#SBATCH -p k80_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 32
#source activate metabat2
runMetaBat.sh --unbinned  --seed 1 -m 1500 -t 32 /work/cascades/clb21565/WW_Analysis/hsp/assemblies/ALL_OPERA-MS/contigs.fasta *bam
source activate taxtk
gtdbtk classify_wf --genome_dir . --cpus 32 --out_dir . -x .fa
