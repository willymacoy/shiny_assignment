library(shiny)


count = 1
shinyServer(
    function(input, output) {
        
        df_onecut <- eventReactive(input$radioCut, diamonds[diamonds$cut == input$radioCut,])
        fit <- eventReactive(input$radioCut, lm(price ~ carat, data = df_onecut()))
        
        output$text2 <- renderText({
            if(!is.null(input$radioCut)) {
                p <- predict(fit(), newdata = data.frame(carat = input$slider2))
                narrate <- paste("The predicted price for diamonds of weight ", 
                                 input$slider2, " carats and ", input$radioCut, " cut is: $", as.integer(p))
                narrate
            }
            
        })
        
        observe({
            input$radioCut
            onecut <- df_onecut()
            if(!is.null(input$radioCut)) {
                
                output$sliderWeight <- renderUI({
                    sliderInput("slider2",label="",
                                min(onecut$carat),
                                max(onecut$carat),
                                mean(c(min(onecut$carat), max(onecut$carat)))
                    )})
                
                output$plot_lm = renderPlot({
                    plot(y = onecut$price, 
                         x = onecut$carat,
                         ylab = "Diamond Price",
                         xlab = "Diamond Weight (carats)",
                         main = paste("Diamond Price v Weight (for ", input$radioCut, " cut)")
                    )
                    
                    abline(fit(), col = "red")
                    
                })
            }
        })
        renderUI({})
        
    }
)
