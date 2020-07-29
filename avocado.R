avo <- read.csv(file.choose())
summary(avo)

#removing useless columns
head(avo)
avo <- subset(avo, select = -c(X))

head(avo)
names(avo)

avo <- subset(avo, select = -c(Date))
names(avo)

avo <- subset(avo,select = -c(region))
names(avo)

install.packages("dummies")
library(dummies)

dum <- dummy(avo$type , sep = ".")
head(dum)
dum <- as.data.frame.matrix(dum)

library(dplyr)

avo$conventional <- dum$type.conventional
avo$organic <- dum$type.organic

avo <- subset(avo,select = -c(type))
head(avo)

library(caTools)
split <- sample.split(avo,SplitRatio=0.8)
train_data <- subset(avo,split==TRUE)
test_data <- subset(avo, split==FALSE)

cr<-cor(avo)
cr

model <- lm(formula = AveragePrice~., data = train_data)
pred <- predict(model,test_data)
pred

plot(test_data$AveragePrice,type = "l",lty=1.8, col="green")

lines(pred,type="l", col="red")
