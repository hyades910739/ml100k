library(shiny)

udata3 = read.csv("udata3.csv",header=T)


shinyUI(fluidPage(
  titlePanel("MovieLens"),
  
  fluidRow(
    column(12,
           sidebarPanel(
             selectInput("dataset", "Choose a movie:", 
                         choices = 1:1682)      
           ) 
    )
  ),  

    
  fluidRow(
    column(12,
           mainPanel(
             br(),
             br(),
             h2(textOutput("movie")),
             h3(textOutput("rating")),
             h3(textOutput("rater")),
             br(),
             plotOutput("scatter"),
             br(),
             br(),
             plotOutput("difference")           
           )
  )  
  )
      
      
))
