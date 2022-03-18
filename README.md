## metagenomics scripts repository for environmental microbiome projects
hi there internet, you found my repository. I am just putting stuff here to store scripts for publications and share with labmates. 



#### just a compilation of helpful bash exploits

| function  | code |
| ------------------------ | -------------------- |
|  Replace fasta headers with FILENAME_ENTRY  | awk '/^>/ {gsub(/.fa(sta)?$/,"",FILENAME);printf(">%s\n",++i "\_" FILENAME);next;} {print}' input.fa  |
| Remove redundant entries from a multifasta file.   | awk '/^>/{f=!d[$1];d[$1]=1}f' singleline.fasta > singleline.unique.fasta  |
| Convert multiline fasta to single line. |  awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);} END {printf("\n");}' < multi.fasta > single.fasta |
| select all entries from a gtdbtk MSA file that match a pattern | grep -A 1 "p__Myxo" --no-group-separator gtdbtk.bac120.msa.fasta > bins.txt | 

