library(shiny)
library(ggplot2)
library(dplyr)

udata3 = read.csv("ml100k/udata3.csv",header=T)

shinyServer(function(input,output){
  
  datasetInput <- reactive({

    
  })  
  
  output$movie = renderText({
    movie = udata3[movieid==input$dataset,5]
    res = movie[1] %>% as.character()
    return(res)    
  }
  )
  output$rating = renderText({
    res = udata3[movieid==input$dataset,3] %>% mean() %>% round(.,2)
    paste("rating: ",res,sep="")
    })

  output$rater = renderText({
    res = udata3[movieid==input$dataset,3] %>% length()
    paste("from: ",res," users",sep="")
  })  
    
  output$scatter <- renderPlot({
    movie = udata3[movieid==input$dataset,c(2,3,5,28,29,30,31)]
    qplot(x=occupation, y=rating ,color=occupation ,data = movie, geom = "jitter",
          size=5,alpha=0.2,main="Rating between occupation")+coord_flip()+guides(size=F,alpha=F)+
      theme(axis.text=element_text(size=14),
            title = element_text(size=18),
            axis.title=element_text(size=12,face="bold"))
  })
  
  output$difference <- renderPlot({
    movie = udata3[movieid==input$dataset,c(2,3,5,28,29,30,31)]
    a <- movie$occupation %>% table() %>% '/'(sum(.))
    b <- udata3$occupation %>% table() %>% '/'(sum(.))
    ab <- data.frame(oc=a-b)
    names(ab) <- c("occupation","difference")
    ggplot(data=ab, aes(x=occupation,y=difference)) +
      geom_bar(position="dodge",stat="identity",fill = "#FFAD86") + 
      coord_flip() +  labs(title = "occupation difference percentage",x= "occupation")+
      theme(axis.text=element_text(size=14),
            title = element_text(size=18),
            axis.title=element_text(size=12,face="bold"))
  })  
  
  
  
  
})