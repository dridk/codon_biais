
library(ggplot2)
library(ade4)
library(dplyr)
data(aminoacyl)
codons = read.table("final.tsv", sep="\t", header=T)
orient = read.table("gene_orientation.tsv", sep="\t", header=F)

colnames(orient) = c("gene", "sens")

d = merge(x=codons, y = orient, by='gene')
d$X=NULL

t = subset(d, !duplicated(d$gene))




#heatmap 

heat = t 
heat$sens = NULL
heat$gene = NULL


heat = heat / rowSums(heat)

heat.m = as.matrix(heat)

heatmap(head(heat.m, 5000), labRow = F)

heat.stop = heat.m [,c('TAG','TAA','TGA')]

# pca 

# kmeans 
pca = prcomp(heat.m)

plot(pca$x[,1:2], col=t$sens)
biplot(pca)

# d = codons
# d$gene = NULL
# d$X = NULL
# 
# 
ggdata = data.frame(count=apply(heat.m,2,sum))
aanames = sapply(rownames(ggdata), function(x) {aminoacyl$AA[which(aminoacyl$codon == x)]})

ggdata$aa = as.factor(aanames)
ggdata$codon = as.factor(rownames(ggdata))

ggdata = arrange(ggdata,aa)

ggdata$codon2 = factor(ggdata$codon, levels = ggdata$codon)


g = ggplot(ggdata, aes(x = codon2, y = count, fill=aa))
g + geom_bar(stat="identity")+theme(axis.text = element_text(angle=90)) + scale_fill_manual( values=c(colors(distinct=T)))
