#Read file
titanic <- read.csv("titanic_traning.csv")

#to find the factors of each column in the dataframe
str(titanic)

#to count the amount of missing values for every column in the dataframe
colSums(is.na(titanic))

#convert "sex" inconsistencies from uppercase to lowercase
titanic$sex <- tolower(titanic$sex)


titanic$embarked[titanic$embarked == "Queenstown"] <- "Q"

#drop the extra level "Queenstown"
titanic <- droplevels(titanic)

#use the aggregate function to see what the average was base on age and seperated by sex
#takes the average age based on sex and inputs it back into the titanic dataframe for any NA values

aggregate(data = titanic, age ~ sex, mean, na.rm = TRUE)
ave_age <- ave(titanic$age, titanic$sex, FUN = function(x) mean(x, na.rm = TRUE))
titanic$age <- ifelse(is.na(titanic$age), ave_age, titanic$age)

#use the aggregate function to see what the average was base on fare and seperated by ticket class
#takes the average fare based on ticket class and inputs it back into the titanic dataframe for any NA values
aggregate(data = titanic, fare ~ pclass, mean, na.rm = TRUE)
ave_fare <- ave(titanic$fare, titanic$pclass, FUN = function(x) mean(x, na.rm = TRUE))
titanic$fare <- ifelse(is.na(titanic$fare), ave_fare, titanic$fare)

#Save file to directory
write.csv(titanic, file = "titanic_traningUpdated.csv", row.names = FALSE)