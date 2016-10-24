library(RODBC)
channel<-odbcConnect("mysql_data", uid="ypp", pwd="ypp4150396")
sqlTables(channel)  #查看据中的表
data<-sqlFetch(channel,"user_summary")
# sqlQuery(channel,"select name,age,address,score from students where id < 105 order by id desc")
sqlSave(channel, USArrests, rownames = "state", addPK = TRUE)
# sqlDrop(channel,"usarrests") 删除 某表
#  odbcClose(channel)  关闭数据库资源
##输出正负评论标记

pos2= lapply(X=data1.n,FUN = strsplit," ")
neg2= lapply(X=data2.n,FUN = strsplit," ")
pos2<-as.matrix(pos2)[,1]
neg2<-as.matrix(neg2)[,1]


sqlSave(channel,as.data.frame(pos2), rownames = "pos2", addPK = TRUE)
