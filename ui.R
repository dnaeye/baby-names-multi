# ui.R
# Author: dnaeye (https://github.com/dnaeye)
# Version: 1.0
# Created: 8/18/2014
# This is a simple user interface for comparing the historical popularity
# of up to five baby names.

library(shiny)

shinyUI(fluidPage(
    titlePanel("Baby Names"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("Compare the popularity of names
                     over the years.",
                     br(),
                     br(),
                     "Source:",
                     a("Social Security Administration",
                       href="http://www.ssa.gov/oact/babynames/")),
            
            # Default user-inputted names set to Brady Brunch dad & boys
            textInput("name1", "Name 1", "Michael"),
            textInput("name2", "Name 2", "Gregory"),
            textInput("name3", "Name 3", "Peter"),
            textInput("name4", "Name 4", "Bobby"),
            textInput("name5", "Name 5", "Oliver"),
            
# Input widget for selecting top 5/10 baby names instead of inputting specific names
# However, it does not work correctly
#             selectInput("topnames", label="Top Names",
#                         choices=c("",5,10),
#                         selected=NULL),

            # Although there are names for which there are both boys and girls,
            # to simplify this app, user must choose to compare all "boy" or all "girl"
            # names.
            selectInput("gender", label="Gender",
                        choices=c("boy","girl"),
                        selected="boy"),       
            sliderInput("years",
                        "Year Range",
                        min=1880,
                        max=2008,
                        value=c(1880, 2008),
                        step=10,
                        format="####")
            ),
        
        mainPanel(plotOutput("plot"))
        )
    ))
