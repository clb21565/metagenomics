#!/bin/bash
#SBATCH -t 140:00:00
#SBATCH -p k80_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 32

module load parallel/20180222

function hmmer() {
    n=$(basename "$1")
    prodigal -a ${1}.faa -d ${1}.fna -p meta -i $1
}

samples=sample
split -n l/32 $sample.fasta

export -f pprodigal
find . -maxdepth 1 -type f -name "x*" | parallel -j 32 pprodigal {}
