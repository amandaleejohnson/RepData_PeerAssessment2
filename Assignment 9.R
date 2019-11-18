###Assignment 9


setwd("C:/Users/ajohns34/Box/Data Science Specialization/Assignment 9")

#Checking for and creating directories
# file.exists("directoryname") - looks to see if the directory exists - T/F
# dir.create("directoryname") - creates a directory if it doesn't exist

#If the directory doesn't exist, make a new one:
if(!file.exists("data")) {
        dir.create("data")
}

#####################################################################
# Background
#####################################################################

# Storms and other severe weather events can cause both public health and economic problems for 
# communities and municipalities. Many severe events can result in fatalities, injuries, and property damage,
# and preventing such outcomes to the extent possible is a key concern.
# 
# This project involves exploring the U.S. National Oceanic and Atmospheric Administration's (NOAA) storm database. 
# This database tracks characteristics of major storms and weather events in the United States, including when 
# and where they occur, as well as estimates of any fatalities, injuries, and property damage.

#####################################################################
# Data
#####################################################################

# The data for this assignment come in the form of a comma-separated-value file compressed via the bzip2 algorithm to reduce its size. 
        # You can download the file from the course web site.
        #         

# There is also some documentation of the database available. Here you will find how some of the variables are constructed/defined.
        # 
        # National Weather Service Storm Data Documentation
        # National Climatic Data Center Storm Events FAQ

# The events in the database start in the year 1950 and end in November 2011. 
# In the earlier years of the database there are generally fewer events recorded, most likely due to a lack of good records. 
# More recent years should be considered more complete.


#####################################################################
# Assignment
#####################################################################
# The basic goal of this assignment is to explore the NOAA Storm Database and answer some basic questions about severe weather events. 
# You must use the database to answer the questions below and show the code for your entire analysis. 
# Your analysis can consist of tables, figures, or other summaries. You may use any R package you want to support your analysis.

# Questions
# 
        # Your data analysis must address the following questions:
        #         Across the United States, which types of events (as indicated in the EVTYPE variable) are most harmful with respect 
                        #to population health?
        #         Across the United States, which types of events have the greatest economic consequences?
        #         
        # Consider writing your report as if it were to be read by a government or municipal manager who might be responsible for preparing 
        # for severe weather events and will need to prioritize resources for different types of events. 
        # However, there is no need to make any specific recommendations in your report.

# Requirements
# 
        # For this assignment you will need some specific tools
        # 
        # RStudio: You will need RStudio to publish your completed analysis document to RPubs. You can also use RStudio to edit/write your analysis.
        # knitr: You will need the knitr package in order to compile your R Markdown document and convert it to HTML
        # 
# Document Layout
# 
        # Language: Your document should be written in English.
        # Title: Your document should have a title that briefly summarizes your data analysis
        # Synopsis: Immediately after the title, there should be a synopsis which describes and summarizes your analysis in 
                # at most 10 complete sentences.
        # There should be a section titled Data Processing which describes (in words and code) how the data were loaded into R 
                # and processed for analysis. In particular, your analysis must start from the raw CSV file containing the data. 
                # You cannot do any preprocessing outside the document. If preprocessing is time-consuming you may consider using 
                # the cache = TRUE option for certain code chunks.
        # There should be a section titled Results in which your results are presented.
        # You may have other sections in your analysis, but Data Processing and Results are required.
        # The analysis document must have at least one figure containing a plot.
        # Your analysis must have no more than three figures. Figures may have multiple plots in them (i.e. panel plots), 
                # but there cannot be more than three figures total.
        # You must show all your code for the work in your analysis document. This may make the document a bit verbose, but that is okay. 
                # In general, you should ensure that echo = TRUE for every code chunk (this is the default setting in knitr).
        
# Submitting Your Assignment
# 
# In order to submit this assignment, you must copy the RPubs URL for your completed data analysis document in to the peer assessment question.
# If you choose to submit as a PDF, please insert an obvious placeholder URL (e.g. https://google.com) in order to allow submission.        

#####################################################################
# Review criteria
#####################################################################

# Has either a (1) valid RPubs URL pointing to a data analysis document for this assignment been submitted; 
        #or (2) a complete PDF file presenting the data analysis been uploaded?

# Is the document written in English?

# Does the analysis include description and justification for any data transformations?

# Does the document have a title that briefly summarizes the data analysis?

