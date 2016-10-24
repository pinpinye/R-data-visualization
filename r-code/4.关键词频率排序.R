n<-length(data)
data.n<-data.rwordseg
data1.n<-data.rwordseg
data2.n<-data.rwordseg
data3.n<-data.rwordseg
for(i in 1:n)
{data1.n[[i]]<-data.rwordseg[[i]][which(names(data.rwordseg[[i]])=="userDefine" )]} 
# #userDefine
for(i in 1:n)
{data2.n[[i]]<-data.rwordseg[[i]][which(names(data.rwordseg[[i]])=="n")]}

data.n<-c(data1.n,data2.n)
words<-data1.n[data1.n!=" "]
word = lapply(X=words,FUN = strsplit," ")       #给每个词根据顺序赋个顺序指
v = table(unlist(word))               #重建表
v = sort(v,decreasing = T)[2:110]#,decreasing = T)  
#降序排列      
#给每列字段赋标题
v<-sort(v)
dd<-data.frame(word = names(v),freq = v) 
require(wordcloud) 
#指定字体颜色范围或者使用R颜色程序包中现成的主题模板colors=brewer.pal(8,"Dark2")
# rc=c('orange',‘’,'purple','green','yellow','gray')
# rc=brewer.pal(9,"Set2") #使用Set1主题模板
# rc=brewer.pal(8,"Paired")
#rc=brewer.pal(9,"Greys")[5:9]
#rc=brewer.pal(9,"Accent") [1:4]#使用Set1主题模板
# rc=heat.colors(10)[4:5]
rc<-rgb(red=255,green=153,blue=102,max=255)
wordcloud(dd$word,dd$freq,scale=c(4,0.8),min.freq=3,max.words=110,font=2,colors=rc,random.order=F,random.color=F,ordered.colors=F)
#sqlSave(channel, dd, rownames = "words", addPK = TRUE,fast = TRUE)
# barplot(t(as.matrix(d$freq)),axes=F,beside=F,border = NA,horiz=T)
# 
# title(main="iphone6购买人群分布")
# text(y=seq(from=0.1,length.out=18.6,by=0.1),x=-10,labels=phonemap2$address)