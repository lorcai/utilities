# GPT4o made this! 

# Install KEGGREST if not already installed
if (!requireNamespace("KEGGREST", quietly = TRUE)) {
    install.packages("BiocManager")
    BiocManager::install("KEGGREST")
}

# Load the KEGGREST package
library(KEGGREST)

# Get the pathway information for mmu00190 (oxidative phosphorylation in mouse)
keggEntry <- "mmu00190"
pathway <- keggGet(keggEntry)

# Extract the list of genes from the pathway information
genes <- pathway[[1]]$GENE

# Initialize empty vectors to store Entrez Gene IDs, gene names, and descriptions
entrez_ids <- c()
gene_names <- c()
descriptions <- c()

# Loop through the genes to extract information from the even-numbered lines
for (i in seq(1, length(genes), by = 2)) {
    entrez_id <- genes[i]
    gene_description <- genes[i + 1]
    gene_info <- unlist(strsplit(gene_description, "; "))
    gene_name <- gene_info[1]
    description <- gene_info[2]
    
    entrez_ids <- c(entrez_ids, entrez_id)
    gene_names <- c(gene_names, gene_name)
    descriptions <- c(descriptions, description)
}

# Create a data frame with the collected information
gene_table <- data.frame(
    EntrezGeneID = entrez_ids,
    GeneName = gene_names,
    Description = descriptions,
    stringsAsFactors = FALSE
)

# Print the resulting data frame
write.table(gene_table, file=paste(keggEntry, "_gene_table", ".tsv", sep=""), row.names=FALSE, quote=FALSE, sep="\t")
