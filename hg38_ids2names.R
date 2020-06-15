# This script takes as input a file containing gene ID's (and possibly other entries) for hg38 Ensembl.
# It then extracts corresponding gene names and saves the file with gene ID's and gene names. 
library(biomaRt)
df <- read.csv("motif_genes.txt", stringsAsFactors = FALSE, header = FALSE) # Replace with file containing gene ID's
ids <- df[,1] # Assuming gene ID's contained in first column.
mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl")) # Using Ensembl hg38
genes <- getBM(filters= "ensembl_gene_id", attributes=c("ensembl_gene_id", "external_gene_name"),values=ids, mart=mart)
write.table(genes, "motif_gene_names.tsv", col.names=TRUE, row.names=FALSE, quote=FALSE, sep = "\t")


