In the first part of the script, I downloaded the .zip file and then I unziped it.

I load in R every txt file with a new name using the read.table command.

To merge the tables I used the rbind command, and cbind command to generate a final dataset named Table_Final.

For the 2nd point I used select() function with the library dplyr.

For the 3rd point I changed the values of the code column searching this code in the table named activities.

For the 4th point I used gsub to find the acronimes and then changed it with their descriptive names.

Finally for the 5th point I group the information in "Table_Final", by subject and activity, and then I use summarise_all() function to calculate the mean of each column
