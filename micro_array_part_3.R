library(limma)
library(gclus)
library(Biobase)


setwd("/home/kaderi/Feroj/T2DM_AND_OVARIAN/T2DM") 
data <- read.csv(file="T2DM_corrected_datasets_four_updated.csv", row.names = 1)
dim(data)
# data<-data[,order(colnames(data),decreasing = T)]

d <- dim(data);d

min <- apply(data,1,min)
head(min,10)

max <- apply(data,1,max)
head(max)
length(max)
diff <- max - min

norm_C= matrix(0,d[1], d[2])
dim(norm_C)
for (i in 1: length(max)){
  norm_C1 <- ((as.numeric(data[i,])-min[i])/diff[i])
  norm_C[i,] <- norm_C1
}

rownames(norm_C) <- rownames(data)
colnames(norm_C) <- colnames(data)

library(dplyr)
data1 <- as.data.frame(norm_C)
write.csv(data1,"T2dm_result_updates_DCALE_50_UPDATED.csv")
control <- data1 %>% 
  select(starts_with("Con"))
  

control

case <- data1 %>% 
  select(starts_with("Dis"))
  

data2 <- cbind(control,case)



names <- c(rep("Control",69), rep("Disease",49))

colnames(data2)<- names

group <- factor(colnames(data2))
design <-model.matrix(~group)
design

fit <- lmFit(data2, design)
fit2 <- eBayes(fit)
results <- topTable(fit2, coef=2, n = nrow(data2),
                    sort.by = "p")





write.csv(results,"T2dm_result_updates.csv")




up_Data <- results %>% filter(  adj.P.Val < 0.01 & logFC > 2)
write.csv(up_Data,"up_t2dm_LIMMA_Results_updated.csv")

down_Data <- results %>% filter(  adj.P.Val < 0.01 & logFC < -2 )
write.csv(down_Data,"down_t2dm_LIMMA_Results_updated.csv")

dim(down_Data)


DEG = rownames(rbind(up_Data,down_Data))



write.csv(rownames(up_Data),"up_regulated_genes(0.01 & greater than 2).csv")

write.csv(rownames(down_Data),"Downp_regulated_genes(0.01 & less than -2).csv")

write.csv(DEG,"DEGs(0.05 &logFC-2)_updated.csv")
