#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws portfolio returns plots
ui <- fluidPage(
  
  # Application title
  titlePanel(HTML("<b>Portfolio Returns Comparison</b>")),
  
  column(3,
         sliderInput("initialamount",
                     "Initial Amount",
                     min = 0,
                     max = 10000,
                     value = 1000,
                     step = 100),
         sliderInput("annualcontribution",
                     "Annual Contribution",
                     min = 0,
                     max = 5000,
                     value = 200,
                     step = 100),
         sliderInput("annualgrowthrate",
                     "Annual Growth Rate (in %)",
                     min = 0,
                     max = 20,
                     value = 2,
                     step = 0.1)
  ),
  column(3,
         sliderInput("highyieldrate",
                     "High Yield Annual Rate (in %)",
                     min = 0,
                     max = 20,
                     value = 2,
                     step = 0.1),
         sliderInput("fixedincomerate",
                     "Fixed Income Annual Rate (in %)",
                     min = 0,
                     max = 20,
                     value = 5,
                     step = 0.1),
         sliderInput("usequityrate",
                     "US Equity Annual Rate (in %)",
                     min = 0,
                     max = 20,
                     value = 10,
                     step = 0.1)
  ),
  column(3,
         sliderInput("highyieldvolatility",
                     "High Yield Volatility (in %)",
                     min = 0,
                     max = 20,
                     value = 0.1,
                     step = 0.1),
         sliderInput("fixedincomevolatility",
                     "Fixed Income Volatility (in %)",
                     min = 0,
                     max = 20,
                     value = 4.5,
                     step = 0.1),
         sliderInput("usequityvolatility",
                     "US Equity volatility (in %)",
                     min = 0,
                     max = 20,
                     value = 15,
                     step = 0.1)
  ),
  column(3,
         sliderInput("years",
                     "Years",
                     min = 0,
                     max = 50,
                     value = 20,
                     step = 1),
         numericInput("seed", label = ("Random seed"), value = 12345),
         selectInput("select", label = ("Facet?"), 
                     choices = list("Yes" = 1, "No" = 0), 
                     selected = 1)
  ),
  
  # Show a plot of the generated returns plot
  mainPanel(HTML("<hr></hr>"),
            HTML("<h4><b>Timelines</b></h4>"),
    plotOutput("returnsPlot")
  )
)

# Define server logic required to draw a returns plot
server <- function(input, output) {
  
  output$returnsPlot <- renderPlot({
    
    set.seed(input$seed)
    
    rate_HYS <- (input$highyieldrate)/100 # High Yield Savings Account avg return
    vol_HYS <- (input$highyieldvolatility)/100 # High Yield Savings Account annual volatility
    
    rate_bonds <- (input$fixedincomerate)/100 # U.S. bonds annual avg return
    vol_bonds <- (input$fixedincomevolatility)/100 # U.S. bonds annual volatility
    
    rate_stocks <- (input$usequityrate)/100 # U.S. stocks annual avg return
    vol_stocks <- (input$usequityvolatility)/100 # U.S. stocks annual volatility
    
    initialamount = input$initialamount
    annualcontribution = input$annualcontribution
    annual_growth_rate = (input$annualgrowthrate)/100
    investment_period = input$years
    
    year <- rep(0, investment_period + 1)
    
    amount_HYS <- rep(0, investment_period + 1)
    amount_HYS[1] <- initialamount
    
    amount_bonds <- rep(0, investment_period + 1)
    amount_bonds[1] <- initialamount
    
    amount_stocks <- rep(0, investment_period + 1)
    amount_stocks[1] <- initialamount
    
    for (i in 1:investment_period){
      annualreturn_HYS <- rnorm(1, mean = rate_HYS, sd = vol_HYS)
      annualreturn_bonds <- rnorm(1, mean = rate_bonds, sd = vol_bonds)
      annualreturn_stocks <- rnorm(1, mean = rate_stocks, sd = vol_stocks)
      
      year[i+1] <- i
      
      amount_HYS[i+1] <- (amount_HYS[i])*(1+annualreturn_HYS) + annualcontribution*((1+annual_growth_rate)^(i-1))
      
      amount_bonds[i+1] <- (amount_bonds[i])*(1+annualreturn_bonds) + annualcontribution*((1+annual_growth_rate)^(i-1))
      
      amount_stocks[i+1] <- (amount_stocks[i])*(1+annualreturn_stocks) + annualcontribution*((1+annual_growth_rate)^(i-1))
    }
    
    amount <- c(amount_HYS, amount_bonds, amount_stocks)
    index <- rep(c("high_yield", "us_bonds", "us_stocks"), each = investment_period+1)
    
    returns_dat <- cbind.data.frame(amount, year, index)
    
    if (input$select == 1){
      ggplot(data = returns_dat, aes(x = year, y = amount, colour = index)) + geom_area(aes(fill = index), alpha = 0.6) + scale_fill_hue(l = 80, c = 40) + geom_point() + geom_line() + theme_bw() + facet_wrap(~index) + ggtitle("Three indices")
    }
    else {
      ggplot(data = returns_dat, aes(x = year, y = amount, colour = index)) + geom_point() + geom_line() + theme_bw() + ggtitle("Three indices")
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)