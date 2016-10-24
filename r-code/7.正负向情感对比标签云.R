######删除空值并转化矩阵
n<-length(data1.n)
words1<-data1.n
#word1<-as.matrix(word1s)
for(i in 1:n)
{if(length(words1[[i]])==0)
           words1[[i]]<-NA
}
words1<-words1[!is.na(words1)]
word1<-as.matrix(words1)


words2<-data2.n
n<-length(data2.n)
for(i in 1:n)
{if(length(words2[[i]])==0)
  words2[[i]]<-NA
}
words2<-words2[!is.na(words2)]
word2<-as.matrix(words2)

#####建立分组标记祖镇
n<-length(word1)
m<-length(word2)
w1<-c(rep(1,n))
w2<-c(rep(2,m))
mt1<-matrix(w1)
mt2<-matrix(w2)

word11<-cbind(mt1,word1)
word22<-cbind(mt2,word2)
word33<-rbind(word11,word22)

word44<-word33[,2]
require(wordcloud)
require(tm)
dat<-Corpus(VectorSource(word44))#语料库的转化
sample.tdm <- TermDocumentMatrix(dat)
tdm_matrix <- as.matrix(sample.tdm)
comparison.cloud(tdm_matrix,max.words=300,random.order=FALSE)
title(main = "sample comparision")

#############
n<-length(word33)
zz1 = 1:n
unique_type<-word33[,1]
cluster_matrix<-sapply(unique_type,function(type){apply(tdm_matrix[,zz1[word33[,1]==type]],1,sum)})
#png(paste(“sample_ cluster_comparison”,”.png”, sep = “”), width = 800, height = 800 )
comparison.cloud(cluster_matrix)
title(main = "sample cluster comparision")





# word2<-lapply(X=words2,FUN = strsplit," ") 
# words
#word2<-as.matrix(words2)

# word2<-as.data.frame (word2)
#  sqlSave(channel,word2,addPK = TRUE)
# 
# word2= lapply(X=words2,FUN = strsplit," ") 
# word12<-c(word1,word2)
# # words1[complete.cases(words1)]
# word1 = lapply(X=words1,FUN = strsplit," ") 
# word1[complete.cases(word1)]
# words1<-as.matrix(words1)
# words1[complete.cases(words1)] 
# 
# 
# for(i in 1:n)
#    {   
#      if(length(words1[[i]])==0)
#       words1[i]<-NA  
#      
# }
# for(i in 1:n)
# {   
#   if(length(words1[[i]])==0)
#    { 
#     words1<-words1[-i,1];
#     i<-i-1
#   }
# }


# words1[complete.cases(words1)]
# na.omit(words1)
# # j<-1
# for(i in 1:n)
# {   
#     
#     words1[[j]]<-data1.n[which(length(data1.n[[i]])!=0)]
#     j<-j+1
# }

