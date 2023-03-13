#!/bin/bash
#SBATCH --time=140:00:00
#SBATCH --partition=largemem_q
#SBATCH --account=prudenlab
#SBATCH -N 1
#SBATCH -n 128


data='/projects/ciwars/pathogen_annotation/genome_epi/230224_VA_BACTERIA_3054_output'
outputdir='/projects/ciwars/pathogen_annotation/genome_epi/results/230224_VA_BACTERIA_3054'


#coverm contig -b ${data}/*.argctgs.sorted.bam --min-read-percent-identity 97 -m rpkm -t 128 -o $outputdir/argctgs.rpkm.tsv
#coverm contig -b ${data}/*.inti1ctgs.sorted.bam --min-read-percent-identity 97 -m rpkm -t 128 -o $outputdir/inti1ctgs.rpkm.tsv
#coverm contig -b --contig-end-exclusion 0 ${data}/*.plasmidctgs.sorted.bam --min-read-percent-identity 97 -m rpkm -t 128 -o $outputdir/plasmidctgs.rpkm.tsv

coverm contig --contig-end-exclusion 0 -b ${data}/*.otusctgs.sorted.bam --min-read-percent-identity 97 -m rpkm -t 128 -o $outputdir/otus.rpkm.tsv


#coverm contig -b ${data}/*.argctgs.sorted.bam --min-read-percent-identity 97 -m metabat -t 128 -o $outputdir/argctgs.metabat.tsv
#coverm contig -b ${data}/*.inti1ctgs.sorted.bam --min-read-percent-identity 97 -m metabat -t 128 -o $outputdir/inti1ctgs.metabat.tsv
#coverm contig -b ${data}/*.plasmidctgs.sorted.bam --min-read-percent-identity 97 -m metabat -t 128 -o $outputdir/plasmidctgs.metabat.tsv
#coverm contig -b ${data}/*.otusctgs.sorted.bam --min-read-percent-identity 97 -m rpkm -t 128 -o $outputdir/otus.rpkm.tsv
#data='/projects/ciwars/pathogen_annotation/genome_epi/230224_VA_BACTERIA_3054_output/SRR8837010.plasmidctgs.sorted.bam'
#outputdir='/projects/ciwars/pathogen_annotation/genome_epi/results'

#wc -l ${data}
#ls ${outputdir}/

#while read l in ${lines}
#do
#outname=echo `${l} | sed "s,sorted.bam,,g"`


#coverm contig -b ${l} --min-read-percent-identity 97 -m metabat -t 128 -o $outputdir/test_mb.tsv
#coverm contig -b ${l} --min-read-percent-identity 97 -m covered_fraction -t 128 -o $outputdir/test_cf.tsv
#done < ${1}


