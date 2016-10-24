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
stop_words<-sqlQuery(channel,"select stop_words from stop_words")
summary<-sqlQuery(channel,"select summary from jd_iphone_2500 where p_brand='苹果'")
#neg_words<-sqlQuery(channel,"select adj from all_tabs where adj_if=-1")

require(RColorBrewer) #R客都懂的颜色程序包
require(Rwordseg)#分词包
require(rJava)
data<-sqlQuery(channel,"select summary from jd_iphone_2500 where p_brand='苹果'")
insertWords(phone_words)
hotwords<-hotwords[hotwords!=""]
insertWords(hotwords)
n<-length(data)
data<-data[data!=" "]
data.rwordseg<-segmentCN(data,nature=TRUE)
#在分词结果中提取名词词条
# n<-length(data)
data.n<-data.rwordseg
for(i in 1:n)
{data.n[[i]]<-data.rwordseg[[i]][which(names(data.rwordseg[[i]])=="a")]}
data.n<-data.n[data.n!=" "]
data.set<-data.n[[2482]]
data.n<-data.rwordseg
#正向评论数
data1.n<-data.n
#pos_words<-sqlQuery(channel,"select adj from all_tabs where adj_if=1")
pos_words<-sqlQuery(channel,"select adj as pos_words from all_tabs where adj_if=1
union all
select hot_words  as  pos_words from hot_words where senti_if=1
union all
select pos_words
from 
(
  SELECT hn_access_pos  as  pos_words from hn_access_pos a 
  left join 
  (select adj as pos from all_tabs 
   union all
   select hot_words  as pos from hot_words 
  )b on a.hn_access_pos=b.pos where  b.pos is  null
)c")


n<-length(data1.n)
for (x in 1:n)
{data1.n[[x]]<-data.set}
g<-as.matrix(pos_words)
m<-length(g)
# g<-c("不错","好")
# m<-length(g)
for(i in 1:n)
{
 for(k in 1:m)
   {
     if (length(data1.n[[i]])==0)
    {data1.n[[i]]<-data.n[[i]][which(data.n[[i]]==g[k])] }
    }
}

n<-length(data1.n)
j<-1 
for (i in 1:n)
{ if (length(data1.n[[i]])!=0)
j<-j+1
}
#负向评论数data1.n<-data.n
data2.n<-data.n
neg_words<-sqlQuery(channel,"
select adj as neg_words from all_tabs where adj_if=-1
union all
select hot_words  as  neg_words from hot_words where senti_if=-1
union all
select neg_words
from 
(SELECT hn_access_neg as  neg_words from hn_access_neg a 
left join 
(select adj as neg from all_tabs whree 
union all
select hot_words  as neg from hot_words 
)b on a.hn_access_neg=b.neg where  b.neg is null
)c")


n<-length(data2.n)
for (x in 1:n)
{data2.n[[x]]<-data.set}
f<-as.matrix(neg_words)
m<-length(f)
for(i in 1:n)
{
  for(y in 1:m)
  {
    if (length(data2.n[[i]])==0)
    {data2.n[[i]]<-data.n[[i]][which(data.n[[i]]==f[y])] }
  }
}

j1<-1 
for (i in 1:n)
{ if (length(data2.n[[i]])!=0)
  j1<-j1+1
}


#没有明显倾向的评论
data3.n<-data.n
n<-length(data3.n)
for (x in 1:n)
{data3.n[[x]]<-data.set}

for (i in 1:n)
{
if (length(data1.n[[i]])==0 && length(data2.n[[i]])==0)
data3.n[[i]]<-1
}


j2<-1 
for (i in 1:n)
{ if (length(data3.n[[i]])!=0)
  j2<-j2+1
}

####同时包含正负评论
data4.n<-data.n
n<-length(data4.n)
for (x in 1:n)
{data4.n[[x]]<-data.set}
for (i in 1:n)
{if (length(data1.n[[i]])!=0 && length(data2.n[[i]])!=0)
{data4.n[[i]]<-data.n[[i]]}
}
j3<-1 
for (i in 1:n)
{ if (length(data4.n[[i]])!=0)
  j3<-j3+1
}




#j 正向
#j1 负向
#j2 不含正负
#j3 同时包含正负

#####取出原始评论
#data1 原始含正向
n<-length(data)
data1<-data
for (x in 1:n)
{data1[[x]]<-NA}
for (i in 1:n)
{if (length(data1.n[[i]])!=0)
{data1[[i]]<-data[[i]]}
}

#data 2 原始含负向
n<-length(data)
data2<-data
for (x in 1:n)
{data2[[x]]<-NA}
for (i in 1:n)
{if (length(data2.n[[i]])!=0)
{data2[[i]]<-data[[i]]}
}
#data 3 原始不含正负向
n<-length(data)
data3<-data
for (x in 1:n)
{data3[[x]]<-NA}
for (i in 1:n)
{if (length(data3.n[[i]])!=0)
{data3[[i]]<-data[[i]]}
}
#data 4 原始含正负向
n<-length(data)
data4<-data
for (x in 1:n)
{data4[[x]]<-NA}
for (i in 1:n)
{if (length(data4.n[[i]])!=0)
{data4[[i]]<-data[[i]]}
}

n<-length(data)
enum<-c(round(j/n,2),round(j1/n,2),round(j2/n,2),round(j3/n,2))
#enum<-paste(100*enum,"%",seq="")
m1<-matrix(enum)
emo<-c("正向评论数","负向评论数","无情感","包含正负情感")
m2<-matrix(emo)
emo1<-cbind(m1,m2)

require(RColorBrewer) #R客都懂的颜色程序包
require(ggplot2)
  
  ggplot(emo1, aes(x=emo1[,2],y=emo1[,1])) 
  geom_bar(aes(y=..count.., fill=emo)) 
  scale_fill_brewer(palette="Dark2") 
  labs(x="emotion categories", y="number of tweets") 
#   opts(title = "Sentiment Analysis of Tweets about Obama\n(classification by emotion)",
#        plot.title = theme_text(size=12))


