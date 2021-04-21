# download files


# after processing with quanTIseq full pipeline, we will work with the TPM object

# this is the tabular format as plain text file, compressed
tpmdata <- read.table("tpm_GSE75299.txt.gz", header = TRUE)

dim(tpmdata)
colnames(tpmdata)

# extracting the gene symbols from the first column
tpm_genesymbols <- tpmdata$GENE
tpmdata <- as.matrix(tpmdata[, -1])
rownames(tpmdata) <- tpm_genesymbols

# constructing the SummarizedExperiment object
library(SummarizedExperiment)

# preparing something more on the colData to have the information available directly
coldata_Song2017 <- DataFrame(
  srr_id = colnames(tpmdata)
)

# coldata_Song2017$group ...

Song2017_MAPKi_treatment <- SummarizedExperiment(
  assays = SimpleList(
    abundance = tpmdata
  ),
  colData = coldata_Song2017
)

save(Song2017_MAPKi_treatment, file = "Song2017_MAPKi_treatment.Rda")
