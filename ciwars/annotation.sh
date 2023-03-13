#!/bin/bash
#SBATCH -t 140:00:00
#SBATCH -p normal_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 128
source activate biopy

database='/projects/ciwars/hgt_support/uniref50.dmnd' 

#database='/projects/ciwars/hgt_support/mobileOG-db-beatrix-1.6/mobileOGdb1.6.dmnd'

diamond blastp -e 1e-10 -q $1 -d $database -o $2 -f 6 stitle qtitle pident bitscore slen evalue qlen sstart send qstart qend sseq qseq -k 1 -p 128



