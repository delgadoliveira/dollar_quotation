rm(list=ls())
library(Quandl)
library(ggplot2)

Quandl.api_key('XXXXX') #input here your Quandl Key

my.BCB.code<-'BCB/10813'
#my.BCB.code<-"CURRFX/USDBRL"

start_date<-"2000-01-01"

my.df<-Quandl(my.BCB.code,type='raw', start_date=start_date)
x11()
qplot(data=my.df, x=my.df$Date, y=my.df$Value, geom= 'line') 

#Condicao de filtragem
my.df$condition <- format(my.df$Date, "%d")==30 & as.integer(format(my.df$Date, "%m"))%%6 ==0 | 
    format(my.df$Date, "%d")==31  & as.integer(format(my.df$Date, "%m"))%%6 ==0

p<-ggplot(my.df, aes(x=Date, y=Value, color=Value)) 
p<-p+geom_line()
p<-p+geom_text(data=subset(my.df,my.df$condition==T),aes(Date,Value,label=Value))
print(p)

print(my.df[1:10,])
