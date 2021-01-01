ui <- dashboardPage(skin = "red",
  dashboardHeader(title = "Youtube Analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(text = "Most View Channel",tabName = "first", icon = icon("youtube")),
      menuItem(text = "Most View Category",tabName = "second", icon = icon("youtube")),
      menuItem(text = "About",tabName = "third", icon = icon("table"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "first", 
              fluidPage(
                fluidRow(
                  column(width = 8,
                         valueBoxOutput(width = 6, outputId = "vbox1"),
                         valueBoxOutput(width = 6, outputId = "vbox2")),
                  column(width = 4,
                         box(width = 12,
                             selectInput(inputId = "year_input1", 
                                         label = "Select Year:", 
                                         choices = levels(yt1$year_publish),
                                         selected = "2018")))
                ),
                fluidRow(
                  column(width = 8,
                         box(width = 12,
                             plotlyOutput(outputId = "channel_plot"))),
                  column(width = 4,
                         box(width = 12,
                             checkboxGroupInput(inputId = "check_box1",
                                                label = "Select Category:",
                                                choices = levels(yt1$category_id),
                                                selected = levels(yt1$category_id))))
                )
              )
      ),
      tabItem(tabName = "second", 
              fluidPage(
                fluidRow(
                  column(width = 8,
                         box(width = 12,
                             plotlyOutput(outputId = "views_plot"))),
                  column(width = 4,
                         box(width = 12,
                             selectInput(inputId = "year_input2",
                                         label = "Select Year:",
                                         choices = levels(yt2$year_publish), 
                                         selected = "2018")))
                ),
                fluidRow(
                  column(width = 8,
                         box(width = 12,
                             plotlyOutput(outputId = "like_dislike_plot"))),
                  column(width = 4,
                         box(width = 12,
                             checkboxGroupInput(inputId = "check_box2",
                                                label = "Select Category:" ,
                                                choices = levels(yt2$category_id),
                                                selected = levels(yt2$category_id))))
                )
              )
      ),
      tabItem(tabName = "third",
              fluidPage(
                fluidRow(
                  column(width = 6,
                         box(width = 12,
                             h1("About the Dataset"),
                             p("YouTube (the world-famous video sharing website) maintains a list of 
                             the top trending videos on the platform. According to Variety magazine, 
                             “To determine the year’s top-trending videos, YouTube uses a combination 
                             of factors including measuring users interactions (number of views, shares, 
                             comments and likes). Note that they’re not the most-viewed videos overall 
                             for the calendar year”. Top performers on the YouTube trending list are 
                             music videos (such as the famously virile “Gangam Style”), celebrity and/or 
                             reality TV performances, and the random dude-with-a-camera viral videos that 
                             YouTube is well-known for. This dataset is a daily record of the top trending 
                               YouTube videos.", 
                               style="text-align:justify;color:black"))),
                  column(width = 6,
                         box(width = 12, 
                             h1("About the Analysis"),
                             p("The dataset is about youtube channel in USA. This dashboard has 2 analysis 
                             pages. Analysis in page 'most viewed channel' is about youtube channel that 
                             have the most views based on category and year. Meanwhile in page 'most viewed 
                             category' is about video category in youtube that have the most views and viewer 
                             engangement (like ratio, dislike ratio, comment ratio) based on category and year",
                               style="text-align:justify;color:black")))
                  ),
                  fluidRow(
                    column(width = 12,
                           box(width = 12,
                               h1("RAW Youtube Dataset"),
                               dataTableOutput(outputId = "dataframe")))
                  )
              )
      )
    )
  )
)
