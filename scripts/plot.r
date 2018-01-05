
library(ggplot2)
library(ade4)
data(aminoacyl)
codons = read.table("final_codon.data", sep="\t", header=T)
d = codons
d$gene = NULL
d$X = NULL


ggdata = data.frame(count=apply(d,2,sum))
aanames = sapply(rownames(ggdata), function(x) {aminoacyl$AA[which(aminoacyl$codon == x)]})

ggdata$aa = as.factor(aanames)
ggdata$codon = as.factor(rownames(ggdata))

ggdata$codon2 = NULL

g = ggplot(ggdata, aes(x = codon, y = count, fill=aa))
g + geom_histogram(stat="identity")+theme(axis.text = element_text(angle=90))

rownames(d) = codons$gene

g.dist = dist(d)




