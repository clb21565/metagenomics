#!/bin/bash
#SBATCH -t 140:00:00
#SBATCH -p k80_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 32

source activate prodigal
prodigal -i my.metagenome.fna -o my.genes -a my.proteins.faa -p meta


