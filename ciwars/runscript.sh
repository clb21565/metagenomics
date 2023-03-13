#!/bin/bash
#SBATCH -t 1:00:00
#SBATCH -p normal_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 12


while read l in ${lines}; do ./get_reads.sh ${l}; done < $1


