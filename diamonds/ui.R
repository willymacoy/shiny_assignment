library(ggplot2)


shinyUI(
    
    pageWithSidebar(
        headerPanel("Diamond Prices"),
        sidebarPanel(
            h3("How to use this app:"),
            h4("1. Choose your diamond cut"),
            p("This will create a linear model of diamond prices for that cut"),
            p("It will then create a scatter plot of the values, overlaid with a line representing the linear model (in red)"),
            radioButtons("radioCut", label = "Cut",
                         choices = levels(diamonds$cut),
                         selected = ""
            ),
            h4("2. Choose a diamond weight"),
            p("This will give you a prediction of diamond price for that weight and cut"),
            p("Note: Slider will appear after choosing weight"),
            uiOutput("sliderWeight")
        ),
        mainPanel(
            textOutput("text1"),
            plotOutput("plot_lm"),
            textOutput("text2")
        )
    ))
