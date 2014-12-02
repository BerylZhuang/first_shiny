shinyUI(fluidPage(
	titlePanel("Gapminder Shiny app"),
	
	sidebarLayout(
		sidebarPanel(
			h2("Choose country and years from Gapminder data set"),
			uiOutput("choose_country"),            # see #1 in server.R
			sliderInput("year_range",              # year input for server.R
									label = "Range of years:",
									min = 1952, max = 2007, 
									value = c(1955, 2005),
									format = "####")
		),
		mainPanel(h3(textOutput("output_country")),            #4
							plotOutput("ggplot_gdppc_vs_country"),      #5
							tableOutput("gapminder_table")              #3
		)
	)
))