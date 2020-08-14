#Descargar Archivo1
setwd("/Users/gloriacarolina/Documentos/COUSERA/DATES SCIENCE/datasciencecoursera/MODULO 3")
destino1 <- "/Users/gloriacarolina/Documentos/COUSERA/DATES SCIENCE/datasciencecoursera/MODULO 3/Proyecto.zip"
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl1, destfile = destino1, method = "curl")
unzip("Proyecto.zip")

#Para leer todas las tablas.
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","features"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$features)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$features)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#1. Merges the training and the test sets to create one data set.
Vab_X <- rbind(x_train, x_test) #Une las tablas x
Vab_Y <- rbind(y_train, y_test) #Une las tablas x
Subject <- rbind(subject_train, subject_test) #Une las tablas subject
Table_Final <- cbind(Subject, Vab_X, Vab_Y)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
library(dplyr)
Table_Final <-select(Table_Final, subject, code, contains("mean"), contains("std"))#Consulto los datos que tengan mean y std

#3. Uses descriptive activity names to name the activities in the data set
Table_Final$code <- activities[Table_Final$code, 2]

#4. Appropriately labels the data set with descriptive variable names.
names(Table_Final)[2] = "activity"
names(Table_Final)<-gsub("Acc", "Accelerometer", names(Table_Final))
names(Table_Final)<-gsub("Gyro", "Gyroscope", names(Table_Final))
names(Table_Final)<-gsub("BodyBody", "Body", names(Table_Final))
names(Table_Final)<-gsub("Mag", "Magnitude", names(Table_Final))
names(Table_Final)<-gsub("^t", "Time", names(Table_Final))
names(Table_Final)<-gsub("^f", "Frequency", names(Table_Final))
names(Table_Final)<-gsub("tBody", "TimeBody", names(Table_Final))
names(Table_Final)<-gsub("-mean()", "Mean", names(Table_Final), ignore.case = TRUE) #ignore.case ignora la diferencia de mayusculas y minusculas.
names(Table_Final)<-gsub("-std()", "STD", names(Table_Final), ignore.case = TRUE)
names(Table_Final)<-gsub("-freq()", "Frequency", names(Table_Final), ignore.case = TRUE)
names(Table_Final)<-gsub("angle", "Angle", names(Table_Final))
names(Table_Final)<-gsub("gravity", "Gravity", names(Table_Final))

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
test1 <- group_by(Table_Final, subject, activity)  #Agrupa la tabla de acuerdo a las variables seleccionadas
averages <- summarise_all(test1, list(mean)) #Organiza en un solo valor (mean) los datos de mismo grupo
write.table(averages, "averages.txt", row.name=FALSE) #Para convertirlo en texto
