# アライグマ防除における意思決定支援システムのアプリケーション公開ページ
以下の２つのアプリケーションを公開しています。
・フィージビリティスタディからの防除費用試算DSS（budgeting-support-system）
・捕獲数評価のDSS（control-evaluation-system）

# アプリケーションの実行方法
R及び必要なRパッケージ（shiny, ggplot2, etc）をインストールの上、
Rコンソール上で以下のように実行してください

・フィージビリティスタディからの防除費用試算DSS（budgeting-support-system）
library(shiny)
runGitHub("applications", "raccoon-control-DSS", subdir= "budgeting-support-system")


・フィージビリティスタディからの防除費用試算DSS（budgeting-support-system）
library(shiny)
runGitHub("applications", "raccoon-control-DSS", subdir= "control-evaluation-system")
