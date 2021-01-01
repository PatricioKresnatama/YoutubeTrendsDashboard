server <- function(input,output){
  
  output$vbox1 <- renderValueBox({
    valueBox("Most Viewed:", 
             yt1 %>% 
               filter(year_publish %in% input$year_input1) %>%
               filter(category_id %in% input$check_box1) %>%  
               arrange(-total_views) %>% 
               head(1) %>% 
               pull(1),
             icon = icon("youtube"), 
             color = "red")
  })
  
  output$vbox2 <- renderValueBox({
    valueBox("Category:",
             yt1 %>% 
               filter(year_publish %in% input$year_input1) %>%
               filter(category_id %in% input$check_box1) %>%  
               arrange(-total_views) %>% 
               head(1) %>% 
               pull(2),
             icon = icon("list"),
             color = "red")
  })
  
  output$channel_plot <- renderPlotly({
    ggplotly(yt1 %>% 
               mutate(keterangan = paste(category_id,
                                         "<br> Total Views:",comma(total_views))) %>% 
               filter(year_publish %in% input$year_input1) %>%
               filter(category_id %in% input$check_box1) %>%  
               arrange(-total_views) %>% 
               head(10) %>% 
               ggplot(aes(x = reorder(channel_title,total_views), y = total_views, text = keterangan)) +
               geom_point(aes(color = category_id), show.legend = FALSE) +
               geom_segment(aes(x=reorder(channel_title,total_views), 
                                xend=reorder(channel_title,total_views), 
                                y=0, 
                                yend=total_views, 
                                color = category_id), 
                            show.legend = FALSE) +
               theme_pander() +
               theme(panel.grid.major.y = element_blank()) +
               scale_y_continuous(labels = comma) +
               labs(title = "Top 10 Most Viewed Channel",
                    x = "",
                    y = "Total Views") + 
               coord_flip(),
             tooltip = "text")  %>%
      layout(legend=list(title=list(text='<b> Category </b>')))
  })
  
  output$views_plot <- renderPlotly({
    ggplotly(yt2 %>% 
               mutate(keterangan = paste(category_id,
                                         "<br> Total Views:",comma(total_views))) %>% 
               filter(year_publish %in% input$year_input2) %>%
               filter(category_id %in% input$check_box2) %>% 
               ggplot(aes(x = reorder(category_id,total_views), y = total_views, text = keterangan)) +
               geom_col(aes(fill= total_views), show.legend = FALSE) +
               theme_pander() +
               theme(panel.grid.major.y = element_blank()) +
               scale_y_continuous(labels = comma) +
               labs(title = "Most Viewed Category",
                    x = "",
                    y = "Total Views") +
               coord_flip(), 
             tooltip = "text") %>% 
      layout(showlegend = FALSE)
  })
  
  output$like_dislike_plot <- renderPlotly({
    ggplotly(yt2 %>% 
               mutate(keterangan = paste(category_id,
                                         "<br> Like Ratio:",round(mean_like_ratio,3), 
                                         "<br> Dislike Ratio:",round(mean_dislike_ratio,3),
                                         "<br> Comment Ratio:",round(mean_comment_ratio,3))) %>% 
               filter(year_publish %in% input$year_input2) %>%
               filter(category_id %in% input$check_box2) %>% 
               ggplot(aes(x = mean_like_ratio, y = mean_dislike_ratio, text = keterangan)) +
               geom_point(aes(color = category_id, size = mean_comment_ratio), show.legend = F) +
               theme_pander() +
               labs(title = "Viewer Engangement",
                    x = "Mean Like Ratio",
                    y = "Mean Dislike Ratio"),
             tooltip = "text")  %>%
      layout(legend=list(title=list(text='<b> Category </b>')))
  })
  
  output$dataframe <- renderDataTable({read.csv("USvideos.csv")},  
                                      options = list(pageLength = 10, 
                                                     scrollX = TRUE))
  
}