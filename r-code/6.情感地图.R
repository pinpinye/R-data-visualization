library(RODBC)
channel<-odbcConnect("mysql_data", uid="ypp", pwd="ypp4150396")

phonemap2<-sqlQuery(channel,"select address,count(p_brand) as num from jd_iphone_2500 
                    where p_brand='苹果' group by address")

phonemap3<-sqlQuery(channel,"select lon,lat,address,num from (select address,count(p_brand) as num from jd_iphone_2500 
                    where p_brand='苹果' group by address)a
                    left join citylonlat b on a.address=b.city")
city<-sqlQuery(channel,"select b.lon,b.lat,a.address,num 
 from  city_mode_1 a   
left join citylonlat b on a.address=b.city
where lon is not null
group by 1,2,3 
order by 4 desc")
# city<-as.matrix(city)

# 
# cdata1<-as.matrix(data1.n)
# cdata2<-as.matrix(data2.n)
# cdata<-cbind(city,cdata1,cdata2)
# cdata<-as.data.frame(cdata)
#sqlSave(channel, cdata, rownames = "state", addPK = TRUE)
city1<-sqlQuery(channel,"select address  from city_mode_1 where pos is not null")
# cnum<-sqlQuery(channel,"select num  from city_mode_1")
cpn<-sqlQuery(channel,"select 
case when pos is null  then 0 else pos/num end as p,
case when neg is null  then 0 else neg/num end as n
 from city_mode_1 where pos is not null")
# cneg<-sqlQuery(channel,"select neg/num  from city_mode_1")
# cpos<-as.matrix(cpos)
# cneg<-as.matrix(cneg)
# require(RColorBrewer)
posdata<-data.frame(city1,cpn[1]*100)
negdata<-data.frame(city1,cpn[2]*100)

# cpn<-as.matrix(cpn)
#cc<-cbind(cpos[1:30],cneg[1:30])
# city<-as.matrix(city)[1:30]
# clabel<-c('积极评论','消极评论')
# col<-brewer.pal(8,"Set2")[1:2]
# c1<-c(cpn[1],cpn[31])
# p<-pie(c1,col=col,labels=NA,xaxt="n",border = NA,radius=0.2)
#画中国地图
require (maps)
require(mapdata) 
require(maptools)
require(RColorBrewer)
require(ggplot2)
require(ggmap)
#中国地图
# chinamap<-map("china", col = brewer.pal(9,"Blues")[7:8], ylim = c(18, 54), panel.first = grid(),add=TRUE)
# title(" 中国地图")
#mydat = readShapePoly("E:/datasoftware/R-3.1.2/library/maps/bou2_4p.shp")
#mydat[1,]@data
# library(ggmap)
# library(mapproj)
# # ## Google啊Google给我China的地图数据吧
# map <- get_map(location = 'China', zoom = 4)
 ggmap(map)
map<-ggmap(map)
lon<-city[[1]][1:30]
lat<-city[[2]] [1:30]
count<-posdata[,2]
count1<-negdata[,2]
map1<-map+geom_point(data=posdata,aes(x=lon,y=lat),colour='yellow',size=(count/8), alpha=0.6,text=city1)
map1+geom_point(data=negdata,aes(x=lon,y=lat),colour='orange',size=(count1/3), alpha=0.8)

title("iPhone6用户评论情感地图")

