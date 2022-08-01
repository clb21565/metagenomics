#!/bin/bash
#SBATCH -t 140:00:00
#SBATCH -p largemem_q
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 32

module purge
module load Anaconda
source activate /home/clb21565/miniconda3/envs/megahit 

DATADIR='/work/cascades/clb21565/WW_Analysis/hsp/data'
SCRIPTDIR='/work/cascades/clb21565/WW_Analysis/hsp/scripts'
KEYDIR='/work/cascades/clb21565/WW_Analysis/hsp/sample_keys'
OUTDIR='/work/cascades/clb21565/WW_Analysis/hsp/assemblies/'

cd $DATADIR
 
samples=`ls *_R1_001.fastq.gz | awk '{split($_,x,"_S"); print x[1]}' | sort | uniq` #Gets you a list of sample names from raw read files 
# Merge samples and interleave paired end reads.  
mkdir merged
for sample in ${samples}
do
cat ${sample}*R1* > ${sample}.R1.fq.gz
cat ${sample}*R2* > ${sample}.R2.fq.gz 
python ${SCRIPTDIR}/interleave.py ${sample}.R1.fq.gz ${sample}.R2.fq.gz > ${sample}.fq.gz
reformat.sh in1=${sample}.R1.fq.gz in2=${sample}.R2.fq.gz out=${sample}.fq.gz
mv ${sample}.fq.gz merged
done

#samples=`ls *.fq.gz | awk '{split($_,x,".fq.gz"); print x[1]}' | sort | uniq` #Gets you a list of sample names from merged & interleaved fq files 
cd /work/cascades/clb21565/WW_Analysis/hsp/data/merged 
samples=`ls *.fq.gz | awk '{split($_,x,".fq.gz"); print x[1]}' | sort | uniq` #Gets you a list of sample names from merged & interleaved fq files 
for sample in ${samples}
do
bbduk.sh in=${sample}.fq.gz out=${sample}.clean.fq ref=${SCRIPTDIR}/adapters.fa ktrim=r k=23 mink=11 hdist=1 tpe tbo
bbduk.sh in=${sample}.clean.fq out=${sample}.quality.clean.fq maq=4
rm ${sample}.fq.gz 
rm ${sample}.clean.fq
done
#cd /work/cascades/clb21565/WW_Analysis/hsp/data/merged 
samples=`ls *.quality.clean.fq | awk '{split($_,x,".quality.clean.fq"); print x[1]}' | sort | uniq` #Gets you a list of sample names from quality filtered fqss
for sample in $samples 
do
bbduk.sh in=${sample}.quality.clean.fq out=${sample} bhist=${sample}.bhist.txt qhist=${sample}.qhist.txt gchist=${sample}.gchist.txt aqhist=${sample}.aqhist.txt lhist=${sample}.lhist.txt gcbins=auto
done

mkdir hists
mv *hist.txt hists

