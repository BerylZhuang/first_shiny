shinyUI(fluidPage(
	titlePanel("Gapminder Shiny app"),
	
	sidebarLayout(
		sidebarPanel(
			h2("Choose country and years from Gapminder data set"),
			uiOutput("choose_country"),
			
# commented out the year slider 			
# 			sliderInput("year_range", 
# 									label = "Range of years:",
# 									min = 1952, max = 2007, 
# 									value = c(1955, 2005),
# 									format = "####"
# 									),

# use dateRangeInput with calender  #2.1
			dateRangeInput('dateRange',
										 label = 'Date range input: yyyy-mm-dd',
										 start = "1957-01-01", end = "2007-01-01"
										 )
		),
		mainPanel(h3(textOutput("output_country")),
							plotOutput("ggplot_gdppc_vs_country"),
							tableOutput("gapminder_table")              
		)
	)
))