rm(list = ls())
setwd("E:\\Bio informatics\\BRIDGE\\GSE25724\\bridge") 
DataSet<- read.csv(file="mergefile_t2.csv", row.names = 1)
dim(DataSet)
class(DataSet)
Genes <- rownames(DataSet)


control_sample1 <- DataSet %>%
  select(starts_with("con")) %>% as.matrix(.)
case_sample1 <- DataSet %>%
  select(starts_with("ca")) %>% as.matrix(.)
sample1 <- as.matrix(DataSet[,2:8]) # Normal group
sample2 <- as.matrix(DataSet[,9:14]) # Disease group
rownames(sample1) <-Genes
rownames(sample2) <-Genes
colnames(sample1)
colnames(sample2)

#####################
Data <- cbind(control_sample1,case_sample1)
head(Data)
PP24 <- read.csv(file="post_data.csv", header = TRUE, sep=",")

# Row Median
install.packages("matrixStats")
library(matrixStats)
NormalMed <- rowMedians(control_sample1)
head(NormalMed)
TumorMed <- rowMedians(case_sample1)
head(TumorMed)
MedDiff <- TumorMed - NormalMed
head(MedDiff)


resultData <- cbind(PP24,MedDiff)
head(resultData)
colnames(resultData) <- c("Gene","PostPro","MedDiff")
head(resultData)
library(dplyr)
UpResult24 <- resultData %>% filter(PostPro>=0.9 & MedDiff > 0.5)
dim(UpResult24)
write.csv(UpResult24, file = "UpResult24.csv")
UpData24 <- Data[UpResult24$Gene,]
head(UpData24)
write.csv(UpData24,file = "UpData24.csv")


DownResult24 <- resultData %>% filter(PostPro>=0.9 & MedDiff < -0.5)
head(DownResult24)
write.csv(DownResult24, file = "DownResult24.csv")
DownData24 <- Data[DownResult24$Gene,]
head(DownData24 )
write.csv(DownData24,file = "DownData24.csv")

DEdata24 <- rbind(UpData24,DownData24)
dim(DEdata24)
write.csv(DEdata24,file = "DEdata24.csv")
length(k)
BiocManager::install("hgu133a.db")
library(hgu133a.db)
k
Genes<-select(hgu133a.db,keys = k,columns = "SYMBOL",
              keytype = "PROBEID")
DEG<- write.csv(Genes$SYMBOL,file="DEG_OFFICIAL.csv")
