shinyServer(function(input, output, session) {
        # input$file1 will be NULL initially. After the user selects and uploads a 
        # file, it will be a data frame with 'name', 'size', 'type', and 'datapath' 
        # columns. The 'datapath' column will contain the local filenames where the 
        # data can be found.
        observe({
                inFile <- input$file1
                if (is.null(inFile))
                        return()
                dataren <- read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)  
     
                updateSelectInput(session, "variable1", choices = colnames(dataren))
                
                updateSelectInput(session, "variable2", choices = colnames(dataren))
        })
        
        formulaText <- reactive({
                paste("Chi square test of", input$variable1, "and", input$variable2)
        })
        
        output$caption <- renderText({
        formulaText()
        })
        
        output$contents <- renderTable({
                inFile <- input$file1
                if (is.null(inFile))
                        return()
                dataren <- read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)  
                
                dataren[1:5,]
        })
        
       
        output$ct <- renderPrint({
                validate(
                        need(input$variable1!= "", 'No file selected')
                )
                inFile <- input$file1
                if (is.null(inFile))
                        return()
                dataren <- read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote) 
                options(warn=-1)
                table(dataren[,input$variable1], dataren[,input$variable2])
        })        
        
       
        output$test <- renderPrint({
                validate(
                        need(input$variable1!= "", 'No file selected')
                )
                inFile <- input$file1
                if (is.null(inFile))
                        return()
                
                dataren <- read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote) 
                data<-cbind(dataren[,input$variable1], dataren[,input$variable2])
                options(warn=-1)
                chisq.test(data)
        })       
        
       output$plot <- renderPlot({
               validate(
                       need(input$variable1!= "", 'No file selected')
               )
               inFile <- input$file1
               if (is.null(inFile))
                       return()
               dataren <- read.csv(inFile$datapath, header=input$header, sep=input$sep, quote=input$quote)  
               
               tabla<-table(dataren[,input$variable1], dataren[,input$variable2])
               
               barplot(tabla, main=paste(input$variable1, "and", input$variable2),
                xlab=input$variable1,col= terrain.colors(length(rownames(tabla))),        
               legend = rownames(tabla), beside=TRUE)
       })
        
})
