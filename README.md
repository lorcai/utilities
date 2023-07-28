# utilities

Barebones repository for helper functions, fixes, etc...

# setReadable_GENENAME.R
While carring out functional analysis of a S. cerevisiae RNA-seq, saw that the annotationDBi package does not have a "SYMBOL" column, which is hardcoded in the setReadable() function of DOSE, exported to ClusterProfiller. Instead, it has a "GENENAME" column, hardcoded here in its place. Just a quickfix. There are a lot of problems with S. cerevisiae annotation. In the current ENSEMBL GTF some of the "gene_ID" fields are SGD (Saccharomyces Genome Database) Systematic identifiers/ENSEMBL ID and a few snoRNA are GENENAMES, which get lost in translation if you are not careful and translate only from ENSEMBLID -> ENTREZID (ENTREZID is the one that seems to be more complete and compatible with most DBs).
