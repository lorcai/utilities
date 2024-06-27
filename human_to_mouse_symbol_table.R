# Convert Human to mouse symbols
# Shamelessly stolen from https://www.biostars.org/p/9567892/

mouse_human_genes <- read.csv("http://www.informatics.jax.org/downloads/reports/HOM_MouseHumanSequence.rpt",sep="\t")

# separate human and mouse 
mouse <- split.data.frame(mouse_human_genes,mouse_human_genes$Common.Organism.Name)[[2]]
human <- split.data.frame(mouse_human_genes,mouse_human_genes$Common.Organism.Name)[[1]]

# remove some columns
mouse <- mouse[,c(1,4)]
human <- human[,c(1,4)]

# merge the 2 dataset  (note that the human list is longer than the mouse one)
mh_data <- merge.data.frame(mouse,human,by = "DB.Class.Key",all.y = TRUE) 

write.table(mh_data, paste("human2mouse", "tsv", sep="."), quote=FALSE, row.names=FALSE)
