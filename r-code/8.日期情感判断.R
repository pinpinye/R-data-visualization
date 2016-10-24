library(RODBC)
channel<-odbcConnect("mysql_data", uid="ypp", pwd="ypp4150396")
sqlTables(channel)  #查看据中的表
#data<-sqlFetch(channel,"p")
day<-sqlQuery(channel,"select 
DATEDIFF(com_date,buy_date) as use_daty from jd_iphone_2500
")


posflag<-data1.n
d1<-length(data1.n)
for (i in 1:d1)
  posflag[[i]]<-NA

for (i in 1:d1)
{
  if (length(data1.n[[i]])!=0)
    posflag[[i]]<-1
}


negflag<-data2.n
d2<-length(data2.n)
for (i in 1:d2)
  negflag[[i]]<-NA
for (i in 1:d2)
{
  if (length(data2.n[[i]])!=0)
    negflag[[i]]<-0
}



neg2<-negflag
pos2<-posflag
pos2<-as.matrix(pos2)
neg2<-as.matrix(neg2)
day<-as.matrix(day)

time<-cbind(day,pos2,neg2)
sqlSave(channel,as.data.frame(time), rownames = "time_emo", addPK = TRUE)



