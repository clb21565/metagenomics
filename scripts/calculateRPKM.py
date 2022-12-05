import re
import argparse

parser=argparse.ArgumentParser(description='small script for calculating rpkm from samtools coverage files')

parser.add_argument("--covFile",type=str,required=True,help="samtools coverage output")
parser.add_argument("--ReadsInSample",type=int,required=True,help="number of reads in sample of origin")
parser.add_argument("--out_prefix", type=str, required=True,help="output file prefix")

args=parser.parse_args()
import pandas as pd
from itertools import combinations
import numpy as np
import os

data=pd.read_csv(args.covFile,sep="\t")

reads=data["numreads"]
kb=data["endpos"]/1000
pm=(args.ReadsInSample / 1e6)
rpkm = (reads/kb)/pm 

out=pd.concat([data["#rname"], reads, rpkm],axis=1)
out["length"]=kb
out["sample_reads"]=args.ReadsInSample
out.columns=["contig","reads","rpkm","length","sample_reads"]
out.to_csv("{}.output.tsv".format(args.out_prefix),sep="\t",index=False)
