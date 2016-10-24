#连接数据库
library(RODBC)
channel<-odbcConnect("mysql_data", uid="ypp", pwd="ypp4150396")
sqlTables(channel)  #查看据中的表
#data<-sqlFetch(channel,"p")
hotwords<-sqlQuery(channel,"select hot_words from hot_words")
phone_words<-sqlQuery(channel,"select attr_words from phone_words
                      union all select all_brand from phone_words
                      union all select e_shop from phone_words
                      union all select e_words from phone_words
                      union all select attr_words from all_tabs
                      union all select adj from all_tabs")
phone_words<-phone_words[phone_words!=""]
hotwords<-hotwords[hotwords!=""]
stop_words<-sqlQuery(channel,"select stop_words from stop_words")
data<-sqlQuery(channel,"select summary from jd_iphone_2500 where p_brand='苹果'")


#中文分词
require(RColorBrewer) #R客都懂的颜色程序包
require(Rwordseg)#分词包
require(rJava)
insertWords(phone_words)
hotwords<-hotwords[hotwords!=""]
insertWords(hotwords)
n<-length(data)
data<-data[data!=" "]
data.rwordseg<-segmentCN(data,nature=TRUE)
#data1<-unlist(data,"")#把列表转化为向量
#words = unlist(lapply(X=data,FUN = segmentCN)) #分词，并调整表结构，将有相同词频的词归类
#word = lapply(X=words,FUN = strsplit," ")       #给每个词根据顺序赋个顺序指
# v = table(unlist(word))               #重建表
# v = sort(v)           #降序排列
# v[1:100]
# head(v)                                           #给每列字段赋标题
# d = data.frame(word = names(v),freq = v)         #更改标题
# #write.csv(d,"E:\\学习.csv",header = T)          #导出数据，为下一步做准备
#

#在分词结果中提取名词词条
n<-length(data)
data.n<-data.rwordseg
data1.n<-data.rwordseg
data2.n<-data.rwordseg
 for(i in 1:n)
{data1.n[[i]]<-data.rwordseg[[i]][which(names(data.rwordseg[[i]])=="userDefine" )]} 
# # #userDefine
for(i in 1:n)
{data.n[[i]]<-data.rwordseg[[i]][which(names(data.rwordseg[[i]])=="n")]}
data.n<-c(data1.n,data2.n)
data.n<-data.n[data.n!=" "]

#建立语料库和文档
require(tm)
require(NLP)
datahouse<-Corpus(VectorSource(data.n))#语料库的转化
#删除词条  #查看词条inspect(datahouse[1])
chinese<-stop_words
#chinese<-as.vector(chinese)
datahouse<-tm_map(datahouse,FUN=removeWords,c("了","的","时候"))
datahouse<-tm_map(datahouse,FUN=removeWords,c("\n"))
datahouse<-tm_map(datahouse,FUN=removeWords,c(chinese))

#删除 多余空白
datahouse<-tm_map(datahouse,FUN=stripWhitespace)
#删除 数字
#datahouse<-tm_map(datahouse,FUN=removeNumbers)
#删除标点符号
#datahouse<-tm_map(datahouse,FUN=removePunctuation)
#删除空文件
datahouse<-tm_map(datahouse,FUN=PlainTextDocument)
# #导入中文停用词表
# ###再次分词
# datahouse1<-datahouse
# datahouse1<-as.data.frame(datahouse1)
# datahouse<-t(datahouse1)
# datahouse<-as.data.frame(datahouse)
# #datahouse<-datahouse[datahouse!=" "]
# datahouse.rwordseg<-segmentCN(as.matrix(datahouse))
# datahouse<-Corpus(VectorSource(datahouse.rwordseg))

#删除 多余空白
#删除 数字
#datahouse<-tm_map(datahouse,FUN=removeNumbers)
#删除标点符号
#datahouse<-tm_map(datahouse,FUN=removePunctuation)
#删除空文件
datahouse<-tm_map(datahouse,FUN=PlainTextDocument)

#删除停用词
#datahouse<-tm_map(datahouse,FUN=removeWords,stopwords("chinese"))
# PCorpus(DirSource(Vector),
#         dbControl = list(dbName = "ypp", dbType = "DB1"))
#文档过滤  需要继续参考tm包资料
#datahouse.serch<-tm_filter(datahouse,FUN=searchFullText,c("手机","电池"))
#建立词条文档关系矩阵
dtm<-DocumentTermMatrix(datahouse)
#dtm<-DocumentTermMatrix(datahouse,control=list(dictionary=chinesewords,
#removePunctuation=TRUE,stopwords=TRUE,wordLengths=c(1,Inf)))
#处理a稀疏词汇 需要重复测试
#dtm=removeSparseTerms(dtm,sparse=0.9)
#读取词条文档
#col.num<-which(colnames(dtm)=="手机");col.num
#inspect(dtm[92,col.num])
#统计包含词条的文档数
datahouse.matrix<-as.matrix(dtm)#把关系矩阵转化为普通矩阵
datahouse.freq<-apply(datahouse.matrix,2,sum)#使用aplly函数计算每个词条所在的文档数
names(datahouse.freq)<-colnames(datahouse.matrix)#找到频数最高的30个词条
data<-(sort(datahouse.freq))[1:100]
#画图
#plot(datahouse.freq,main="苹果关键名词top50 v1",ylab="词频",ylim=c(0,10));text(c(1:length(datahouse.freq)),datahouse.freq,names(datahouse.freq))

#3.词云展示
# dd<-tail(d,150)
# op<-par(bg="lightyellow")
# #grayLevels<-gray((dd$freq)/(max(dd$freq)+140))
# #wordcloud(dd$word,dd$freq,colors=grayLevels)
# rainbowLevels<-rainbow((dd$freq)/(max(dd$freq)-10))
# wordcloud(dd$word,dd$freq,col=rainbow(length(d$freq)))
# par(op)
#加载wordcloud包
require(wordcloud) 
#指定字体颜色范围或者使用R颜色程序包中现成的主题模板colors=brewer.pal(8,"Dark2")
#colors=c('red','blue','green','yellow','purple')
#rc=brewer.pal(9,"Set1") #使用Set1主题模板
#rc=brewer.pal(8,"Dark2")
rc=brewer.pal(9,"Pastel1")[2:7]
#读取数据
data<-datahouse.freq
#显示图形

#  for(i in 1:length(data))
#  {
#   if (nchar(names(data[i]))<=1)
#     data[i]<-0
# #  }
# for(i in 1:length(data))
# {
#   b<-grep("\n",names(data[i]))
#   a<-is.character(b)
#   if(a!="integer(0)")
#   {data[i]<-0}
#   else 
#   {break}
# }
wordcloud(names(data),data,scale=c(2.2,0.4),min.freq=3,max.words=100,font=2,colors=rc,random.order=F,random.color=F,ordered.colors=F)

#wordcloud(names(data),data,scale=c(5,0.3),colors=colors,random.order=F,random.color=F,ordered.colors=F)
#sort(data,decreasing=TRUE)[1:50]
