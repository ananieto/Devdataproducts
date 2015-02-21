shinyUI(fluidPage(
        headerPanel("Chi-Square Test"),
        h3("How to use this app"),
        p("This app has the aim of performing a chi-square test of two variables
                from a dataset introduced by the user. \n The user must select a
                dataset in csv format and choose the options to permit the app 
                properly read the file. Once this action has been executed, the 
                user must select two variables from the listboxes at the bottom. \n 
                With these variables, the app performs a chi-square test and shows
                 the contingency table of the two variables, the results of the 
                chi-square test, a barplot showing the distribution of the values 
                of the variables and the first five lines of the dataset."),
        sidebarPanel(
                fileInput('file1', 'Choose CSV File',
                          accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')),
                tags$hr(),
                checkboxInput('header', 'Header', TRUE),
                options(warn=-1),
                radioButtons('sep', 'Separator',
                             c('Comma'=',',
                               'Semicolon'=';',
                               'Tab'='\t'),
                             'Comma'),
                radioButtons('quote', 'Quote',
                             c(None='',
                               'Double Quote'='"',
                               'Single Quote'="'"),
                             'Double Quote'),
                selectInput("variable1", "Variable 1:",
                            list()),
                selectInput("variable2", "Variable 2:",
                            choices=list())
        ),
        mainPanel(
                h2(textOutput('caption')),
                
                h2('Contingency Table'),
                verbatimTextOutput('ct'),
                h2('Chi Square Test'),
                verbatimTextOutput('test'),
                h2('Barplot'),
                plotOutput('plot'),
                h2('Data'),
                tableOutput('contents')
        )
))
