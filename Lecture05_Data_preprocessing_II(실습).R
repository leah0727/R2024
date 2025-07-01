knitr::opts_chunk$set(echo = TRUE)
library(knitr)
library(kableExtra)
## **데이터 파악**
#### **데이터 구조 파악**
dpath <- "C:/Users/User/Desktop/"
exam <- read.csv(paste0(dpath, "exam.csv"))

head(exam)     # 처음 6행 출력
head(exam, 3)  # 처음 3행 출력
tail(exam)     # 마지막 6행 출력
tail(exam, 2)  # 마지막 2행 출력
View(exam)     # 뷰어창에 데이터 출력
colnames(exam) # 변수명 벡터 출력
dim(exam)      # 데이터 차원 출력 (행, 열 순으로 길이 2 벡터가 출력됨)
str(exam)      # 데이터의 차원, 변수명, 변수타입, 초반 데이터 출력


#### **요약통계량 출력**
exam$class <- as.factor(exam$class)   # class 변수를 factor로 변환
str(exam)                             # factor로 변환되었는지 확인

summary(exam)


## **데이터 전처리**
#### **주요 함수**
#### **변수명 변경**
library(dplyr)

new_exam <- exam

# 1개 변수명 변경 - id를 no로 변경
new_exam <- rename(new_exam, no=id)
head(new_exam, 3)

# 3개 변수명 동시 변경 - math, english, science 제일 앞 글자로 변경
new_exam <- rename(new_exam, m=math, e=english, s=science)
head(new_exam, 3)

#### **특정 개체 추출**
filter(exam, class==1)                 # class가 1인 경우 추출
filter(exam, class==2)                 # class가 2인 경우 추출
filter(exam, class==1 | class==2)      # class가 1 또는 2인 경우 추출
filter(exam, class!=1)                 # class가 1이 아닌 경우 추출
filter(exam, math>=50)                 # 수학점수가 50점 이상인 경우 추출
filter(exam, math<50)                  # 수학점수가 50점 미만인 경우 추출
filter(exam, math>=70 & english>=70)   # 수학점수와 영어점수 모두 70점 이상인 경우 추출

# class가 1, 3, 5반인 경우 추출
filter(exam, class==1 | class==3 | class==5)  
filter(exam, class %in% c(1, 3, 5))     

class1 <- filter(exam, class==1)   # class가 1인 행 추출하여 class1에 할당
class2 <- filter(exam, class==2)   # class가 2인 행 추출하여 class2에 할당

mean(class1$math)   # 1반 수학점수 평균 구하기
mean(class2$math)   # 2반 수학점수 평균 구하기

#### **특정 변수 추출**
select(exam, math)                      # 수학점수 추출
select(exam, class, math, english)      # class, 수학점수, 영어점수 추출
select(exam, -id, -math, -science)      # id, 수학점수, 과학점수 제외하고 추출

# id와 math변수를 추출하여 첫 10행 출력해보기
sub <- select(exam, id, math)
head(sub, 10)

head(select(exam, id, math), 10)

exam %>%                        
  select(id, math) %>% 
  head(10)

# class가 1인 데이터에서 수학, 영어, 과학점수 추출
class1 <- filter(exam, class==1)
select(class1, math, english, science)

select(filter(exam, class==1), math, english, science)

exam %>% 
  filter(class==1) %>% 
  select(math, english, science)

#### **정렬**
arrange(exam, math)        # 수학점수 기준 오름차순 정렬
arrange(exam, desc(math))  # 수학점수 기준 내림차순 정렬
arrange(exam, class, math) # class > 수학점수 순으로 오름차순 정렬

#### **파생변수 생성**
# 총점변수 total 생성
exam1 <- mutate(exam, total = math + english + science)  
head(exam1)

# 총점변수 total, 평균점수 meanscore 생성
exam2 <- mutate(exam, 
                total = math + english + science,         
                meanscore = (math + english + science)/3) 
head(exam2)

# 과학점수가 60점 이상이면 pass, 아니면 fail인 test 변수 생성
exam3 <- mutate(exam, 
                test = ifelse(science>=60, "pass", "fail"))
head(exam3)

