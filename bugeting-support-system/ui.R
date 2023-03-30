# パッケージの読み込み
library(shiny)
library(ggplot2)
library(ggsci)
library(scales)
library(showtext)


# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("アライグマ防除に必要な予算策定支援システム"),
  
  # Inputbox
  sidebarLayout(
    
    sidebarPanel(
      
      fluidRow(
        h4("【根絶可能性に関するチェックリスト】"),
  
        checkboxGroupInput("FSrequired", label = "必須検討条件",
                           choices = list("再侵入の可能性がゼロである" = 1,
                                          "防除手法がすべての個体に有効である" = 1,
                                          "貴重な種や群集への悪影響がない" = 1,
                                          "防除事業が増加率（繁殖率・新規個体侵入率）を上回る" = 1)),
        
        checkboxGroupInput("FSadd", label = "付加検討条件",
                           choices = list("適切な社会・政治環境が整っている" = 1,
                                          "低密度でも生存個体の探索が可能である" = 1,
                                          "cost-benefit分析はコントロールよりも根絶に有効である" = 1,
                                          "気候的制約" = 1,
                                          "全ての個体に合法的である" = 1)),
        
        br(),
        
        h4("【対象地域の捕獲実績】"),
        numericInput("effort",
                     label = "わな日（対象地域に設置したわな基数 × 設置日数）",
                     min = 0, value = 1000),
        helpText("※わな日が正確に把握されていない場合、
                       このシステムでは必要な予算を正しく計算することができません"),
        numericInput("capture",
                     label = "対象地域で捕獲されたアライグマ頭数（頭）",
                     min = 0, value = 45),
        numericInput("area",
                     label = "対象地域の面積（km2）",
                     min = 0, value = 747.6),
        
        br(),
        
        h4("【目標設定】"),
        radioButtons("percent",
                     label = "対象地域の捕獲頭数に関する目標",
                     choices = list("推定生息頭数の50%を捕獲" = 0.5,
                                    "推定生息頭数の60%を捕獲" = 0.6,
                                    "推定生息頭数の70%を捕獲" = 0.7),
                     selected = 0.6),
        
        
        br(),
        
        h4("【投入可能な資源及び努力量】"),
        numericInput("trapd",
                     label = "1日のわな見回り基数（基/日）",
                     min = 0, value = 180),
        numericInput("worker",
                     label = "捕獲作業員数（人）",
                     min = 0, value = 18),
        numericInput("car",
                     label = "必要な車の台数（台）",
                     min = 0, value = 9),
        
        br(),
        
        h4("【必要物品数及び単価】"),
        numericInput("salary",
                     label = "捕獲作業員の作業単価（円/日）",
                     min = 0, value = 4000),
        numericInput("purchase",
                     label = "箱わな購入基数（予備を含む）",
                     min = 0, value = 270),
        numericInput("bait",
                     label = "誘引餌の単価（円/基）",
                     min = 0, value = 40),
        numericInput("euthanasia",
                     label = "アライグマの殺処分単価（円/頭）",
                     min = 0, value = 8000)
      )
    ),
    
    mainPanel(
      textOutput("FStext"),
      verbatimTextOutput("text"),
      plotOutput("plot")
    ),
    
    position = "left", fluid =TRUE)
))
