##########################################################################################
########### Generate exome coverage plot from bedtools coverage output ###################
##########################################################################################

##### install packages ####
# source("http://bioconductor.org/biocLite.R")
# biocLite(pkgs = c("DESeq2","data.table","pasilla","DESeq","limma","ReportingTools",
# "GenomicRanges"))
# install.packages(pkgs= c("rJava","ReporteRs","ReporteRsjars","ggplot2","rtable","xtable",
#                          "VennDiagram","taRifx","devtools","dplyr","dendextend"))
# devtools::install_github('tomwenseleers/export',local=F)

##### load libraries ####
source("http://faculty.ucr.edu/~tgirke/Documents/R_BioCond/My_R_Scripts/my.colorFct.R")
zzz<-c("pheatmap","grid","gplots","ggplot2","export","devtools","DESeq2","pasilla","Biobase",
       "EBSeq","dplyr","data.table", "genefilter","FactoMineR","VennDiagram","DOSE","ReactomePA",
       "org.Hs.eg.db","clusterProfiler","pathview","DiffBind","dendextend","limma","ReportingTools",
       "TxDb.Hsapiens.UCSC.hg19.knownGene","GO.db","ChIPseeker","GenomicRanges", "RColorBrewer")
lapply(zzz, require, character.only= T)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

##### create a character vector of the bedtools output files to read in ####
## get all matching the pattern
print(files <- list.files(pattern="all.txt$"))
## get specified

##### Create lists to hold coverage and cumulative coverage for each alignment,
# and read the data into these lists.
cov <- list()
cov_cumul <- list()
for (i in 1:length(files)) {
  cov[[i]] <- read.table(files[i])
  cov_cumul[[i]] <- 1-cumsum(cov[[i]][,5])
}

##### assign colors for graph ####
cols <- brewer.pal(length(cov), "Dark2")

##### Optional, create short sample names from the filenames.####
print(labs <- paste(gsub("\\.R1\\.bam\\.hist\\.all\\.txt", "", files, perl=TRUE), sep=""))


# Create plot area, but do not plot anything. Add gridlines and axis labels.
plot(cov[[1]][2:401, 2], cov_cumul[[1]][1:400], type='n', xlab="Depth", ylab="Fraction of capture target bases \u2265 depth", ylim=c(0,1.0), main="Target Region Coverage")
abline(v = 20, col = "gray60")
abline(v = 50, col = "gray60")
abline(v = 80, col = "gray60")
abline(v = 100, col = "gray60")
abline(h = 0.50, col = "gray60")
abline(h = 0.90, col = "gray60")
axis(1, at=c(20,50,80), labels=c(20,50,80))
axis(2, at=c(0.90), labels=c(0.90))
axis(2, at=c(0.50), labels=c(0.50))

# Actually plot the data for each of the alignments (stored in the lists).
for (i in 1:length(cov)) points(cov[[i]][2:401, 2], cov_cumul[[i]][1:400], type='l', lwd=3, col=cols[i])

# Add a legend using the nice sample labeles rather than the full filenames.
legend("topright", legend=labs, col=cols, lty=1, lwd=4)

## export the plot
graph2ppt(file="exome_coverage_plot.pptx", width=10, height=6, append=T)
dev.off()

