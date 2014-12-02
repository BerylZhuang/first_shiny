# load packages
library(ggplot2)

#source helper funcitons

source("helper_functions.R")

# load data
gDat <- readRDS("data/gapminder.rds")




shinyServer(function(input, output) {
	
	#1. Drop-down selection box generated from Gapminder dataset    #ui.R: uiOutput("choose_country")
	output$choose_country <- renderUI({
		selectInput("country_from_gapminder", "Country", as.list(levels(gDat$country)))
	})
	
# 	#2 reactive input from user (pick country to display) and subset the table for tabke display and plots
# 	one_country_data <- reactive({
# 		if(is.null(input$country_from_gapminder)) {
# 			return(NULL)
# 		}
# 		subset(gDat, country == input$country_from_gapminder &
# 					 	year >= input$year_range[1] & year <= input$year_range[2] )       # see ui.R sliderInput for year_range
# 	})

#2.1 reactive input from user (pick country to display) and subset the table for tabke display and plots
	one_country_data <- reactive({
		if(is.null(input$country_from_gapminder)) {
			return(NULL)
		}
		subset(gDat, country == input$country_from_gapminder &
					 	year >= as.numeric(format(input$dateRange[1], "%Y")) & 
					 	year <= as.numeric(format(input$dateRange[2], "%Y")) )       # see ui.R dateRange, only use year as input
	})
	
	#3 render the table of selected contents          #ui.R : tableOutput("gapminder_table")
	output$gapminder_table <- renderTable({ 
		one_country_data()
	})
	
	#4 render text output of the selected country   #ui.R: textOutput("output_country")
	output$output_country <- renderText({
		if (is.null(input$country_from_gapminder)){
			return(NULL)
		}
		paste("Country selected", input$country_from_gapminder)
	})
	
	#5 render the plot, #ui.R: plotOutput("ggplot_gdppc_vs_country")
	output$ggplot_gdppc_vs_country <- renderPlot({
		if(is.null(one_country_data())) {
			return(NULL)
		}
		p <-  ggplot(one_country_data(), aes(x = year, y = gdpPercap))
		p + geom_point() 
	})
	
	# 6 Replace the slider for the years instead with the widget dateRangeInput.
	output$dateRangeText  <- renderText({
		paste("input$dateRange is", 
					paste(as.character(input$dateRange), collapse = " to ")
		)
	})
	
	
	
})


#------------------------
#------------------------
