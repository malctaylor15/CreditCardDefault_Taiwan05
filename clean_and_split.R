

# import data 
data <- read.csv("UCI_Credit_Card.csv")

# look at data 
head(data)
summary(data)

# Data cleaning 

# Using some of the data cleaning from kaggle website 
# https://www.kaggle.com/moscolitos/d/uciml/default-of-credit-card-clients-dataset/exploratory-data-analysis#L39

# Make variables factors into factors
factor_vars <- c('SEX','EDUCATION','MARRIAGE','default.payment.next.month')
# make categorical variable factors by apply to each column 
data[factor_vars] <- lapply(data[factor_vars], function(x) as.factor(x))

# Small amounts of educationn at these levels- combine to reduce dimensionality 
x = data$EDUCATION[data$EDUCATION == c(0,4,5,6)]
length(x)
# Replace 3 educations with same value 
data$EDUCATION[data$EDUCATION== 4]  <- 0 
data$EDUCATION[data$EDUCATION== 5]  <- 0 
data$EDUCATION[data$EDUCATION== 6]  <- 0 

summary(data)

# Data looks ready for analysis 

#############
## ANALYSIS 
#############
set.seed(1)

data2 <- data 
# Delete row unique identifier row ID 
data2$ID <- NULL

# Split data into test and training sets 
indexes <- sample(1:nrow(data), size = 0.2*nrow(data))
test <- data[indexes, ]
train <- data[-indexes, ]

# Split training data into response and x data 
y_train <- train$LIMIT_BAL
x_train <- train
x_train$LIMIT_BAL <- NULL

# Split test data into response and x data 
y_test <- test$LIMIT_BAL
x_test <- test
x_test$LIMIT_BAL <- NULL

# remove other variables 
rm(data, data2, test, train, factor_vars, x, indexes)
