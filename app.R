####################################
# Authors: Colleague 1             #
#          Dhruva Reddy            #
####################################

# Load packages
library(shiny)
library(bslib)
source("./global.R")

# Defining UI
ui <- fluidPage(theme = bs_theme(bootswatch = "darkly"),
                #define the layout for each page with sidebar on the left and main content on the right
                tags$style("
                         .sidebar {
                          position: fixed;
                          top: 50px;
                          bottom: 0;
                          width: 250px;
                          padding: 20px;
                          overflow-y: auto;
                         }
                          
                        .main {
                          margin-left: 250px;
                          padding: 20px;
                        }
                        
                        @media (max-width: 768px) {
                            .sidebar {
                              position: static;
                              width: auto;
                              padding: 0;
                              overflow-y: visible;
                            }
                            
                            .main {
                              margin-left: 0;
                            }
                          }"
                ),
                navbarPage(
                  "Index Returns Dashboard",
                  tabPanel("Correlation of Indexes",
                         sidebarLayout(
                           sidebarPanel(
                             id = "sidebar",
                             tags$h3("Display Rolling Correlation of selected Indexes & Correlation Heatmap of all Indexes"),
                             tags$h4("Input:"),
                             dateRangeInput("corrrange", "Date Range",
                                            start = "2016-01-01",
                                            end = "2021-04-02",
                                            min = "2016-01-01",
                                            max = "2021-04-02",
                                            format = "yyyy/mm/dd",
                                            separator = "to"),
                             sliderInput(inputId = "duration",
                                         label = "Width of Rolling Correlation",
                                         min = 3,
                                         max = 52,
                                         value = 27),
                             selectInput("corrvar1", "First Index:",
                                         choices = names(source_file[2:(length(source_file) - 1)])),
                             selectInput("corrvar2", "Second Index:",
                                         choices = names(source_file[2:(length(source_file) - 1)])),
                           ),
                           mainPanel(
                             id = "main",
                             plotOutput(outputId = "roll_corr_plot"),
                             plotOutput(outputId = "corr_heat_plot"),
                           )
                         ),
                         position = "left",
                     ),
                           
                  
                  tabPanel("Weekly Cumulative Returns",
                       sidebarLayout(
                         sidebarPanel(
                           id="sidebar",
                           tags$h3("Display Weekly Cumulative Returns of selected Index"),
                           tags$h4("Input:"),
                           dateRangeInput("cumrange", "Date Range",
                                          start = "2016-01-01",
                                          end = "2021-04-02",
                                          min = "2016-01-01",
                                          max = "2021-04-02",
                                          format = "yyyy/mm/dd",
                                          separator = "to"),
                           selectInput("cumvar", "Index",
                                       choices= names(source_file[2:(length(source_file-1))])),
                         ), #sidebarpanel
                             
                         mainPanel(
                           id="main",
                           plotOutput(outputId = "cum_return_plot"),
                           textOutput(outputId = "cum_stats")
                         ), #mainPanel
                       )
                           
                  ), #tabpanel
                  
                  tabPanel("Distribution of Returns",
                       sidebarLayout(
                         sidebarPanel(
                           id="sidebar",
                           tags$h3("Display Distribution of Returns of selected Index"),
                           tags$h4("Input:"),
                           dateRangeInput("distrange", "Date Range",
                                          start = "2016-01-01",
                                          end = "2021-04-02",
                                          min = "2016-01-01",
                                          max = "2021-04-02",
                                          format = "yyyy/mm/dd",
                                          separator = "to"),
                           selectInput("distvar", "Index",
                                       choices= names(source_file[2:(length(source_file-1))])),
                         ), #sidebarpanel
                         mainPanel(
                           id="main",
                           plotOutput(outputId = "plot_dist"),
                         ), #mainPanel   
                       )
                  ), #tabpanel
                  
                  tabPanel("Drawdowns",
                        sidebarLayout(
                          sidebarPanel(
                            id="sidebar",
                            tags$h3("Input:"),
                            dateRangeInput("drawrange", "Date range",
                                           start = "2016-01-01",
                                           end = "2021-04-02",
                                           min = "2016-01-01",
                                           max = "2021-04-02",
                                           format = "yyyy/mm/dd",
                                           separator = "to"),
                            selectInput("drawvar1", "First Index",
                                        choices= names(source_file[2:(length(source_file)-1)])),
                            selectInput("drawvar2", "Second Index",
                                        choices= names(source_file[2:(length(source_file)-1)])),
                          ), #sidebarpanel
                          mainPanel(
                            id="main",
                            plotOutput(outputId = "drawrangeplot"),
                          ), #mainPanel
                        )
                           
                  ), #tabpanel
                  
                  tabPanel("Custom Portfolio by Weight",
                          sidebarLayout(
                            sidebarPanel(
                              id="sidebar",
                              tags$h3("Create your own Custom Portfolio by Asset Weight"),
                              tags$h4("Input:"),
                              dateRangeInput("customrange", "Date Range",
                                             start = "2016-01-01",
                                             end = "2021-04-02",
                                             min = "2016-01-01",
                                             max = "2021-04-02",
                                             format = "yyyy/mm/dd",
                                             separator = "to"),
                              numericInput(inputId = "custom_csi500", "CSI500 (%)", value = 12, min = 0, max = 100),
                              numericInput(inputId = "custom_shanghai", "Shanghai Stock Exchange (%)", value = 8, min = 0, max = 100),
                              numericInput(inputId = "custom_csi300", "CSI300 (%)", value = 8, min = 0, max = 100),
                              numericInput(inputId = "custom_hsi", "HSI (%)", value = 8, min = 0, max = 100),
                              numericInput(inputId = "custom_sti", "STI (%)", value = 8, min = 0, max = 100),
                              numericInput(inputId = "custom_twse", "TWSE (%)", value = 8, min = 0, max = 100),
                              numericInput(inputId = "custom_msciw", "MSCI World (%)", value = 8, min = 0, max = 100),
                              numericInput(inputId = "custom_sp500", "S&P500 (%)", value = 8, min = 0, max = 100),
                              numericInput(inputId = "custom_n225", "Nikkei 225 (%)", value = 8, min = 0, max = 100),
                              numericInput(inputId = "custom_lse", "London Stock Exchange (%)", value = 8, min = 0, max = 100),
                              numericInput(inputId = "custom_asx", "ASX (%)", value = 8, min = 0, max = 100),
                              numericInput(inputId = "custom_custom", "Custom Index (%)", value = 8, min = 0, max = 100),
                            ), #sidebarpanel
                            mainPanel(
                              id="main",
                              plotOutput(outputId = "custom_returns"),
                              plotOutput(outputId = "custom_histogram"),
                              textOutput(outputId = "custom_stats")
                            ), #mainPanel
                          )
                ), #tabpanel
                
                tabPanel("Target Volatility Portfolio",
                         sidebarLayout(
                           sidebarPanel(
                             id="sidebar",
                             tags$h3("Find an optimised portfolio to achieve maximum return for a given level of risk/volatility"),
                             tags$h4("Input:"),
                             checkboxGroupInput("portfolio_selection",
                                                "Select Number of Indexes for Portfolio",
                                                choices = list()),
                             
                             numericInput(inputId = "n_points", "Number of random points to generate", value = 10000, min = 10000, max = 1000000),
                             numericInput(inputId = "target_vol", "Target Volatility", value = 13.5, min = 0, max = 100),
                             tags$h5("As observed from the vertical line representing the specified target volatility, there are multiple returns that one can achieve for a given level of risk, 
                                   displaying the ability of diversification to bring about greater returns for the same level of risk/volatility")
                           ), #sidebarpanel
                           mainPanel(
                             id="main",
                             plotOutput(outputId = "target_plot"),
                           ), #mainPanel
                         )
                  ) #tabpanel
                ) #overall navbarPage
) #fluidPage
      
server <- function(input, output, session) {
    
    #to output roll_corr_plot for first tab of Correlation of Indexes
    output$roll_corr_plot <- renderPlot({
      rollingcorr(duration = input$duration, 
                      corrvar1 = input$corrvar1, 
                      corrvar2 = input$corrvar2,
                      corrrange = input$corrrange)
    }) 
    
    #to output corr_heat_plot for first tab of Correlation of Indexes
    output$corr_heat_plot <- renderPlot({
      corrheatmap(corrrange <- input$corrrange)
    })
    
    #to output cum_return_plot for second tab of Weekly Cumulative Returns
    output$cum_return_plot <- renderPlot({
      returncolumn(cumvar = input$cumvar,
                   cumrange = input$cumrange)
    })
    
    #to output cum_stats for second tab of Weekly Cumulative Returns
    output$cum_stats <- renderText({
      cumstats(cumvar = input$cumvar,
                   cumrange = input$cumrange)
    })

    #to output plot_dist for third tab of Distribution of Returns
    output$plot_dist <- renderPlot({
      dist_returns(distrange = input$distrange,
               distvar = input$distvar)
    })
    
    #to output drawrangeplot for fourth tab of Drawdowns
    output$drawrangeplot <- renderPlot({
      drawdownmap(drawvar1 = input$drawvar1,
                  drawvar2 = input$drawvar2,
                  drawrange = input$drawrange)
    })
    
    #to output custom_returns for fourth tab of Custom Portfolio by Asset Weight
    output$custom_returns <- renderPlot({
      calculate_portfolio_returns(
        customrange = input$customrange,
        asset_weights = c(input$custom_csi500/100,
          input$custom_shanghai/100,                
          input$custom_csi300/100,
          input$custom_hsi/100,
          input$custom_sti/100,
          input$custom_twse/100,
          input$custom_msciw/100,
          input$custom_sp500/100,
          input$custom_n225/100,
          input$custom_lse/100,
          input$custom_asx/100,
          input$custom_custom/100))
    })
    
    #to output custom_histogram for fifth tab of Custom Portfolio
    output$custom_histogram <- renderPlot({
    customhist(
      customrange = input$customrange,
      asset_weights = c(input$custom_csi500/100,
                        input$custom_shanghai/100,                
                        input$custom_csi300/100,
                        input$custom_hsi/100,
                        input$custom_sti/100,
                        input$custom_twse/100,
                        input$custom_msciw/100,
                        input$custom_sp500/100,
                        input$custom_n225/100,
                        input$custom_lse/100,
                        input$custom_asx/100,
                        input$custom_custom/100))
    })
    
    #to output custom_stats for fifth tab of Custom Portfolio
    output$custom_stats <- renderText({
      customstats(
        customrange = input$customrange,
        asset_weights = c(input$custom_csi500/100,
                          input$custom_shanghai/100,                
                          input$custom_csi300/100,
                          input$custom_hsi/100,
                          input$custom_sti/100,
                          input$custom_twse/100,
                          input$custom_msciw/100,
                          input$custom_sp500/100,
                          input$custom_n225/100,
                          input$custom_lse/100,
                          input$custom_asx/100,
                          input$custom_custom/100))
    }) 
    
    #to output target_plot for sixth tab of Target Volatility Portfolio
    output$target_plot <- renderPlot({
      plot_emf(n_points = input$n_points,
               target_vol = input$target_vol,
               portfolio_selection = input$portfolio_selection)
    }) 
    
    # Column names we want to show - all except `Date`
    opts <- setdiff(colnames(source_file), "Date") 
    
    # Update your checkboxGroupInput:
    updateCheckboxGroupInput(
      session, "portfolio_selection", choices = opts, selected = opts[1:3])
    
      }
  
# Create Shiny Object
  shinyApp(ui = ui, server = server)
