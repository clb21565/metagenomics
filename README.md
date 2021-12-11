# Helpful scripts for metagenomics
scripts for analyzing metagenomics data

1. Replace fasta headers with FILENAME_ENTRY

awk '/^>/ {gsub(/.fa(sta)?$/,"",FILENAME);printf(">%s\n",++i "\_" FILENAME);next;} {print}' input.fa

2. Remove redundant entries from a multifasta file. 

awk '/^>/{f=!d[$1];d[$1]=1}f' ints_and_refs.single.fasta > ints_and_refs.single.unique.fasta

3. Convert multiline fasta to single line. 

awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);} END {printf("\n");}' < In.fa > Out.single.fa

4. Convert single line to tsv (linear) fasta file.

perl -pe 's/>(.*)/>\1\t/g; s/\n//g; s/>/\n>/g' in.fasta | grep -v '^$' > out.tsv
