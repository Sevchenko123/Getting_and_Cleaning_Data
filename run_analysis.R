# Downloading and unzipping the file
fn <- "getdata_dataset.zip"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",fn,method="curl")
unzip(fn)

# Load labels and features
labels <- read.table("UCI HAR Dataset/activity_labels.txt")
labels[,2] <- as.character(labels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Subset data as per mean and standard deviation
required_features <- grep(".*mean.*|.*std.*",features[,2])
rf_names <- features[required_features,2]
rf_names <- gsub("mean","Mean",rf_names)
rf_names <- gsub("-std","Std",rf_names)
rf_names <- gsub("[-()]","",rf_names)

# Loading the train and test data
train <- read.table("UCI HAR Dataset/train/X_train.txt")[required_features]
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_subjects,train_activities,train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[required_features]
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test_subjects,test_activities,test)

# merge train and test data
data <- rbind(train,test)
colnames(data) <- c("Subject","Activity",rf_names)

data$Activity <- factor(data$Activity,levels=labels[,1],labels=labels[,2])
data$Subject <- as.factor(data$Subject)

# Melt the data
library(reshape2)
data_melt <- melt(data,id=c("Subject","Activity"))
data_mean <- dcast(data_melt,Subject+Activity~variable,mean)

# Exporting the data
write.table(data_mean,"tidy.txt",row.names=F,quote=F)
