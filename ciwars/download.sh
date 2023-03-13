#!/bin/bash
#SBATCH --time=10:00:00
#SBATCH --partition=normal_q
#SBATCH --mem=30G
#SBATCH --account=prudenlab

infile=`echo ${1} | sed "s,.txt,,g"`
echo $infile
tr '\n' ' ' < ${1} > ${infile}_horizontal.txt

SRAs=`cat 230224_VA_BACTERIA_3054_horizontal.txt`
# "SEDSRASHERE"

cp collect.py work.py; sed -i "s,SEDSRASHERE,$SRAs,g" work.py

#outdir=${2}

outdir=/projects/ciwars/pathogen_annotation/genome_epi/${infile}
echo "output in" ${outdir}

mkdir ${outdir}

sed -i "s,SEDOUTDIRHERE,$outdir,g" work.py



#python collect.py


