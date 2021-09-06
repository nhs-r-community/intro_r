#Exercise 5: Database connections using DBI and and dplyr

#Load relevant packages, install them if you don't have them yet.
#install.packages("RSQLite")
library(DBI)
library(readr)
library(dplyr)
library(dbplyr)


#############################################################################
# Set up exercise database.  This will be held in memory, using RSQLite
# You would likely be connecting to SQL Server, Oracle or similar in reality
#############################################################################

# Load the tb_cases datasets
tb_cases<-read_csv("https://raw.githubusercontent.com/nhs-r-community/intro_r_data/main/tb_cases.csv")

# Set up the database connection
con <- dbConnect(RSQLite::SQLite(), ":memory:")

# Write tb_cases to the database
dbWriteTable(con, "tb_cases", tb_cases)

#Remove the imported data frame so we have to work on the database
rm(tb_cases)

############################################################################


# List the tables in our database. Use the 'Packages' window to view the functions in DBI.
# Look through the list and see if you can find something that looks relevant.
# Apply the function you chose to the connection we set up above: con


# You should have seen a single table called 'tb_cases'.
# List the fields in the 'tb_cases' table, again, using the relevant DBI function
# Check the help again to find it.


# Use DBI to send an SQL query to the database that lists all the rows in tb_cases table:
# 'Select count(*) from tb_cases'



# Now let's declare 'tb_cases', on 'con', as a tibble, so now we can use dplyr.
# Call it 'cases' to avoid confusion
# This will now be treated as an R data.frame/tibble, but it is still in the database.
cases <- 
  
# Use the glimpse() function to see the structure and data tapes.

  

# Use dplyr to count the rows in the table with with 'summarise(n())' or 'count()'.



# Filter for the year 2001, and find the average number of cases using summarise.



# Finally, calculate the average cases, per-country over all years.
# What additional function would you need?

  
  