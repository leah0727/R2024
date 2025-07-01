## **결측치** 

library(knitr)
library(kableExtra)

#### **결측치 관련 함수**
y <- c(1:3, NA)

# 결측치 확인
is.na(y)
is.na("NA")

# 결측치 개수 카운팅
sum(is.na(y))   
summary(y)

#### **결측치 연산**
8 + 2 + NA
8 - 2 + NA
8 * 2 * NA
NA / 2
NA * NA
NA <= 1

age <- c(58, 78, 44, 88, 999, 13, 26, 999)   # 999를 결측치를 사용한 경우
age[age == 999] <- NA                        # 999 부분을 NA로 치환
summary(age)
sum(age)                  # 결측치 포함하여 합계 계산
sum(age, na.rm=TRUE) 

#### **결측치 제거**
weight <- c(65.4, 55, 380, 72.2, 51, NA)
height <- c(170, 155, NA, 173, 161, 166)
gender <- c(1, 2, 1, 1, 2, 2)
gender <- factor(gender, labels=c("M", "F"))
dxdate <- c("2040/09/01", "2040/09/01", "2040/09/05", "2040/09/14", "2040/10/11", "2040/11/11")
patient <- data.frame(weight, height, gender, dxdate)
patient
str(patient)
na.omit(patient)                    # 결측치 있는 행 제거
complete.cases(patient)             # 결측치 없는 행 TRUE 반환

apply(patient[, 1:2], 2, mean, na.rm=T)
apply(patient[, 1:2], 1, sum, na.rm=T)

#### **날짜형 자료**
str(patient)
patient$dxdate <- as.Date(patient$dxdate, format="%Y/%m/%d")  # 진단일을 날짜형으로 변환
class(patient$dxdate)
str(patient)

x <- patient$dxdate[5] - patient$dxdate[1]
x
mode(x)
difftime(patient$dxdate[5], patient$dxdate[1], units="days")
difftime(patient$dxdate[5], patient$dxdate[1], units="weeks")

#### **날짜형 포맷**
as.Date("05/03/2020", format="%m/%d/%Y")
month.name     # 월 이름 목록
month.abb      # 월 이름 약어 목록

#### **날짜 관련 함수**
Sys.Date()
Sys.time()
Sys.timezone()
format(Sys.time(), tz="American/Los_Angeles")   # 미국 LA기준 현재 일시
OlsonNames()[1:10]  # 사용가능한 timezone 목록 (500개 이상 존재)

#### **lubridate 패키지**
library(lubridate)
now()

# 2040년 1월 1일부터 5일간의 날짜 데이터 생성
day1 <- as.Date("2040/01/01", "%Y/%m/%d")
day2 <- as.Date("2040/01/05", "%Y/%m/%d")
date <- seq(day1, day2, 1)              
date
date + 365      # 1년 뒤 날짜로 변경 (윤달이 있는 경우 오류 발생 가능)
date + years(1)  # 1년 뒤 날짜로 변경

## **Import/Export Data**

#### **작업 디렉토리(working directory)**
getwd()                                # 현재 경로 확인 (Check the current path)
mypath <- getwd()                      # 현재 경로 저장 (Save the current path)
setwd("C:/Users/User/Desktop")        # 바탕화면으로 경로 변경하기1 (change the path to desktop 1)
setwd("C:\\Users\\User\\Desktop")     # 바탕화면으로 경로 변경하기2 (change the path to desktop 2)
setwd(mypath)                          # 저장해둔 기존 경로로 변경 (Change to the saved path)

#### **read.table() / write.table()**

#* temperature.txt와 humidity.txt를 읽어보자(Read temperature.txt and humidity.txt)
temp <- read.table("C:/Users/User/Desktop/data/temperature.txt", header=T)
temp
humid <- read.table("C:/Users/User/Desktop/data/humidity.txt", header=T, ",")
humid
str(humid)
humid <- read.table("C:/Users/User/Desktop/data/humidity.txt", header=T, sep=",", na.strings=c(".", "NA"))
humid
str(humid)
patient[complete.cases(patient), ]  # na.omit(patient)와 동일한 결과 

#* `paste0()`을 이용하여 데이터 경로를 잡아보자(Let's get the data path using `paste0()`). 
#* paste0("a", "bc")
paste0(1:3, c("a","b","c"))

# 작업경로 저장(Save working directory)
path <- "C:/Users/User/Desktop/data"

# 작업경로를 이어붙여서 file명 써주기(Write the file name by concatenating the working directory)
temp <- read.table(paste0(path, "/temperature.txt"), header=T)
humid <- read.table(paste0(path, "/humidity.txt"), header=T, sep=",", na.strings=c(".", "NA"))

#* temp와 humid를 저장해보자(Let's save temp and humid). 
outpath <- paste0(path, "/output")
write.table(temp, paste0(outpath, "/temp.txt"), row.names=F)
write.table(humid, paste0(outpath, "/humid.txt"), row.names=F)

#### **read.csv() / write.csv()**
read.csv(paste0(path, "/humidity.txt"))
read.csv(paste0(path, "/humidity.txt"), na.strings=c(".", "NA"))
read.csv(paste0(path, "/temperature.txt"), sep=" ")

write.csv(temp, paste0(outpath, "/temp.csv"), row.names=F)

#### **xls/xlsx파일**
# install.packages(c("readxl", "writexl"), dependencies=c("Depends", "Imports"))
library(readxl)
temp <- read_excel(paste0(path, "/temperature.xlsx"))
humid <- read_excel(paste0(path, "/temperature.xlsx"), 2)                     # 시트 순서를 이용한 호출
humid <- read_excel(paste0(path, "/temperature.xlsx"), "humidity")            # 시트 이름을 이용한 호출

library(writexl)
write_xlsx(temp, paste0(outpath, "/temperature2.xlsx"))

#### **타 프로그램 형식 파일(other program format files)**
# install.packages(c("haven"), dependencies=c("Depends", "Imports"))
library(haven)

temp1 <- read_spss(paste0(path, "/temperature.sav"))
temp2 <- read_sas(paste0(path, "/temperature.sas7bdat"))
temp3 <- read_stata(paste0(path, "/temperature.dta"))

