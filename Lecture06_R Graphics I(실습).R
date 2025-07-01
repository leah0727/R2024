library(knitr)
library(kableExtra)

## **Generic plot**
a <- seq(1,20,2)
b <- a^2

plot(x=a, y=b, type="p")   # for points
plot(a, b, type="l")       # for lines
plot(a, b, type="b")       # for both (points and lines)
plot(a, b, type="o")       # for overlapping (points and lines)
plot(a, b, type="h")       # for histogram (vertical lines)
plot(a, b, type="s")       # for stair steps
plot(a, b, type="n")       # for no plotting

## **Histogram**
library(moonBook)
data(acs)
attach(acs)

# age로 히스토그램 작성 (bin 개수 자동 지정)
hist(x=age)                                

# age로 히스토그램 작성 (bin 개수 직접 지정)
hist(age,                                  
     breaks=40,                            # 셀 개수
     xlim=c(30,90),                        # x축 범위
     ylim=c(0, 100),                       # y축 범위
     main="Histogram of age in acs data",  # 그래프 제목
     xlab="Age (year)",                    # x축 제목
     ylab="Frequency")                     # y축 제목

detach(acs)

## **Line Plot**
library(datasets)
longley

plot(longley$Year, longley$Employed, type="p")     # 점 도표
plot(longley$Year, longley$Employed, type="l")     # 선 도표로 변경

# **선 종류(lty)**
attach(longley)                                         # longley data로 접근

plot(Year, Employed, type="l", lty="dashed")            # dashed
plot(Year, Employed, type="l", lty=5)                   # 5=longdash
plot(Year, Employed, type="l", lty=3, lwd=2, col="red") # 3=dotted, 두께2, 빨강
plot(Year, Employed, type="l", lty=4, lwd=3.5)          # 4=dotdash, 두께3.5, 초록

# 숫자에 따른 색상 차트 
pie(rep(1,9), col=0:8, labels=0:8)

# 4가지 방식으로 색상 지정
attach(longley)
plot(Year, Employed, type="l", col=4, main="col=4")
plot(Year, Employed, type="l", col="blue", main="col='blue'")
plot(Year, Employed, type="l", col="#0000FF", main="col='#0000FF'")
plot(Year, Employed, type="l", col=rgb(0,0,255,max=255), main="col=rgb(0,0,255)")
detach(longley)

# Year에 따른 Employed에 대한 선도표 작성
plot(Year, Employed,            
     type="l", 
     col="darkviolet", 
     lwd=3, 
     main="No. of employed people on 1947-1962",
     xlab="Year", 
     ylab="No. of employed people")


# Year에 따른 Employed에 대한 회귀모형 적합
fit <- lm(Employed ~ Year, data=longley)
summary(fit)

# 그림 위에 회귀선 추가
abline(fit, lty=2, lwd=1, col="gray80")

# 그림 위에 텍스트 추가
text(x=1950, y=70, labels="R2 = 0.9435 (p<0.001)")

detach(longley)

## **Scatter plot**
data(iris)

plot(iris$Sepal.Length, iris$Petal.Length,   # x, y 지정
     type="p",                               # point (default)
     pch=16,                                 # type of point
     col="firebrick3",                       # color of point
     cex=0.8,                                # size of point
     main="Iris characteristics by Species", # title
     xlab="Sepal Length",                    # x label
     ylab="Petal Length",                    # y label
     col.main=1,                             # 그래프 제목 색상
     col.axis=2,                             # 축 눈금 색상
     col.lab=3)                              # 축 이름 색상

plot(iris$Sepal.Length, iris$Petal.Length, pch=16, col=1)
plot(iris$Sepal.Length, iris$Petal.Length, pch=16, col=iris$Species)
plot(iris$Sepal.Length, iris$Petal.Length, pch=16, col=c("blue", "red", "green"))
plot(iris$Sepal.Length, iris$Petal.Length, pch=16, col=c("blue", "red", "green")[iris$Species])