# Does the document have a synopsis that describes and summarizes the data analysis in less than 10 sentences?

# Is there a section titled "Data Processing" that describes how the data were loaded into R and processed for analysis?

# Is there a section titled "Results" where the main results are presented?

# Is there at least one figure in the document that contains a plot?

# Are there at most 3 figures in this document?

# Does the analysis start from the raw data file (i.e. the original .csv.bz2 file)?

# Does the analysis address the question of which types of events are most harmful to population health?

# Does the analysis address the question of which types of events have the greatest economic consequences?

# Do all the results of the analysis (i.e. figures, tables, numerical summaries) appear to be reproducible?

# Do the figure(s) have descriptive captions (i.e. there is a description near the figure of what is happening in the figure)?

# As far as you can determine, does it appear that the work submitted for this project is the work of the student who submitted it?

#####################################################################
# Publishing your Analysis
#####################################################################

# For this assignment you will need to publish your analysis on RPubs.com. 
# If you do not already have an account, then you will have to create a new account. 
# After you have completed writing your analysis in RStudio, you can publish it to RPubs by doing the following:
# 
        # In RStudio, make sure your R Markdown document (.Rmd\color{red}{\verb|.Rmd|}.Rmd) document is loaded in the editor
        # Click the Knit HTML\color{red}{\verb|Knit HTML|}KnitHTML button in the doc toolbar to preview your document.
        # In the preview window, click the Publish\color{red}{\verb|Publish|}Publish button.
# 
# Once your document is published to RPubs, you should get a unique URL to that document. 
# Make a note of this URL as you will need it to submit your assignment.
# 
# NOTE: If you are having trouble connecting with RPubs due to proxy-related or other issues, 
# you can upload your final analysis document file as a PDF to Coursera instead.


#####################################################################
# Data Processing - Loading the data, creating a subset df
#####################################################################
#Source for cleaning process: https://www.coursera.org/learn/reproducible-research/discussions/weeks/4/threads/38y35MMiEeiERhLphT2-QA

library(R.utils)
library(rmarkdown)
library(knitr)
library(tidyverse)
Sys.setlocale("LC_TIME", "English")

#Read in the data:
        temp <- tempfile()
##Do the download once
        if(!file.exists("/stormData.csv.bz2")){
                download.file("https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", destfile="./stormData.csv.bz2")
        }
                            
##Uncompress the file once
        if(!file.exists("stormdata.csv"))
        {
                bunzip2("stormData.csv.bz2","stormdata.csv",remove=F)
        }

##Load the data
        storm <- read.csv("stormdata.csv",header=TRUE,sep=",")
        head(storm)
        
#Only keep a subset of the variables we are interested in for the project:        
        variables = c("EVTYPE","FATALITIES","INJURIES","PROPDMG", "PROPDMGEXP","CROPDMG","CROPDMGEXP")
        storm_subset = storm[variables]

#Explore the event types
        str(storm_subset$EVTYPE)
        table(storm_subset$EVTYPE)
        #We should only have n=48 different events, but we have over 1,000!
        #Come back to this later if I have time
        
#Assuming all the event types are truly unique, What are the most common event types?
        sort(table(storm_subset$EVTYPE), decreasing = TRUE)

