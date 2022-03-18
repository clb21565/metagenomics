#!/bin/bash 
#SBATCH -t 140:00:00
#SBATCH -p largemem_q 
#SBATCH -A prudenlab
#SBATCH -N 1 
#SBATCH -n 72
#module load gcc/7.3.0
#module load intel/18.2
#module load jdk 
#module load R/3.6.2 
#source activate opera-ms
source activate spades
operadir='/work/cascades/clb21565/OPERA-MS'

NANOPORE='/work/cascades/clb21565/WW_Analysis/hsp/scripts/assembly/HYBRIDSPADES/hsp_nanopore.fasta'   #'/work/cascades/clb21565/WW_Analysis/hsp/nanopore/all_fastqs/hsp_nanopore.fna'
sampledir='/work/cascades/clb21565/WW_Analysis/hsp/data/merged'

outdir='/work/cascades/clb21565/WW_Analysis/hsp/assemblies/HS_SampleWise'
#--only-assembler
mkdir $outdir
cd ${sampledir}
#samples=`ls *.final.fq | awk '{split($_,x,".final.fq"); print x[1]}' | sort | uniq | head -50`
#samples=`ls *.final.fq | awk '{split($_,x,".final.fq"); print x[1]}' | sort | uniq | tail -40 | sort | uniq | head -10`
#samples=`ls *.final.fq | awk '{split($_,x,".final.fq"); print x[1]}' | sort | uniq | tail -30 | sort | uniq | head -10`
#samples=`ls *.final.fq | awk '{split($_,x,".final.fq"); print x[1]}' | sort | uniq | tail -20 | sort | uniq | head -10`

#samples=`ls *.final.fq | awk '{split($_,x,".final.fq"); print x[1]}' | sort | uniq | head -50 | sort | uniq | tail -40`
#samples='NOAOR5976A ZFYKJ6264T XVJHZ6745S ZHXHU7580Y YTCDV3980T LZGQG4924W YGECA1284U'
#NOAOR5976A ZFYKJ6264T XVJHZ6745S ZHXHU7580Y YTCDV3980T LZGQG4924W YGECA1284U
#samples='NJJXB7326T XVVHV0835V ZRQMP3158R NEAWE3101W ZYTXN5029K YOGJP6828Y YPQCU7286X'
#samples='MRGNY0672A FFXIX2867H NZVQQ9792V MHETY4827Z RTCST0504P NQWTN3218U NLQVX0980P'
#samples='MGTBM3934B MFLOV6047U'
#samples=`ls *.final.fq | awk '{split($_,x,".final.fq"); print x[1]}' | sort | uniq | tail -0 | sort | uniq | head -5`
#samples='MFLOV6047U NJJXB7326T YPQCU7286X NLQVX0980P NOAOR5976A ZYTXN5029K MHETY4827Z ZFYKJ6264T RTCST0504P YTCDV3980T XVVHV0835V YOGJP6828Y'
#samples='ZRQMP3158R MRGNY0672A NQWTN3218U XVJHZ6745S ZHXHU7580Y LZGQG4924W NEAWE3101W YGECA1284U FFXIX2867H NZVQQ9792V MGTBM3934B'
#samples='YGECA1284U FFXIX2867H NZVQQ9792V MGTBM3934B'
samples='YTCDV3980T XVVHV0835V YOGJP6828Y'
for sample in $samples
do
#perl ${operadir}/OPERA-MS.pl --long-read-mapper minimap2 --short-read1 ${sampledir}/${sample}.R1.fastq --short-read2 ${sampledir}/${sample}.R2.fastq --out-dir ${outdir}/${sample} --long-read ${nanopore} --num-processors 32 --no-polishing
metaspades.py -o /work/cascades/clb21565/WW_Analysis/hsp/assemblies/HS_SampleWise/${sample} --only-assembler --12 $sample.final.fq --nanopore $NANOPORE -t 32 -m 650
done
