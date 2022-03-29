## CLEAN AND PREPARE DATA ##
# The purpose of this script is to clean the raw data output
# Prerequisite: run 01-gather_data.R and have the outputted raw_data.csv file saved

library(tidyverse)

raw_data <- read_csv("inputs/data/raw_data.csv")

raw_data <- raw_data[-c(1:15, 54:77, 110:114), ] # delete unnecessary rows

colnames(raw_data) <- c("x")

# get rid of extra spaces leaving a single space
raw_data <- raw_data |>
  mutate(x=str_squish(x))

# obtain the datapoints to fill a 26x12 matrix
mat <- matrix(rep(0, 312), nrow=26, byrow=TRUE)
counter = 1

for (i in 1:38) {
  
  numbers <- strsplit(raw_data$x[i], " ")[[1]] # get numbers for this row
  
  if (length(numbers) >= 13) {
    
    for (j in 1:length(numbers)) {
      numbers[j] <- str_replace(numbers[j][1], "-", ".") # fix all - into decimal points .
      numbers[j] <- str_replace(numbers[j][1], "_", ".") # fix all - into decimal points .
      numbers[j] <- str_replace(numbers[j][1], " .", ".") # fix all ' '. into decimal points .
    }
    
    # take in the numbers but start from the back and move forward, until we have 12
    # this avoids the problem of states being in two indices at the front because of their spaces
    numbers <- rev(numbers) # reverse the numbers (hit it from behind)
    numbers <- numbers[1:12] # first 12 are never names/non-numeric (take what we want)
    numbers <- rev(as.numeric(numbers)) # now we have the row values in correct order too (turn it back around)
    
    mat[counter, ] <- numbers # add numbers as a row of mat
    counter <- counter + 1
  }
  # otherwise we reject this row because it was missing data or not a row we care about
}

# obtain the datapoints to fill a 26x11 matrix
mat2 <- matrix(rep(0, 286), nrow=26, byrow=TRUE)
counter = 1

# now for page 2
for (i in 39:70) {
  
  numbers <- strsplit(raw_data$x[i], " ")[[1]] # get numbers for this row
  
  if (length(numbers) >= 12) {
    
    for (j in 1:length(numbers)) {
      numbers[j] <- str_replace(numbers[j][1], "-", ".") # fix all - into decimal points .
      numbers[j] <- str_replace(numbers[j][1], "_", ".") # fix all - into decimal points .
      numbers[j] <- str_replace(numbers[j][1], " .", ".") # fix all ' '. into decimal points .
    }
    
    # take in the numbers but start from the back and move forward, until we have 11 (because we dont want state again)
    # this avoids the problem of states being in two indices at the front because of their spaces
    numbers <- rev(numbers) # reverse the numbers (hit it from behind)
    numbers <- numbers[1:11] # first 11 are never names/non-numeric (take what we want)
    numbers <- rev(as.numeric(numbers)) # now we have the row values in correct order too (turn it back around)
    
    mat2[counter, ] <- numbers
    counter <- counter + 1
  }
  # otherwise we reject this row because it was missing data or not a row we care about
}

# merge the two matrices 
big_mat <- cbind(mat, mat2)

column_names <- c(1:23) # TODO: Put the column names here (omit state)
state_names <- c(1:26) # TODO: Put the state names here

# after cleaning, construct the final data frame
final_df <- data.frame(big_mat)
colnames(final_df) <- column_names
final_df$states <- state_names

# save it to a csv file so we only need to run this script once at the beginning of our journey
write.csv(final_df, "inputs/data/cleaned_data.csv", row.names=FALSE)


## END OF SCRIPT ##