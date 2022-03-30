import pandas as pd

inData=pd.read_csv("filename.txt") 
inData["Query Title"]=inData["qtitle"]

def extractProdigalMetadata(df):
    df['Contig/ORF Name'] = df["Query Title"].str.split(' ').str[0]
    df['ORF_Start_Stop_Strands'] = df['Query Title'].str.extract(r'\#.*?(.*?)# ID=')
    df['ORF_Start'] = df['ORF_Start_Stop_Strands'].str.split(' # ').str[0].astype(int)
    df['ORF_End'] = df['ORF_Start_Stop_Strands'].str.split(' # ').str[1].astype(int)
    df['Sense or Antisense Strand'] = df['ORF_Start_Stop_Strands'].str.split(' # ').str[2]
    df['Prodigal ID'] = df['Query Title'].str.extract(r'\#.*?ID=(.*?);')   
    df['Prodigal Designated Contigs'] = df['Prodigal ID'].str.split('_').str[0]
    df['Unique_ORF'] = df['Prodigal ID'].str.split('_').str[1]
    df['Partial Tag'] = df['Query Title'].str.extract(r'\;partial=(.*?);')
    df['Start Codon'] = df['Query Title'].str.extract(r'\;start_type=(.*?);')
    df['RBS Motif'] = df['Query Title'].str.extract(r'\;rbs_motif=(.*?);')
    df['RBS Spacer'] = df['Query Title'].str.extract(r'\;rbs_spacer=(.*?);')
    df['GC Content'] = df['Query Title'].str.extract(r'\;gc_cont=(.*?)$')
    df['Specific Contig'] = df['Contig/ORF Name'].apply(lambda r: '_'.join(r.split('_')[:-1]))
    return(df)