exam4 <- exam %>% 
  mutate(test=ifelse(science>=60, "pass", "fail"))
head(exam4)

# 총점변수 total 생성 후 이에 대해 내림차순 정렬하여 상위 10명 출력
exam %>% 
  mutate(total = math + english + science) %>% 
  arrange(desc(total)) %>% 
  head(10)

#### **요약통계량 계산**
summarise(exam, mean_math = mean(math)) # 수학점수 평균 계산
summarise(exam, n = n())                # 전체 명수 계산 (n()은 괄호안에 변수입력안함)

# 과목별 평균 계산
summarise(exam, 
          mean_math = mean(math), 
          mean_eng  = mean(english), 
          mean_sci  = mean(science))

#### **집단별 요약통계량 계산**
# class별로 수학점수 평균 계산
summarise(group_by(exam, class), mean_math = mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

# class별로 명수 계산
summarise(group_by(exam, class), n_class = n())

exam %>% 
  group_by(class) %>% 
  summarise(n_class = n())

# 여러 요약통계량 한번에 산출하기
# class별로 수학평균, 수학합계점수, 영어중앙값, 명수 계산

summarise(group_by(exam, class), 
          mean_math = mean(math), 
          total_math = sum(math), 
          median_eng = median(english), 
          n_class = n())

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math), 
            total_math = sum(math), 
            median_eng = median(english), 
            n_class = n())



# 각 class 내에서 수학 60점미만/이상에 따라 명수, 영어와 과학 평균점수 계산

exam %>% 
  mutate(math_pass = ifelse(math>=60, "pass", "fail")) %>% 
  group_by(class, math_pass) %>% 
  summarise(n = n(), 
            mean_eng = mean(english), 
            mean_sci = mean(science))


#### **데이터 합치기**
class <- 1:5
teacher <- c("Kim", "Lee", "Park", "Choi", "Jung")
name <- data.frame(class=factor(class), teacher)

left_join(exam, name, by="class")



data1 <- data.frame(id = 1:5, 
                    test1 = c(60, 80, 70, 90, 85))
data2 <- data.frame(id = c(3,2,1,4,5), 
                    test2 = c(70, 30, 80, 90, 100))
left_join(data1, data2, by="id")


data1 <- data.frame(id = 1:5, 
                    test1 = c(60, 80, 70, 90, 85))
data2 <- data.frame(id = 6:10, 
                    test1 = c(70, 30, 80, 90, 100))
bind_rows(data1, data2)


data1 <- data.frame(id = 1:5, 
                    test1 = c(60, 80, 70, 90, 85))
data2 <- data.frame(test1 = c(70, 30, 80, 90, 100), 
                    test2 = seq(60, 100, 10), 
                    id=6:10)
bind_rows(data1, data2)





## **Practice**
# install.packages("ggplot2", dependencies=c("Depends", "Imports"))
mpg <- ggplot2::mpg
class(mpg)
mpg <- as.data.frame(mpg)
class(mpg)
head(mpg)
tail(mpg)
View(mpg)
colnames(mpg)
dim(mpg)
str(mpg)
summary(mpg)

mpg %>% 
  mutate(displ_gp=ifelse(displ<=4, "small", "large")) %>% 
  group_by(displ_gp) %>% 
  summarise(mean_hwy = mean(hwy))

mpg %>% 
  filter(manufacturer %in% c("audi", "toyota")) %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty))

mpg_new <- mpg %>% 
  select(class, cty)
head(mpg_new, 3)

mpg_new %>% 
  group_by(class) %>% 
  summarise(n = n())

mpg_new %>% 
  filter(class %in% c("suv", "compact")) %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty))

mpg %>% 
  filter(class=="suv") %>% 
  group_by(model) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(10)

mpg %>% 
  mutate(total = hwy + cty, mean = (hwy+cty)/2) %>% 
  arrange(desc(mean)) %>% 
  select(model) %>% 
  unique() %>% 
  head(3)

mpg %>% 
  filter(class=="compact") %>% 
  group_by(manufacturer) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))



mpg %>% 
  filter(class=="compact") %>% 
  group_by(manufacturer) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))

