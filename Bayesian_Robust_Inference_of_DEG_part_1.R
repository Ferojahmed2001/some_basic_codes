
#BiocManager::install("bridge")
rm(list = ls())
# library(bridge)
setwd("E:\\Bio informatics\\BRIDGE\\GSE25724\\bridge") 
DataSet<- read.csv(file="mergefile_t2.csv",row.names = 1)
head(DataSet)
dim(DataSet)
class(DataSet)
Genes <- rownames(DataSet)
num_control <- DataSet %>%
  select(starts_with("con")) %>%
  names(.) %>%
  length(.)
  
num_case <- num_control <- DataSet %>%
  select(starts_with("ca")) %>%
  names(.) %>%
  length(.)
control_sample <- DataSet %>%
  select(starts_with("con")) %>% as.matrix(.)
case_sample <- DataSet %>%
  select(starts_with("ca")) %>% as.matrix(.)
  
bridge.GSE25724 <-bridge.2samples(control_sample,case_sample, B = 2000,
                                  min.iter = 10,batch=10, all.out=FALSE,
                                  affy=TRUE,verbose=FALSE,log=TRUE,robust=TRUE)
  

post_data <- as.matrix(bridge.GSE25724$post.p)
rownames(post_data) <- Genes
length(which(post_data > 0.9))
write.csv(post_data,file ="post_data.csv")

## Bayezid Vhai

head(post_data)
class(bridge.GSE25724)
n1 <- 7 ;n1 # Control(Non-Disease) Group
n2 <- 6 ;n2 # Case (Disease) group
sample1 <- as.matrix(DataSet[,2:8]) # Normal group
sample2 <- as.matrix(DataSet[,9:14]) # Disease group
rownames(sample1) <-Genes
rownames(sample2) <-Genes
colnames(sample1)
colnames(sample2)
head(sample1)
class(sample1)
bridge.GSE25724 <-bridge.2samples(sample1,sample2, B = 2000,
                                  min.iter = 10,batch=10, all.out=FALSE, affy=TRUE,
                                  verbose=FALSE,log=TRUE,robust=TRUE)



PostGSE25724 <-as.matrix(bridge.GSE25724$post.p)
head(PostGSE25724)
rownames(PostGSE25724) <- Genes
write.csv(post_data, file = "Post_datatt4.csv")
length(which(PostGSE25724>0.9))

