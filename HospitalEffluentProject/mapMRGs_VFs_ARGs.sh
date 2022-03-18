#!/bin/bash
#SBATCH -t 140:00:00
#SBATCH -p normal_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 24

#source activate /home/clb21565/miniconda3/envs/prodigal

#sampledir='/work/cascades/clb21565/phase-1_mgedbs/analysis/20210601/1000NPdb/MQ_HQ_MAGs_Figshare_bundle'
#outdir='/work/cascades/clb21565/phase-1_mgedbs/analysis/20210601/50_genomes'

#mkdir $outdir
#cd $sampledir 

#samples=*
#cp `ls . | head -50` ${outdir}

#cd $outdir

#samples=`ls . | head -50`

#for sample in $samples 
#do
#prodigal -p single -i ${sample} -a ${outdir}/${sample}.faa
#done

#--id                   minimum identity% to report an alignment
#--query-cover          minimum query cover% to report an alignment
#--subject-cover        minimum subject cover% to report an alignment
#--sensitive            enable sensitive mode (default: fast)
#--more-sensitive       enable more sensitive mode (default: fast)

#idatabase=/work/cascades/clb21565/WW_Analysis/databases/mobileOG-db_beatrix-1.0_ALL.dmnd
#database=mobileOG-db.beatrix1.3.dmnd
source activate biopy

#samples=* | tail -1500

#samples=`ls * | awk '{split($_,x,".fasta.faa"); print x[1]}' | sort | uniq`
databases="ExperimentalMRGs VFDB CARD3.0.7"

samples=`ls *.fasta.faa | awk '{split($_,x,".fasta.faa"); print x[1]}' | sort | uniq`

for database in $databases
do
for sample in $samples
do
diamond blastp -q ${sample}.fasta.faa -d $database -o ${sample}.${database}.tsv -f 6 stitle qtitle pident bitscore slen evalue qlen sstart send qstart qend --id 40 --query-cover 80  --evalue 0.00000000000000000001 -k 1 -p 24 --more-sensitive 
done
done
