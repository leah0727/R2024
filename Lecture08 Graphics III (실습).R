# install.packages("ggplot2")
library(ggplot2)

# iris data로 산점도 그려보기
ggplot(iris) + 
  aes(Sepal.Length, Sepal.Width) + 
  geom_point()

# geom_point() 안에 다양한 옵션 넣기
ggplot(iris) +
  aes(Sepal.Length, Sepal.Width) + 
  geom_point(color="red", size=1)

ggplot(iris) + aes(Sepal.Length, Sepal.Width) + geom_point(color="red", size=1)       # 1) 따로
ggplot(iris) + geom_point(color="red", size=1) + aes(Sepal.Length, Sepal.Width)       # 2) 위치 변경
ggplot(iris, aes(Sepal.Length, Sepal.Width)) + geom_point(color="red", size=1)        # 3) ggplot안에 aes 넣기
ggplot(iris) + geom_point(aes(Sepal.Length, Sepal.Width), color="red", size=1)        # 4) geom안에 aes넣기
ggplot() + geom_point(data=iris, aes(Sepal.Length, Sepal.Width), color="red", size=1)  # 5) geom안에 data도 넣기

p <- ggplot(iris) + aes(Sepal.Length, Sepal.Width)
p + geom_point()
p + geom_point(color="red", size=1)
p + geom_point(color="blue", size=1)

ggplot(iris) + 
  aes(Sepal.Length, Sepal.Width, color=Species) + 
  geom_point()

ggplot(iris) + 
  aes(Sepal.Length, Sepal.Width, color=Species) + 
  geom_point(position="jitter", alpha=0.5) + 
  xlim(5,7)


# 자동차 class의 개수에 대한 막대그림
ggplot(mpg) + 
  aes(class) + 
  geom_bar()

# class별로 색상 다르게 주기
ggplot(mpg) +
  aes(class, color=class) + 
  geom_bar()

ggplot(mpg) + 
  aes(class, fill=class) + 
  geom_bar()

ggplot(mpg) + aes(class, displ) + geom_col()  # 클래스별 연비 총합

# class에 따른 평균 연비 막대그래프
library(dplyr)
mpg %>% 
  group_by(class) %>% 
  summarize(mean_displ = mean(displ)) -> df # 클래스별 평균 연비 계산

ggplot(df) +
  aes(class, mean_displ) + 
  geom_col()

# economics 데이터
# 날짜에 따른 인구수와 실업자수 데이터 포함
# ?economics
data(economics)
str(economics)

# 날짜에 따른 실업자수 선 그래프
ggplot(economics) + 
  aes(date, unemploy) + 
  geom_line()

# 날짜에 따른 실업률(실업자수/인구수) 선그래프
ggplot(economics) + 
  aes(date, unemploy/pop) + 
  geom_line()

ggplot(economics) + 
  aes(date, unemploy/pop) + 
  geom_line() + 
  xlim(as.Date("1967-07-01"), as.Date("1977-07-01"))

ggplot(economics) + 
  aes(date, unemploy/pop) + 
  geom_step() + 
  xlim(as.Date("1967-07-01"), as.Date("1977-07-01"))

ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  geom_point() + 
  geom_line()

ggplot(iris) + 
  geom_point(aes(Sepal.Length, Sepal.Width), color="red") + 
  geom_point(aes(Sepal.Length, Petal.Length), color="blue")

# 자동차 고속도로 연비(hwy)으로 ggplot그려보기
ggplot(mpg) + aes(hwy) + geom_bar()
ggplot(mpg) + aes(hwy) + geom_histogram()
ggplot(mpg) + aes(hwy) + geom_dotplot()
ggplot(mpg) + aes(hwy) + geom_density()
ggplot(mpg) + aes(hwy) + geom_freqpoly()

# class별 hwy
ggplot(mpg) + aes(hwy, fill=class) + geom_bar()
ggplot(mpg) + aes(hwy, fill=class) + geom_histogram()
ggplot(mpg) + aes(hwy, fill=class) + geom_dotplot()
ggplot(mpg) + aes(hwy, fill=class) + geom_density()
ggplot(mpg) + aes(hwy, color=class) + geom_freqpoly()

ggplot(mtcars) + aes(mpg) + geom_histogram(binwidth=1.5)

ggplot(mtcars) + aes(mpg) + geom_histogram(bins=20)

ggplot(mpg) + aes(hwy) + geom_histogram()

ggplot(mpg) + aes(hwy) + geom_histogram(binwidth=1.5)

ggplot(mpg) + aes(hwy) + geom_histogram(bins=10)

ggplot(mpg) + aes(hwy) + geom_histogram(bins=10, color="white")

ggplot(mpg) + aes(hwy) + geom_histogram(bins=10, color="white", fill="navy")

ggplot(mpg) + aes(hwy, fill=class) + geom_bar()

ggplot(mpg) + aes(hwy, fill=class) + geom_bar(position="dodge")

ggplot(mpg) + aes(hwy, fill=class) + geom_bar(position="stack")

ggplot(mpg) + aes(hwy, fill=class) + geom_bar(position="fill")

ggplot(mpg) + aes(hwy, fill=class) + geom_density()

ggplot(mpg) + aes(hwy, fill=class) + geom_density(alpha=0.5)

ggplot(iris) + aes(Sepal.Length) + geom_dotplot()

ggplot(iris) + aes(Sepal.Length) + geom_dotplot(binwidth=0.1)

ggplot(iris) + aes(Sepal.Length) + geom_dotplot(binwidth=0.1, stackdir="centerwhole")

ggplot(iris) + 
  aes(Species, Sepal.Length) + 
  geom_dotplot(binaxis="y")

ggplot(iris) + 
  aes(Species, Sepal.Length) + 
  geom_dotplot(binaxis="y", stackdir="center")

ggplot(iris) + 
  aes(Species, Sepal.Length, color=Species) + 
  geom_dotplot(binaxis="y", stackdir="center")

ggplot(iris) + 
  aes(Species, Sepal.Length, fill=Species) + 
  geom_dotplot(binaxis="y", stackdir="center")

ggplot(iris) + 
  aes(Species, Sepal.Length) + 
  geom_violin()

# geom_violin과 geom_dotplot 겹쳐 그리기
ggplot(iris) + 
  aes(Species, Sepal.Length) +
  geom_dotplot(aes(fill=Species), binaxis="y", stackdir="center") +
  geom_violin()

# violin plot을 뒤로 보내기
ggplot(iris) + 
  aes(Species, Sepal.Length) +
  geom_violin() + 
  geom_dotplot(aes(fill=Species), binaxis="y", stackdir="center")

ggplot(iris) +
  aes(Species, Sepal.Length, color=Species) + 
  geom_jitter()

ggplot(iris) +
  aes(Species, Sepal.Length, color=Species) + 
  geom_jitter(width=0.25, alpha=0.5)

ggplot(iris) + 
  aes(Species, Sepal.Length, color=Species) + 
  geom_boxplot()

