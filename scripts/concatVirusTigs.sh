#!/bin/bash
#for use with metabat bins
samples=`ls ./bin*.fa | sed "s,.fa,,g" | sed "s,./,,g"`

for sample in ${samples}; do  awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);} END {printf("\n");}' < ${sample}.fa | tail -n+2 > ${sample}.single.fa;  echo ">${sample}" > header.tmp.txt;  grep -v ">" ${sample}.single.fa | tr '\n' ' ' | sed -e 's/ //g' > tmp; cat header.tmp.txt tmp > ${sample}.merged.fa;  done
