# server.R
# Author: dnaeye (https://github.com/dnaeye)
# Version: 1.0
# Created: 8/18/2014
# This is the backend Shiny server code for processing user input from
# the ui.R interface. The server creates subsets of the main baby-names.csv dataset
# based on the baby name(s) and date range chosen by the user.

names <- read.csv("baby-names.csv")
library(ggplot2)

shinyServer(function(input, output) {
    
    output$plot <- renderPlot({
        
        gender <- input$gender
        start <- input$years[1]
        end <- input$years[2]
        
        # set tick marks for time (x-axis) for useability
        if (end-start>30){
            tick <- 10
        } else if (end-start<=30){
            tick <- 5
        } else if (end-start<=10){
            tick <- 1
        }

# server-side processing of topnames input widget
# disabled because it does not work correctly
#         if (!is.null(input$topnames)){
#             dt <- subset(names, sex==gender & year>=1970 & year<=2008)
#             top <- tapply(dt$percent, dt$name, mean)
#             fname <- names(head(sort(top, decreasing=T),input$topnames))
#         } else { fname <- c(input$name1, input$name2, input$name3, input$name4, input$name5) }

        # vector of user-inputted names; for some reason, it can handle 
        # invalid names and null values despite lack of explicit error handling
        fname <- c(input$name1, input$name2, input$name3, input$name4, input$name5)
        
        # create list of relevant datasets based on user-inputted names
        li <- list()
        for (j in 1:length(fname)){
            li[[j]] <- subset(names, name==fname[j] & sex==gender & year>=start & year<=end)
        }
        
        # merge datasets into one dataframe
        df <- data.frame()
        for (j in 1:length(li)) {
            df <- rbind(df,li[[j]])
        }
        
        # line chart of names' historical popularity trends
        ggplot(data=df, aes(x=year, y=percent, color=name)) +
            geom_line() +
            xlab("Years") + ylab("Popularity") +
            scale_x_continuous(breaks=seq(start, end, tick))    
    })
    
})
