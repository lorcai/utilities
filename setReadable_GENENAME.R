## This is a quickfix for S. cerevisiae functional analysis 
##' mapping geneID to gene Symbol
##'
##'
##' @title setReadable
##' @param x enrichResult Object
##' @param OrgDb OrgDb
##' @param keyType keyType of gene
##' @return enrichResult Object
##' @author Yu Guangchuang
##' @export
setReadable <- function(x, OrgDb, keyType="auto") {
    #OrgDb <- load_OrgDb(OrgDb)
    if (!'GENENAME' %in% columns(OrgDb)) {
        warning("Fail to convert input geneID to GENENAME since no GENENAME information available in the provided OrgDb...")
    }

    if (!(is(x, "enrichResult") || is(x, "groupGOResult") || is(x, "gseaResult") || is(x,"compareClusterResult")))
        stop("input should be an 'enrichResult' , 'gseaResult' or 'compareClusterResult' object...")

    isGSEA <- FALSE
    isCompare <- FALSE
    if (is(x, 'gseaResult'))
        isGSEA <- TRUE

    if (is(x, 'compareClusterResult'))
        isCompare <- TRUE

    if (keyType == "auto") {
        keyType <- x@keytype
        if (keyType == 'UNKNOWN') {
            stop("can't determine keyType automatically; need to set 'keyType' explicitly...")
        }
    }

    if (x@readable)
        return(x)

    gc <- geneInCategory(x)
    if (isGSEA) {
        genes <- names(x@geneList)
    } else if (isCompare) {
        genes <- unique(unlist(x@geneClusters))
    } else {
        genes <- x@gene
    }

    #gn <- EXTID2NAME(OrgDb, genes, keyType)
    
    pre_gn <- select(org.Sc.sgd.db, genes, c("GENENAME"), keyType)
    gn <- pre_gn$GENENAME
    names(gn) <- pre_gn$ENTREZID

    if(isCompare) {
        gc2 <- list()
        k <- 1
        for(i in seq_len(length(gc))) {
            for(j in seq_len(length(gc[[i]]))) {
                gc2[[k]] <- gc[[i]][[j]]
                names(gc2)[k] <- paste(names(gc)[[i]], names(gc[[i]])[j], sep="-")
                k <- k + 1
            }
        }
        gc <- gc2
        gc <- lapply(gc, function(i) gn[i])
        res <- x@compareClusterResult
        gc <- gc[paste(res$Cluster, res$ID, sep= "-")]
    } else {
        gc <- lapply(gc, function(i) gn[i])
        res <- x@result
        gc <- gc[as.character(res$ID)]
    }

    ## names(gc) should be identical to res$ID

    ## gc <- gc[as.character(res$ID)]


    geneID <- sapply(gc, paste0, collapse="/")
    if (isGSEA) {
        res$core_enrichment <- unlist(geneID)
    } else {
        res$geneID <- unlist(geneID)
    }
    x@gene2Symbol <- gn
    x@keytype <- keyType
    x@readable <- TRUE
    if(isCompare){
        x@compareClusterResult <- res
    } else {
        x@result <- res
    }


    return(x)
}
