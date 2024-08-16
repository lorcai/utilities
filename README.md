# utilities

Barebones repository for helper functions, fixes, etc...

- ### setReadable_GENENAME.R
The annotationDBi R package for S. cerevisiae does not have a "SYMBOL" column (at least when I wrote this, and the one installed through conda). The setReadable() function of DOSE which is used to turn entrezids to gene names has SYMBOL hardcoded as the column that has to be looked up in the annotationDBi objec. This function is exported to ClusterProfiller which is used for functional analysis. 

This is a quickfix that changes "SYMBOL" for a "GENENAME" column. Still hardcoded so its just a quickfix.

Also, in the current ENSEMBL GTF some of the "gene_ID" fields are SGD (Saccharomyces Genome Database) Systematic identifiers/ENSEMBL ID and a few snoRNA are GENENAMES, which get lost in translation if you are not careful and translate only from ENSEMBLID -> ENTREZID (ENTREZID is the one that seems to be more complete and compatible with most DBs).

- ### get_KEGG_pathway_gene_names_table.R

Get a table with the entrez_gene_id, gene_name and gene_description for the genes rom a KEGG pathway, useful to get a list of genes from which you can filter an expression dataframe to make a heatmap of the pathway.

Remember to change the keggEntry for the pathway you want. If there is a gene with no gene name, NA is inserted in the table.

- ### human_to_mouse_symbol_table.R

Get a table of human to mouse symbols. Based on the [HOM_MouseHumanSequence.rpt file from MGI database](http://www.informatics.jax.org/downloads/reports/HOM_MouseHumanSequence.rpt).

- ### jamenrich-enrichdf2er.R
From [R/jamenrich-enrichdf2er.R](https://github.com/jmw86069/multienrichjam/)

Found in: R/jamenrich-enrichdf2er.R, putting it here because I KEEP FORGETTING IT EXISTS.

Loads an enrichment results table (data.frame) into an enrichResult object. Most clusterProfiler plot functions work only with this object.
For when you get someone else's analysis and do not have access to the Rdata from the session. 

- ### fast_ollama_setup.md

A minimal tutorial to set up a local LLM interface. An encouragement for lazy friends to try it. 
