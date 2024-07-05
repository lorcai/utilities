# utilities

Barebones repository for helper functions, fixes, etc...

### setReadable_GENENAME.R
The annotationDBi R package for S. cerevisiae does not have a "SYMBOL" column (at least when I wrote this, and the one installed through conda). The setReadable() function of DOSE which is used to turn entrezids to gene names has SYMBOL hardcoded as the column that has to be looked up in the annotationDBi objec. This function is exported to ClusterProfiller which is used for functional analysis. 

This is a quickfix that changes "SYMBOL" for a "GENENAME" column. Still hardcoded so its just a quickfix.

Also, in the current ENSEMBL GTF some of the "gene_ID" fields are SGD (Saccharomyces Genome Database) Systematic identifiers/ENSEMBL ID and a few snoRNA are GENENAMES, which get lost in translation if you are not careful and translate only from ENSEMBLID -> ENTREZID (ENTREZID is the one that seems to be more complete and compatible with most DBs).

### get_KEGG_pathway_gene_names.R
Get the gene names from a KEGG pathway, useful to get a list of genes from which you can filter and expression dataframe to make a heatmap of the pathway.

### get_KEGG_pathway_gene_names_table.R
Same thing but instead it outputs a table with the entrez_gene_id, gene_name and gene_description

### human_to_mouse_symbol_table.R

Get a table of human to mouse symbols.
