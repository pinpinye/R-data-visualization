library(RODBC)
channel<-odbcConnect("mysql_data", uid="ypp", pwd="ypp4150396")
sqlTables(channel)  #查看据中的表
#data<-sqlFetch(channel,"p")
type1<-sqlQuery(channel,"select flag1 from  type_flag")
type2<-sqlQuery(channel,"select flag2 from  type_flag")
type3<-sqlQuery(channel,"select flag3 from  type_flag")
type4<-sqlQuery(channel,"select flag4 from  type_flag")
type5<-sqlQuery(channel,"select flag5 from  type_flag")
type6<-sqlQuery(channel,"select flag6 from  type_flag")
type7<-sqlQuery(channel,"select flag7 from  type_flag")
type8<-sqlQuery(channel,"select flag8 from  type_flag")
type9<-sqlQuery(channel,"select flag9 from  type_flag")
type10<-sqlQuery(channel,"select flag10 from  type_flag")
type11<-sqlQuery(channel,"select flag11 from  type_flag")
type12<-sqlQuery(channel,"select flag12 from  type_flag")
type13<-sqlQuery(channel,"select flag13 from  type_flag")
type14<-sqlQuery(channel,"select flag14 from  type_flag")
type15<-sqlQuery(channel,"select flag15 from  type_flag")
type16<-sqlQuery(channel,"select flag16 from  type_flag")

###########各个属性的正负评论数
n<-length(type1)
type1<-as.matrix(type1)
t1<-1#评论数
p1<-1#正向评论数
n1<-1#负向评论数
type2<-as.matrix(type2)
t2<-2#评论数
p2<-2#正向评论数
n2<-2#负向评论数
type3<-as.matrix(type3)
t3<-3#评论数
p3<-3#正向评论数
n3<-3#负向评论数
type4<-as.matrix(type4)
t4<-4#评论数
p4<-4#正向评论数
n4<-4#负向评论数
type5<-as.matrix(type5)
t5<-5#评论数
p5<-5#正向评论数
n5<-5#负向评论数
type6<-as.matrix(type6)
t6<-6#评论数
p6<-6#正向评论数
n6<-6#负向评论数
type7<-as.matrix(type7)
t7<-7#评论数
p7<-7#正向评论数
n7<-7#负向评论数
type8<-as.matrix(type8)
t8<-8#评论数
p8<-8#正向评论数
n8<-8#负向评论数
type9<-as.matrix(type9)
t9<-9#评论数
p9<-9#正向评论数
n9<-9#负向评论数
type10<-as.matrix(type10)
t10<-10#评论数
p10<-10#正向评论数
n10<-10#负向评论数
type11<-as.matrix(type11)
t11<-11#评论数
p11<-11#正向评论数
n11<-11#负向评论数

type12<-as.matrix(type12)
t12<-12#评论数
p12<-12#正向评论数
n12<-12#负向评论数

type13<-as.matrix(type13)
t13<-13#评论数
p13<-13#正向评论数
n13<-13#负向评论数

type14<-as.matrix(type14)
t14<-14#评论数
p14<-14#正向评论数
n14<-14#负向评论数

type14<-as.matrix(type14)
t14<-14#评论数
p14<-14#正向评论数
n14<-14#负向评论数

type15<-as.matrix(type15)
t15<-15#评论数
p15<-15#正向评论数
n15<-15#负向评论数


type16<-as.matrix(type16)
t16<-16#评论数
p16<-16#正向评论数
n16<-16#负向评论数

####type1 的统计
for (i in 1:n)
{
  if (type1[[i]]!=0)
    t1<-t1+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type1[[i]]!=0)
      p1<-p1+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type1[[i]]!=0)
  n1<-n1+1
}



####type2 的统计
for (i in 1:n)
{
  if (type2[[i]]!=0)
    t2<-t2+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type2[[i]]!=0)
    p2<-p2+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type2[[i]]!=0)
    n2<-n2+1
}


####type3 的统计
for (i in 1:n)
{
  if (type3[[i]]!=0)
    t3<-t3+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type3[[i]]!=0)
    p3<-p3+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type3[[i]]!=0)
    n3<-n3+1
}


####type4 的统计
for (i in 1:n)
{
  if (type4[[i]]!=0)
    t4<-t4+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type4[[i]]!=0)
    p4<-p4+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type4[[i]]!=0)
    n4<-n4+1
}

####type5 的统计
for (i in 1:n)
{
  if (type5[[i]]!=0)
    t5<-t5+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type5[[i]]!=0)
    p5<-p5+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type5[[i]]!=0)
    n5<-n5+1
}


####type6 的统计
for (i in 1:n)
{
  if (type6[[i]]!=0)
    t6<-t6+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type6[[i]]!=0)
    p6<-p6+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type6[[i]]!=0)
    n6<-n6+1
}



####type7 的统计
for (i in 1:n)
{
  if (type7[[i]]!=0)
    t7<-t7+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type7[[i]]!=0)
    p7<-p7+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type7[[i]]!=0)
    n7<-n7+1
}


####type8 的统计
for (i in 1:n)
{
  if (type8[[i]]!=0)
    t8<-t8+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type8[[i]]!=0)
    p8<-p8+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type8[[i]]!=0)
    n8<-n8+1
}


####type9 的统计
for (i in 1:n)
{
  if (type9[[i]]!=0)
    t9<-t9+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type9[[i]]!=0)
    p9<-p9+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type9[[i]]!=0)
    n9<-n9+1
}


####type10 的统计
for (i in 1:n)
{
  if (type10[[i]]!=0)
    t10<-t10+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type10[[i]]!=0)
    p10<-p10+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type10[[i]]!=0)
    n10<-n10+1
}



####type11 的统计
for (i in 1:n)
{
  if (type11[[i]]!=0)
    t11<-t11+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type11[[i]]!=0)
    p11<-p11+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type11[[i]]!=0)
    n11<-n11+1
}


####type12 的统计
for (i in 1:n)
{
  if (type12[[i]]!=0)
    t12<-t12+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type12[[i]]!=0)
    p12<-p12+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type12[[i]]!=0)
    n12<-n12+1
}



####type13 的统计
for (i in 1:n)
{
  if (type13[[i]]!=0)
    t13<-t13+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type13[[i]]!=0)
    p13<-p13+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type13[[i]]!=0)
    n13<-n13+1
}



####type14 的统计
for (i in 1:n)
{
  if (type14[[i]]!=0)
    t14<-t14+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type14[[i]]!=0)
    p14<-p14+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type14[[i]]!=0)
    n14<-n14+1
}




####type15 的统计
for (i in 1:n)
{
  if (type15[[i]]!=0)
    t15<-t15+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type15[[i]]!=0)
    p15<-p15+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type15[[i]]!=0)
    n15<-n15+1
}

for (i in 1:n)
{
  if (type16[[i]]!=0)
    t16<-t16+1
}

for (i in 1:n)
{
  if (length(data1.n[[i]])!=0 && type16[[i]]!=0)
    p16<-p16+1
}

for (i in 1:n)
{
  if (length(data2.n[[i]])!=0 && type16[[i]]!=0)
    n16<-n16+1
}



########f赋值
pp<-c(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16)
tt<-c(t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15,t16)
nn<-c(n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15,n16)
labels<-c('物流',
'外观',
'价格',
'性能',
'质量',
'售后',
'屏幕',
'手感',
'包装',
'电池',
'信号',
'声音',
'分辨率',
'功能',
'相机',
'耐用')