# 그룹별 모수 지정
mypch = c(15, 16, 17)
mycol = c("darkcyan", "darkgoldenrod2", "brown1")

# 그룹별 점 종류와 색상을 달리한 scatterplot 작성
plot(iris$Sepal.Length, iris$Petal.Length,   # x, y 지정
     type="p",                               # point (default)
     pch=mypch[iris$Species],                # type by Species
     col=mycol[iris$Species],                # color by Species
     cex=0.8,                                # size of point
     main="Iris characteristics by Species", # title
     xlab="Sepal Length (cm)",               # x label
     ylab="Petal Length (cm)")               # y label

# 범례 추가
legend(x=4.5, y=7, pch=mypch, col=mycol, legend=c("setosa", "versicolor", "virginica"))
legend("bottomright", pch=mypch, col=mycol, legend=levels(iris$Species), lty=1, bty="n")

## **Box Plot**
# 세로형
boxplot(iris$Sepal.Length ~ iris$Species,   # y~x 지정
        col="navy",                         # 박스 색상   
        border="darkcyan",                  # 테두리 색상
        main="Sepal Length by Species",     # 그래프 제목
        xlab="Species",                     # x축 이름
        ylab="Sepal Length",                # y축 이름
        cex.main=1.2,                       # 그래프 제목 글자 크기
        cex.axis=0.8,                       # 축 눈금 글자 크기
        cex.lab=0.9)                        # 축 이름 글자 크기


# 가로형 + notch 부여 + las 1 부여
boxplot(iris$Sepal.Length ~ iris$Species,   # y~x 지정
        col="navy",                         # 박스 색상   
        border="darkcyan",                  # 테두리 색상
        main="Sepal Length by Species",     # 그래프 제목
        xlab="Sepal Length",                # x축 이름
        ylab="",                            # y축 이름
        horizontal=T,                       # 가로로 누운 박스플롯
        notch=T,                            # notch 주기
        las=1,                              # 축 눈금 아래 보기
        cex.main=1.2,                       # 그래프 제목 글자 크기
        cex.axis=0.8,                       # 축 눈금 글자 크기
        cex.lab=0.9)                        # 축 이름 글자 크기

## **Bar Plot**
# Bar 높이에 해당하는 값 계산 
smoke <- factor(acs$smoking, levels=c("Never", "Ex-smoker", "Smoker"))
tab <- table(smoke)

# 세로형
barplot(tab,                                              # height 
        names.arg = c("None", "Ex-smoking", "Smoking"),   # 막대 라벨
        col = "navy",                                     # 막대 색상
        border = "darkcyan",                              # 막대 테두리 색상
        ylim=c(0,500))                                    # y축 범위

# 가로형
barplot(tab,                                              # height 
        names.arg = c("None", "Ex-smoking", "Smoking"),   # 막대 라벨
        col = "navy",                                     # 막대 색상
        border = "darkcyan",                              # 막대 테두리 색상
        font.axis = 4,                                    # 축 눈금 굵은 이탤릭체체 
        horiz=T,                                          # 가로 막대 그래프
        xlim=c(0,500))                                    # x축 범위

# 그룹별 높이 계산
tab <- table(acs$sex, smoke)

# 누적막대그래프
barplot(tab, legend=T)

# 개별막대그래프
barplot(tab, beside=T, col="white", border=c("steelblue", "gold"))
legend("topleft", legend=c("Female", "Male"), col=c("steelblue", "gold"), pch=15, bty="n")

## **그래프 저장**
jpeg("C:/Users/User/Desktop/figure.jpg", width=1000, height=1000, res=200)
barplot(tab, beside=T, col="white", border=c("steelblue", "gold"))
legend("topleft", legend=c("Female", "Male"), col=c("steelblue", "gold"), pch=15, bty="n")
dev.off()