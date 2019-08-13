library(shiny)
library(dplyr)
library(purrr)
library(readr)
library(stringr)
library(magrittr)

tweets <- read_tsv(file.path("data", "tweets_master.tsv"))

ui <- navbarPage(
  title = img(src = "https://storage.googleapis.com/proudcity/elgl/uploads/2019/07/elgl-logo-189x64.png",
              height = "100%"),
  fluid = TRUE,
  windowTitle = "#CityHallSelfie Day",
  position = "fixed-top",
  collapsible = TRUE,
            
  tabPanel("Home",
  
  fluidPage(
  tags$head(HTML('<link href="https://fonts.googleapis.com/css?family=Roboto+Mono" rel="stylesheet">')),
  tags$head(HTML('<style>* {font-size: 100%; font-family: Roboto Mono;}</style>')),
  tags$head(HTML('<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>')),
  tags$head(HTML('<style>
    .navbar {
    background-color: #3b8540 !important;
    }
    
    .navbar-nav a {
    background-color: #3b8540 !important;
    color: white !important;
    }
                 </style>')),
  
  fluidRow(
    column(12,
           br(),
           br(),
           br())
  ),
  
  fluidRow(
    column(1),
    column(4,
      h2(img(src = "https://storage.googleapis.com/proudcity/elgl/uploads/2019/07/city-hall-selfie.png",
             width = "40%"),
      img(src = "https://storage.googleapis.com/proudcity/elgl/uploads/2019/07/logo-hi-1-300x106.png",
          width = "40%")),
      h2("#CityHallSelfie Day"),
      HTML(paste("<p><a href='https://elgl.org/cityhallselfie'>#CityHallSelfie Day</a>",
                 "is a worldwide celebration of local government service. It showcases pride
                 in local government institutions. Local government employees, elected officials,
                 media, and community members participate on #CityHallSelfie Day")),
      p(selectInput('sort_by', 'Sort tweets', c("Most recent", "Most likes", "Most retweets"), 
                    selected = base::sample(c("Most recent", "Most likes", "Most retweets"), 1))),
      HTML(paste("<p>#CityHallSelfie Day is managed by ELGL, the Engaging Local Government Leaders network. 
                 ELGL is a professional association of 4,800 people who work for and with local government.</p>")),
      tags$blockquote("ELGL’s mission is to engage the brightest minds in local government. 
                      In 2019, ELGL and Bang the Table are partnering to produce #CityHallSelfie day."),
      HTML(paste("<p>Also be sure to check out the <a href='https://elglengagementcorner.org/cityhallselfieday'
                 >ELGL Engagement Corner</a>"))
    ),
    column(6,
      h3(textOutput('tweets_sorted_by')),
      uiOutput('tweets')
    ),
    column(1)
    )
  )
  )
)

embed_tweet <- function(tweet) {
  tags$blockquote(class = "twitter-tweet", tags$a(href = tweet$status_url))
}



server <- function(input, output, session) {
  
  
  sorted_tweets <- reactive({
    switch(input$sort_by,
           "Most recent"   = tweets %>% arrange(desc(created_at)),
           "Most likes"    = tweets %>% arrange(desc(favorite_count)),
           "Most retweets" = tweets %>% arrange(desc(retweet_count)))
  })
  
  output$tweets_sorted_by <- reactive({paste("Tweets sorted by", tolower(input$sort_by))})
  
  
  output$tweets <- renderUI({
    tagList(map(transpose(sorted_tweets()), embed_tweet), 
            tags$script('twttr.widgets.load(document.getElementById("tweets"));'))
  })
}


shinyApp(ui, server)
