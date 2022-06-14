require(xlsx)

setwd("~/Desktop/BCG_Online/Task 2")

train_data <- read.csv("ml_case_training_data.csv")
train_data_op <- read.csv("ml_case_training_output.csv")
hist <- read.csv("ml_case_training_hist_data.csv")


### Merge dataset
train <- merge(train_data, train_data_op, by = "id")


### 
names(train)
lapply(train, class)
names(hist)
lapply(hist, class)



### Convert Data Type
train$date_activ <- as.Date(train$date_activ, "%Y/%m/%d")
train$date_end <- as.Date(train$date_end, "%Y/%m/%d")
train$date_first_activ <- as.Date(train$date_first_activ, "%Y/%m/%d")
train$date_modif_prod <- as.Date(train$date_modif_prod, "%Y/%m/%d")
train$date_renewal <- as.Date(train$date_renewal, "%Y/%m/%d")
train$has_gas <- as.logical(toupper(train$has_gas))
train$churn <- as.logical(train$churn)

train$activity_new <- as.factor(train$activity_new)
train$channel_sales<- as.factor(train$channel_sales)
train$origin_up <- as.factor(train$origin_up)

hist$price_date <- as.Date(hist$price_date, "%Y/%m/%d")


colMeans(is.na(train))
colMeans(is.na(hist))
train_rm <- which(colMeans(is.na(train)) > 0.7)
train <- train[, -train_rm]


names(train)[unique(ceiling(which(is.na(train))/nrow(train)))]


id.rm <- train[rowSums(is.na(train)) > 0, 1]

train[rowSums(is.na(train)) > 0,]
train_new <- na.omit(train)
hist_new <- hist[!(hist$id %in% id.rm), ]


# rowSums(is.na(hist_new)) > 0


scan_i = 1
while (!is.na(hist_new$id[scan_i]))
{
  if (month(hist_new$price_date[scan_i]) %% 12 != scan_i %% 12){
    if (hist_new$id[scan_i-1] == hist_new$id[scan_i]){
      hist_new <- hist_new %>% add_row(hist_new[scan_i - 1, ], .before = scan_i)
    }
    else {
      hist_new <- hist_new %>% add_row(hist_new[scan_i, ], .before = scan_i)
    }
    hist_new$price_date[scan_i] <- hist_new$price_date[scan_i] %m+%
      months(scan_i %% 12 - month(hist_new$price_date[scan_i]))
  }
  
  if (sum(is.na(hist_new[scan_i, ])) > 0){
    if (hist_new$id[scan_i-1] == hist_new$id[scan_i]){
      hist_new[scan_i, 3:8] <- hist_new[scan_i-1, 3:8]
    }
    else {
      for (k in 1:12) {
        if (sum(is.na(hist_new[scan_i+k, 3:7])) == 0){
          hist_new[scan_i, 3:8] <- hist_new[scan_i+k, 3:8]
          break
        }
      }
      
    }
  }
    
  scan_i = scan_i + 1
}




train_num <- unlist(lapply(train, is.numeric))
X <- train[, train_num]
cor(X, use = "complete.obs")


library(mctest)
omcdiag(X)

temp = 2


