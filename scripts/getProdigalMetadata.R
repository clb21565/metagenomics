# readSummaries -> load in dataframe to R; code filename as "sample"; parse prodigal header; also includes code for extracting info from uniref headers. 
readSummaries=function(path){
    setwd(path)
    
    ls=list.files(path = path,pattern = ".tsv")

    innerfx=function(dfname){
    df=fread(dfname,sep="\t",header=FALSE)
    df$Sample_Name=as.character(dfname)
    cns=c("qtitle", "stitle", "pident", "bitscore", "evalue","filename")
    colnames(df)=cns
    df=separate(df,qtitle,into=c("orf_info","partial","start_type","rbs","rbsspacer","gc_content"),sep="\\;")
    df=separate(df,orf_info,into=c("orf","start","stop","strand","ID"),sep="\\#")
    df$start=as.numeric(df$start)
    df$stop=as.numeric(df$stop)
    df$ctg=gsub("_[^_]+$","",df$orf)
    
    #for usage when searching against uniref50 only
    #descript=str_extract(df$stitle," (.*?) n=")
    #accid=str_extract(df$stitle, "UniRef50_(.*?) ")
    #descript=gsub(" n=","",descript)
    #accid=gsub("UniRef50_","",accid)
    #accid=gsub(" ","",accid)     
    
    #df$Name=paste(accid,descript,sep="|")
    
    return(df)}
    
    odf=ldply(lapply(ls,innerfx))
    
    return(odf)}

#out=readSummaries("/Users/conno/Downloads/out/") # example call
  
  
  
