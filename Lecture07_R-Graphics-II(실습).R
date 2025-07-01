xx <- par()
class(xx); length(xx)

opar <- par(no.readonly=T)  # 현재 모수 설정 저장

# Global하게 그래프 모수 설정
par(pch=17, col="navy")
mpg <- ggplot2::mpg
plot(mpg$displ, mpg$hwy, type="p")
plot(mpg$cty, mpg$hwy)

# 저장해둔 기존 그래프 모수로 복원
par(opar)  
plot(mpg$displ, mpg$hwy)
plot(mpg$displ, mpg$hwy, pch=17, col="navy")

par(mfcol=c(3,3),    # 영역 분할 (3행 3열)
    mar=c(4,3,3,1),  # 내부 마진 영역 
    oma=c(0,0,3,0))  # 외부 마진 영역

plot(mpg$displ, mpg$hwy, pch=19, col=4, main="col=4")
plot(mpg$displ, mpg$hwy, pch=19, col="blue", main="col='blue'")
plot(mpg$displ, mpg$hwy, pch=19, col="#0000FF", main="col='#0000FF'")
plot(mpg$displ, mpg$hwy, pch=19, col=rgb(0,0,255,max=255), main="col=rgb(0,0,255)")

plot.new()   # 빈 그림 삽입

plot(mpg$displ, mpg$hwy, pch=15, col=2, main="col=2")
plot(mpg$displ, mpg$hwy, pch=15, col="red", main="col='red'")
plot(mpg$displ, mpg$hwy, pch=15, col="#FF0000", main="col='#FF0000'")
plot(mpg$displ, mpg$hwy, pch=15, col=rgb(255,0, 0, max=255), main="col=rgb(255,0,0)")

par(opar)    # 기존 설정으로 복원

# 3행 2열 영역 생성 후 레이아웃 확인
layout(matrix(1:6, nrow=3, ncol=2, byrow=TRUE))
layout.show(6)

# 1행 1,2열에 첫번째 그림 그리기
# 2,3행 1열에 두번째 그림 그리기
# 2행 2열에 세번째 그림 그리기
# 3행 2열에 네번째 그림 그리기

layout(matrix(c(1, 2, 2, 1, 3, 4), nrow=3, ncol=2, byrow=F))
layout.show(4)


# 2행 2열은 비워두고 싶은 경우
layout(matrix(c(1,2,2,1,0,3), nrow=3, ncol=2, byrow=F))
layout.show(3)


# 1개의 그림을 가로 10cm, 세로 5cm로 그리고 싶은 경우
layout(matrix(1), widths=lcm(10), height=lcm(5))
layout.show(1)

dev.off()

# 3행 2열 그림에서 2개의 열너비가 8cm, 2cm, 3개의 행높이가 5cm, 3cm, 2cm가 되도록 
layout(matrix(1:6, nrow=3, ncol=2), 
       widths=lcm(c(8,2)), 
       heights=lcm(c(5,3,2)))
layout.show(6)

par(opar)

par(mfrow=c(2,2))
plot(mpg$displ, mpg$hwy, font.main=1, main="font=1 (plain)")
plot(mpg$displ, mpg$hwy, font.main=2, main="font=2 (bold)")
plot(mpg$displ, mpg$hwy, font.main=3, main="font=3 (italics)")
plot(mpg$displ, mpg$hwy, font.main=4, main="font=4 (bold italics)")

# R 기본 폰트 적용
plot(mpg$displ, mpg$hwy, family = "mono")
text(4, 40, "mono", family = "mono")
text(5, 35, "sans", family = "sans")
text(6, 40, "serif", family = "serif")

# 구글에서 다운받은 폰트 사용
#install.packages("showtext")
library(showtext)

font_add_google("Nanum Pen Script", family="nanumpen")  # 구글에서 다운로드
showtext_auto()                                         # showtext 자동 시작
plot(mpg$displ, mpg$hwy, 
     xlab="배기량", 
     ylab="고속도로연비", 
     family="nanumpen", 
     cex.lab=3)

par(opar)

# 폰트 다운받기
library(showtext)
font_add_google("Courier Prime", family="courierprime")
showtext_auto()

# plot() 안에서 제목, 축이름 쓰기
par(family="courierprime", mfrow=c(1,2))
plot(mpg$displ, mpg$hwy, pch=16, cex=0.8, col="navy", 
     main="Scatter plot of highway miles per gallon vs. engine displacement", 
     xlab="Engine displacement (in liters)", 
     ylab="Highway (mpg)", 
     cex.main=1.5, 
     cex.lab=1.2, 
     font.main=4, 
     font.lab=2, 
     las=1)

