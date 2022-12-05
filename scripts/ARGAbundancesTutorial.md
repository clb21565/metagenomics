# Tutorial: calculating RPKM for contigs to get ARG drug class abundances 

the setup for this is to extract the contigs with ARGs on them and put them into a separate fasta file, one for each sample. 

You'll need minimap2 (I used minimap2 v 2.24-r1122), samtools, pandas, and optionally seqtk. My recommendation in general is to create a separate conda environment for each workflow to control dependencies.

For example, 

    conda create -n CalculateRPKM -c bioconda python=3.7 minimap2 samtools 

we create a conda environment called CalculateRPKM with bioconda and python v. 3.7. I think pandas comes with this, but if not, it can be installed by pip install pandas directly at the command line. 

conda activate CalculateRPKM 
	

	mm.sh {

	minimap2 -t 3 -x sr -a ${1} ${2} | samtools view -S -b | samtools sort -o ${3}.sorted.bam

	#1 -> fasta file with contigs that have ARGs
	#2 -> read files (fastq); I personally would recommend using interleaved fastq files
	#3 -> out prefix for the data  

	}

	running it:

	./mm.sh ${contigs_with_args}.fasta ${reads.fastq} ${out_prefix}

	outputs:

	${output_prefix}.sorted.bam 

To run the above, replace the generic variable terms in form ${term} with the value of the data/parameter they specify. (e.g., ./mm.sh contigs.fasta reads.fastq outprefix) 

Once this is completed, calculate coverage of the contigs by:

	samtools coverage ${out_prefix}.sorted.bam -o ${sample}.coverage.tsv 
	
Again, replace the variable terms with the actual file names. -o is the output file. Note, we do not filter the quality of the alignment at all here. 

The resulting file coverage.tsv will contain columns:

      rname       Reference name / chromosome
      startpos    Start position
      endpos      End position (or sequence length)
      numreads    Number reads aligned to the region (after filtering)
      covbases    Number of covered bases with depth >= 1
      coverage    Percentage of covered bases [0..100]
      meandepth   Mean depth of coverage
      meanbaseq   Mean baseQ in covered region
      meanmapq    Mean mapQ of selected reads 
      
After this, we'll calculate rpkm values. For this you need one additional piece of information, the number of quality filtered reads in your sample that were searched.

    python calculateRPKM.py --covFile sample.coverage.tsv --ReadsInSample ${n_quality_filtered_reads} --out_prefix ${output}.rpkm.csv 
  
  This will produce a file with the following stats:
      
      contig  Contig name 
      reads   Reads mapped to the contig
      length  length of contig in kbp
      reads   number of quality filtered reads in sample
      rpkm    reads per kilobase million
      
  