######################################################################
# POPULATION HEALTH
######################################################################
        ##Aggregate the # of fatalities by event type and sort the output in descending order
                #Make a mini-table of the total number of fatalities by event type:
                num_fatalities = aggregate(FATALITIES~EVTYPE,data=storm_subset,FUN=sum,na.rm=TRUE)
                #Put in descending order:
                num_fatalities = num_fatalities[order(-num_fatalities$FATALITIES),] 
                #Only list the ten most fatal event types:
                num_fatalities = head(num_fatalities,10)
                print(num_fatalities)
        
                #Create a new column that is a rank of 1-10:
                num_fatalities = tibble::rowid_to_column(num_fatalities, "rank_fat")
                
                
        ##Aggregate the # of injuries by event type and sort the output in descending order
                #Make a mini-table of the number of injuries by event type:
                num_injuries = aggregate(INJURIES~EVTYPE,data=storm_subset,FUN=sum,na.rm=TRUE)
                #Put in descending order:
                num_injuries = num_injuries[order(-num_injuries$INJURIES),]
                #Only list the ten most injuries event types:
                num_injuries = head(num_injuries,10)
                print(num_injuries)
                
                #Create a new column that is a rank of 1-10:
                num_injuries = tibble::rowid_to_column(num_injuries, "rank_inj")
                
                
        ##Make figures comparing the top 10 events that lead to the greatest number
                #of fatalities and injuries
                library(ggplot2)
                #Make barplots for each type of harm (fatalities and injuries)
                #Then, plot them side by side using the gridExtra package
                #install.packages("gridExtra")
                library(gridExtra)
                
                #Reorder the bars so they will present in descending order:
                num_fatalities$EVTYPE = factor(num_fatalities$EVTYPE, levels = num_fatalities$EVTYPE[order(-num_fatalities$FATALITIES)])
                
                fat_bp = ggplot(data=num_fatalities, aes(x = EVTYPE, y = FATALITIES)) +
                        geom_bar(stat="identity") +
                        labs(title = "Top 10 Events - Deaths", caption = "From 1950 to 2011") +
                        labs(x = "Event Type", y = "Number of Fatalities") +
                        theme(axis.text.x = element_text(size = 7, angle = 45)) + 
                        geom_text(aes(label=FATALITIES), vjust=-0.3, size=3.5)

                #Reorder the bars so they will present in descending order:
                num_injuries$EVTYPE = factor(num_injuries$EVTYPE, levels = num_injuries$EVTYPE[order(-num_injuries$INJURIES)])
                
                inj_bp = ggplot(data=num_injuries, aes(x = EVTYPE, y = INJURIES)) +
                        geom_bar(stat="identity") +
                        labs(title = "Top 10 Events - Injuries", caption = "From 1950 to 2011") +
                        labs(x = "Event Type", y = "Number of Injuries (Excluding Fatalities)") +
                        theme(axis.text.x = element_text(size = 7, angle = 45)) + 
                        geom_text(aes(label=INJURIES), vjust=-0.3, size=3.5)
                
                #This plots the figures side by side:
                grid.arrange(fat_bp, inj_bp, nrow = 1)
                
        
                
######################################################################
# ECONOMIC IMPACT
######################################################################

#Explore the data:                
        str(storm_subset$PROPDMG)
        str(storm_subset$PROPDMGEXP)        

        unique(storm_subset$PROPDMGEXP)
        sort(table(storm_subset$PROPDMGEXP), decreasing = TRUE)       
                #N = 465934 have blank value
                #N = 424665 have K value, corresponding to 1,000
                #N = 11330 have M value, corresponding to 1,000,000 value
                #N = 216 have 0 value, corresponding to no(?) value
                #N = 40 have B value, corresponding to 1,000,000,000 value 
                #etc.
        
        unique(storm_subset$CROPDMGEXP)
        sort(table(storm_subset$CROPDMGEXP), decreasing = TRUE)       
        
##convert the exponents into numeric value and thus calculate the property damage / crop damage
#Source: https://rstudio-pubs-static.s3.amazonaws.com/58957_37b6723ee52b455990e149edde45e5b6.html

        ##PROP DAMAGE##
                #Billions:
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "B"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "B"] * (10^9)
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "b"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "b"] * (10^9)
                #Millions:
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "M"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "M"] * (10^6)
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "m"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "m"] * (10^6)
                #Thousands:
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "K"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "K"] * 1000
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "k"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "k"] * 1000
                #Hundreds:
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "H"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "H"] * 100        
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "h"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "h"] * 100
        
                #Other exponentiated:
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "0"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "0"] * 10
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "1"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "1"] * 10
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "2"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "2"] * 10
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "3"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "3"] * 10
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "4"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "4"] * 10
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "5"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "5"] * 10
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "6"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "6"] * 10
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "7"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "7"] * 10
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "8"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "8"] * 10
                
                #Other symbols:
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "+"] = storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "+"] * 1
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "-"] = 0
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == "?"] = 0
                storm_subset$PROPDMG[storm_subset$PROPDMGEXP == ""] = 0
                
        ##CROP DAMAGE##
                #Billions:
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "B"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "B"] * (10^9)
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "b"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "b"] * (10^9)
                #Millions:
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "M"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "M"] * (10^6)
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "m"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "m"] * (10^6)
                #Thousands:
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "K"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "K"] * 1000
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "k"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "k"] * 1000
                #Hundreds:
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "H"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "H"] * 100        
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "h"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "h"] * 100
                
                #Other exponentiated:
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "0"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "0"] * 10
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "1"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "1"] * 10
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "2"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "2"] * 10
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "3"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "3"] * 10
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "4"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "4"] * 10
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "5"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "5"] * 10
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "6"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "6"] * 10
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "7"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "7"] * 10
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "8"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "8"] * 10
                
                #Other symbols:
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "+"] = storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "+"] * 1
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "-"] = 0
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == "?"] = 0
                storm_subset$CROPDMG[storm_subset$CROPDMGEXP == ""] = 0
                
