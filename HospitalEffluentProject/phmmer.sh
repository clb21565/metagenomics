#!/bin/bash
#SBATCH -t 140:00:00
#SBATCH -p normal_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 24
source activate biopy 
module load parallel/20180222
function hmmer() {
    n=$(basename "$1")
    hmmsearch -Z 2000000 --domZ 89 --cpu 1 -o $1.output.hmmsearch.txt cpr_43_markers.hmm $1
#prodigal -a ${1}.faa -d ${1}.fna -p meta
}

export -f hmmer
find . -maxdepth 1 -type f -name "x*" | parallel -j 24 hmmer {}