# title()로 제목, 축이름 쓰기
plot(mpg$displ, mpg$hwy, pch=13, cex=0.8, col="firebrick3", ann=F)
title(main="Scatter plot of highway miles per gallon vs. engine displacement", 
      cex.main=1.5, font.main=3)
title(xlab="Engine displacement (in liters)", cex.lab=1.2, font.lab=3)
title(ylab="Highway miles per gallon", cex.lab=1.2, font.lab=2)

par(mfrow=c(1,2))
plot(mpg$displ, mpg$hwy, axes=F)      # 축 제거
axis(side=1)                          # x축 추가
axis(2)                               # y축 추가


# change axis tick-marks
# summary(mpg$displ)
# summary(mpg$hwy)
plot(mpg$displ, mpg$hwy, axes=F)
axis(1, at=1:8)
axis(1, at=seq(1.5, 7.5, 1), labels=F, tcl=-0.3)
axis(2, at=seq(10, 50, 5), tcl=-0.5, las=2)

# remove axis tick labels
par(mfrow=c(1,3))
plot(mpg$displ, mpg$hwy, xaxt="n", main="xaxt='n'")
plot(mpg$displ, mpg$hwy, yaxt="n", main="yaxt='n'")
plot(mpg$displ, mpg$hwy, xaxt="n", yaxt="n", main="xaxt='n', yaxt='n'")


#  change axis tick labels
par(opar)

library(showtext)
font_add_google("David Libre", family="david")
showtext_auto()
par(family="david")
plot(mpg$displ, mpg$hwy, pch=16, col="seagreen", xaxt="n", ann=F)
axis(1, at=1:8, labels=paste0(1:8, "mpg"))
title(xlab="Engine Displacement", cex.lab=1.2, font.lab=2)
title(ylab="Highway miles per gallon", cex.lab=1.2, font.lab=2)

# pos
plot(mpg$displ, mpg$hwy, pch=16, axes=F, xlim=c(1,8), ylim=c(10,50))
axis(1, at=1:8, pos=10)
axis(2, at=seq(10,50,5), pos=1)

plot(mpg$displ, mpg$hwy)
lines(x=c(2,6), y=c(15, 40), lty=3, lwd=3, col="seagreen3")
abline(20, 3, lty=2, lwd=1, col="navy")
abline(h=30, lty=1, lwd=3, col="orange")
abline(v=4.5, lty=6, lwd=3, col="steelblue3")
abline(lm(mpg$hwy~mpg$displ), lty=1, lwd=3, col="firebrick3")


par(mfrow=c(1,2))

plot(mpg$displ, mpg$hwy, pch=16)
points(x=c(3, 6), y=c(15, 35), pch=17, cex=2.4, col="blue")
points(mean(mpg$displ), mean(mpg$hwy), pch=3, cex=3, col="firebrick3", lwd=6)


# ------ points()를 이용한 그룹별 색 지정 -------- #

# 그룹별로 데이터 분할
library(dplyr)
iris %>% group_split(Species) -> sub

# 첫번째 그룹으로 plot 생성
plot(sub[[1]]$Sepal.Length, sub[[1]]$Petal.Length, pch=16, col="blue", xlim=c(4, 8), ylim=c(0,7))

# 나머지 그룹들은 순차적으로 점 도표표
points(sub[[2]]$Sepal.Length, sub[[2]]$Petal.Length, pch=16, col="red")
points(sub[[3]]$Sepal.Length, sub[[3]]$Petal.Length, pch=16, col="green")

# 범례 추가
legend("bottomright", col=c("blue", "red", "green"), legend=levels(iris$Species), pch=16, bty="n")

library(showtext)

font_add_google("Nanum Myeongjo", family="nanummyeongjo")
showtext_auto()

dev.off() 

par(family="nanummyeongjo")
plot(mpg$displ, mpg$hwy, pch=16)
text(7, 43, "배기량 대비 고속도로 연비", cex=1.2, font=2, adj=1)
text(mpg$displ, mpg$hwy, mpg$manufacturer, cex=0.8, pos=1)

library(showtext)
font_add_google("Noto Serif KR", "notoserifkr")
showtext_auto()

par(family="notoserifkr")
plot(mpg$displ, mpg$hwy, pch=16)
mtext("배기량 대비 고속도로 연비", side=3, cex=2, font=2, line=2)