#Another way to do the above: 
                # dmgexp_vector<-c("K"=1000,"M"=10^6,"m"=10^6,"+"=1,"0"=1,"5"=10^5,"6"=10^6,"?"=1,"4"=10^4,"2"=10^2,"3"=10^3,"h"=100,"7"=10^7,"H"=100,"-"=1,"1"=10,"8"=10^8,"B"=10^9,"k"=1000)
                # 
                # storm_subset[is.na(PROPDMGEXP),PROPDMGEXP:="1"]
                # storm_subset[is.na(CROPDMGEXP),CROPDMGEXP:="1"]
                # storm_subset[CROPDMGEXP=="",CROPDMGEXP:="1"]
                # storm_subset[PROPDMGEXP=="",PROPDMGEXP:="1"]
                # 
                # storm_subset[,propertycost:=PROPDMG*dmgexp_vector[PROPDMGEXP]]
                # storm_subset[,cropcost:=CROPDMG*dmgexp_vector[CROPDMGEXP]]
                
                
                
                
##Aggregate property damage by event type and sort the output it in descending order
        #Make a mini-table of the amount of property damage by event type:
        num_prop = aggregate(PROPDMG~EVTYPE, data = storm_subset, FUN = sum, na.rm = TRUE)
        #Put in descending order:
        num_prop = num_prop[order(-num_prop$PROPDMG),]
        #Only list the ten most damaging event types:
        num_prop = head(num_prop,10)
        print(num_prop)

##Aggregate CROPerty damage by event type and sort the output it in descending order
        #Make a mini-table of the amount of crop damage by event type:
        num_CROP = aggregate(CROPDMG~EVTYPE, data = storm_subset, FUN = sum, na.rm = TRUE)
        #Put in descending order:
        num_CROP = num_CROP[order(-num_CROP$CROPDMG),]
        #Only list the ten most damaging event types:
        num_CROP = head(num_CROP,10)
        print(num_CROP)
        
        
##Make figures comparing the top 10 events that lead to the largest amount 
#of property and crop damage
        #Make barplots for each type of damage (property and crop)
        #Then, plot them side by side using the gridExtra package
        
        #Reorder the bars so they will present in descending order:
        num_prop$EVTYPE = factor(num_prop$EVTYPE, levels = num_prop$EVTYPE[order(-num_prop$PROPDMG)])
        
        prop_bp = ggplot(data=num_prop, aes(x = EVTYPE, y = round(PROPDMG/10^9, 2))) +
                geom_bar(stat="identity") +
                labs(title = "Top 10 Events - Property Damage", caption = "From 1950 to 2011") +
                labs(x = "Event Type", y = "Amount of Property Damage (in Billions of USD)") +
                theme(axis.text.x = element_text(size = 7, angle = 45)) + 
                geom_text(aes(label=round(PROPDMG/10^9, 2)), vjust=-0.3, size=3.5)
        prop_bp
        #Reorder the bars so they will present in descending order:
        num_CROP$EVTYPE = factor(num_CROP$EVTYPE, levels = num_CROP$EVTYPE[order(-num_CROP$CROPDMG)])
        
        crop_bp = ggplot(data=num_CROP, aes(x = EVTYPE, y = round(CROPDMG/10^9, 2))) +
                geom_bar(stat="identity") +
                labs(title = "Top 10 Events - Crop Damage", caption = "From 1950 to 2011") +
                labs(x = "Event Type", y = "Amount of Crop Damage (in Billions of USD)") +
                theme(axis.text.x = element_text(size = 7, angle = 45)) + 
                geom_text(aes(label=round(CROPDMG/10^9, 2)), vjust=-0.3, size=3.5)
        
        #This plots the figures side by side:
        grid.arrange(prop_bp, crop_bp, nrow = 1)


        