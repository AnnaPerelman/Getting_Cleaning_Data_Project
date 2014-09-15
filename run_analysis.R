#Reading training and test sets into R
setwd("C:/Users/Perelman/Desktop/Coursera/Data Science/Getting and Cleaning Data/CP/UCI HAR Dataset/train")
trainig_set<-read.table("X_train.txt",sep="")
setwd("C:/Users/Perelman/Desktop/Coursera/Data Science/Getting and Cleaning Data/CP/UCI HAR Dataset/test")
test_set<-read.table("X_test.txt",sep="")

#Q1: Merging the data sets into one named ttl_set
ttl_set<-rbind(trainig_set,test_set)

#Reading features.txt into R
setwd("C:/Users/Perelman/Desktop/Coursera/Data Science/Getting and Cleaning Data/CP/UCI HAR Dataset")
features<-read.table("features.txt",sep="",stringsAsFactors=FALSE)

#Building a vector containing numbers of columns,
#which refelct the measurements on the mean and standard deviation
#Assumption: all the variables listed in "features.txt" containing "mean"
#or "std" in their names are the measurements on the mean and standard deviation

mean_std_variables<-features[grepl("mean",features$V2)|grepl("std",features$V2),1]

#Q2: Subsetting these columns from the merged data set
mean_std_data<-ttl_set[,mean_std_variables]

#Reading labels info into R
setwd("C:/Users/Perelman/Desktop/Coursera/Data Science/Getting and Cleaning Data/CP/UCI HAR Dataset/train")
training_labels<-read.table("y_train.txt",sep="")
setwd("C:/Users/Perelman/Desktop/Coursera/Data Science/Getting and Cleaning Data/CP/UCI HAR Dataset/test")
test_labels<-read.table("y_test.txt",sep="")

#Merging these two vectors into one
ttl_labels<-rbind(training_labels,test_labels)

#Adding this a a new column to the extracted data set
mean_std_data$act_codes<-ttl_labels[,1]

#Reading activity labels info into R
setwd("C:/Users/Perelman/Desktop/Coursera/Data Science/Getting and Cleaning Data/CP/UCI HAR Dataset")
act_lbls<-read.table("activity_labels.txt",sep="",stringsAsFactors=FALSE)

#Creating a vector with the names of the activities
act_names<-character(length(ttl_labels$V1))
for(i in 1:length(ttl_labels$V1)){
        for(j in 1:length(act_lbls$V2)){
                if(ttl_labels[i,1]==act_lbls[j,1]){
                       act_names[i]<-act_lbls[j,2]
                }
        }
}

#Q3: Adding descriptive activity names to name the activities in the data set
mean_std_data$act_names<-act_names

#Creating a vector of all variables' names from features and added columns
mean_std_var_names<-features[grepl("mean",features$V2)|grepl("std",features$V2),2]
var_names<-c(mean_std_var_names,"act_codes","act_names")

#Q4: Labeling appropriately the data set with descriptive variable names
names(mean_std_data)=var_names

#Reading subject_train.txt into R
setwd("C:/Users/Perelman/Desktop/Coursera/Data Science/Getting and Cleaning Data/CP/UCI HAR Dataset/train")
train_subject<-read.table("subject_train.txt",sep="")

#Reading subject_text.txt into R
setwd("C:/Users/Perelman/Desktop/Coursera/Data Science/Getting and Cleaning Data/CP/UCI HAR Dataset/test")
test_subject<-read.table("subject_test.txt",sep="")

#Addind subject column to our extracted data set
ttl_subjects<-rbind(train_subject,test_subject)
mean_std_data$subjects<-ttl_subjects[,1]

#Groupping data by subjects and activities
grouped_mean_data<-mean_std_data %>% group_by(subjects,act_names,act_codes)

#Q5: Calculating mean by subject and activity for each variable 
#and creading new data set
mean_calc_grouped_mean_data<-grouped_mean_data %>% summarise_each(funs(mean))
final_data_set<-as.data.frame(mean_calc_grouped_mean_data)
write.table(final_data_set,file="Tidy data set.txt",row.names=FALSE)