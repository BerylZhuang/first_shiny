shinyUI(fluidPage(
	titlePanel("Gapminder Shiny app"),
	
	sidebarLayout(
		sidebarPanel(
			h4("Choose one country from Gapminder data set"),
			uiOutput("choose_country"),     # for 1 country plot
			

# commented out the year slider 			
# 			sliderInput("year_range", 
# 									label = "Range of years:",
# 									min = 1952, max = 2007, 
# 									value = c(1955, 2005),
# 									format = "####"
# 									),


# use dateRangeInput with calender  #2.1
			h4("Select date range"),
			dateRangeInput('dateRange',
										 label = 'Date range input: yyyy',
										 start = "1957-01-01", end = "2007-01-01",
										 format = "yyyy"
										 ),

			h4("Select multiple countries"),
			selectizeInput(
				"choose_multiple_countries", 
				"Select up to 5 countries for comparison", 
				choices = as.list(levels(gDat$country)), 
				multiple = TRUE,
				options = list(maxItems = 5)
				),

			h4("Facet plots by country"),
			radioButtons("to_facet", label = "Facet plots by country",
						 choices = c("Yes" = TRUE, "No" = FALSE)
							)

		),


	tabsetPanel(
			tabPanel("oneCountryData", 
							h3(textOutput("output_one_country")),           #1.1
							plotOutput("ggplot_gdppc_vs_country"),
							tableOutput("gapminder_table")),
			tabPanel("multiCountryData",
							h3(textOutput("output_multiple_countries")),
							plotOutput("ggplot_gdppc_vs_country_multiple"))
		)
	)
))

