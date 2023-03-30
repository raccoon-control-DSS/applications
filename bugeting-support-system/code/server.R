# パッケージの読み込み
library(shiny)
library(ggplot2)
library(ggsci)
library(scales)
library(showtext)


shinyServer(function(input, output) {
  
  #CPUEの算出
  CPUE <- reactive({
    return(input$capture / input$effort * 100)
  })
  
  #推定個体数
  POPU <- reactive({
    return(input$area * {(CPUE() + 0.6924) / 1.6045})
  })
  
  #捕獲目標数
  GOAL <- reactive({
    return(as.numeric(input$percent) * POPU())
  })
  
  #必要TN数
  TRNI <- reactive({
    return((GOAL() / CPUE()) *100)
  })
  
  #必要わなかけ日数
  DAYS <- reactive({
    return(TRNI() / input$trapd)
  })
  
  #必要人件費
  SALA <- reactive({
    return(input$salary * input$worker * DAYS())
  })
  
  #わな購入費
  TRAP <- reactive({
    return(input$purchase * 13000)
  })
  
  #餌購入費
  BAIT <- reactive({
    return(input$bait * TRNI())
  })
  
  #車リース代
  CARS <- reactive({
    return(input$car * DAYS() * 2400)
  })
  
  #殺処分費用
  EUTH <- reactive({
    return(input$euthanasia * GOAL())
  })
  
  #必要総コスト
  SUMM <- reactive({
    return(SALA() + TRAP() + BAIT() + CARS() + EUTH())
  })

  
  #FS結果
  FS <- reactive({
    return(length(input$FSrequired))
  })
  
  
  #output_FStext
  output$FStext <- renderText({
    paste("【根絶目標の設定について】対象地域でのアライグマ根絶は", 
          if(FS() == 4) {print("可能です。")}
          else{print("不可能です。根絶を目指すにはチェックリストの必須検討条件をすべて満たしてください。")
          })
  })
  
  #output_text
  output$text <- renderText({
    paste("【計算結果】",
          '\n',
          "地域CPUE値:", format(round(CPUE(), 2), nsmall = 2),
          '\n',
          "対象地域推定生息頭数:", format(round(POPU(), 2), nsmall = 2),"頭",
          '\n',
          "生息頭数減少に必要な捕獲頭数:", format(round(GOAL(), 2), nsmall = 2),"頭",
          '\n',
          "必要わなかけ日数:", format(round(DAYS(), 2), nsmall = 2),"日",
          '\n', 
          "アライグマ対策にかかる総コスト:", format(round(SUMM(), 2), nsmall = 2), "円"
    )
  })
  
  
  #output_graph
  output$plot <- renderPlot({
    costs <- c("総コスト", "総コスト", "総コスト", "総コスト", "総コスト")
    lists <- c("人件費", "箱わな購入費", "誘引餌購入費", "車リース費", "殺処分費")
    total <- c(round(SALA(), digits = 2), round(TRAP(), digits =2),
               round(BAIT(), digits = 2), round(CARS(), digits = 2),
               round(EUTH(), digits =2))
    data <- data.frame(costs, lists, total)
    g <- ggplot(data, aes(x = costs, y = total, fill = lists))
    g <- g + labs(x = " ", y = "コストの内訳（%）", fill = "凡例")
    g <- g + geom_bar(stat = "identity", position = "fill")
    g <- g + scale_y_continuous(labels = percent)
    g <- g + coord_flip()
    g <- g + scale_fill_nejm()
    plot(g)
  })
  
})
