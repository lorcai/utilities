# Get the list of genes for a KEGG pathway

# Input (example: Oxidative phosphorylation - Mus musculus (house mouse))
keggEntry <- "mmu00190"

# Install KEGGREST if not already installed
if (!requireNamespace("KEGGREST", quietly = TRUE)) {
    install.packages("BiocManager")
    BiocManager::install("KEGGREST")
}

# Load the KEGGREST package
library(KEGGREST)

# Get the pathway information for mmu00190 (oxidative phosphorylation in mouse)
pathway <- keggGet(keggEntry)

# Extract the list of genes from the pathway information
genes <- pathway[[1]]$GENE

# Initialize an empty vector to store gene symbols
gene_list <- c()

# Loop through the genes to extract gene symbols from the even-numbered lines
# This is because, at least in this case, 1 line has the Entrez_gene_id, and the following line has the corresponding gene name

for (i in seq(2, length(genes), by = 2)) {
    gene_description <- genes[i]
    gene_symbol <- unlist(strsplit(gene_description, "; "))[1]
    gene_list <- c(gene_list, gene_symbol)
}

# For the example, you can check against https://www.genome.jp/entry/pathway+mmu00190
# At the KEGG GENES section it says (141) which is the lenght of gene_list.

length(gene_list)

# Print the list of genes
print(gene_list)

# Write the list
write(gene_list, file=paste(keggEntry, "_genes", ".txt", sep=""))

