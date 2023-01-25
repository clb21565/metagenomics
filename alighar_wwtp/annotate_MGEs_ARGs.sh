#!/bin/bash
#SBATCH -t 24:00:00
#SBATCH -p largemem_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 128
#args
database=$2
diamond blastp --id 90 -e 1e-10 -q $1 -d $database -o $3 -f 6 stitle qtitle pident bitscore slen evalue qlen sstart send qstart qend -k 1 -p 128
# mges
database=$2
diamond blastp -e 1e-10 -q $1 -d $database -o $3 -f 6 stitle qtitle pident bitscore slen evalue qlen sstart send qstart qend -k 1 -p 128
