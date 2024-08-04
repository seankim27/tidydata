library(tidyverse)

## [1] : Merge data sets 
### Load feature and activity
features <- read_table('./features.txt', col_names = c('n', 'feature'))
activities <- read_table('./activity_labels.txt', col_names = c('n', 'activity'))

### Load Test data
X_test <- read_table('./test/X_test.txt', col_names = features$feature)
Y_test <- read_table('./test/Y_test.txt', col_names = 'code')
subject_test <- read_table('./test/subject_test.txt', col_names = 'subject')
X_Y_test <- bind_cols(subject_test, X_test, Y_test)

### Load Training data
X_train <- read_table('./train/X_train.txt', col_names = features$feature)
Y_train <- read_table('./train/y_train.txt', col_names = 'code')
subject_train <- read_table('./train/subject_train.txt', col_names = 'subject')
X_Y_train <- bind_cols(subject_train, X_train, Y_train)

### Merge test and train data sets
merged_data <- bind_rows(X_Y_test, X_Y_train)

## [2]: Extract mean and standard deviation for each measurement
mean_sd_data <- merged_data |>
  select(subject, code, contains('mean'), contains('std'))

##[3] Assign activity
mean_sd_data$code <- activities[mean_sd_data$code, 2]

##[4] Descriptive variable names
names(mean_sd_data)[2] = "activity"
names(mean_sd_data)<-gsub("Acc", "Accelerometer", names(mean_sd_data))
names(mean_sd_data)<-gsub("Gyro", "Gyroscope", names(mean_sd_data))
names(mean_sd_data)<-gsub("BodyBody", "Body", names(mean_sd_data))
names(mean_sd_data)<-gsub("Mag", "Magnitude", names(mean_sd_data))
names(mean_sd_data)<-gsub("^t", "Time", names(mean_sd_data))
names(mean_sd_data)<-gsub("^f", "Frequency", names(mean_sd_data))
names(mean_sd_data)<-gsub("tBody", "TimeBody", names(mean_sd_data))
names(mean_sd_data)<-gsub("-mean()", "Mean", names(mean_sd_data), ignore.case = TRUE)
names(mean_sd_data)<-gsub("-std()", "STD", names(mean_sd_data), ignore.case = TRUE)
names(mean_sd_data)<-gsub("-freq()", "Frequency", names(mean_sd_data), ignore.case = TRUE)
names(mean_sd_data)<-gsub("angle", "Angle", names(mean_sd_data))
names(mean_sd_data)<-gsub("gravity", "Gravity", names(mean_sd_dataa))

tidydata <- mean_sd_data
rm(mean_sd_data)

## [5]: Tidydata2

Tidydata2 <- tidydata |>
  group_by(activity, subject) |>
  summarise_all(funs(mean))




