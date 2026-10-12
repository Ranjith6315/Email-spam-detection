library(shiny)

ui <- fluidPage(
  titlePanel("📧 Email Spam Detection"),
  
  sidebarPanel(
    textAreaInput("email", "Enter Email:",
                  "Congratulations! You won a free prize"),
    actionButton("check", "Check Email")
  ),
  
  mainPanel(
    h3("Result"),
    textOutput("result")
  )
)

server <- function(input, output) {
  
  output$result <- renderText({
    input$check
    
    text <- tolower(input$email)
    
    spam_words <- c(
      "free", "win", "winner", "prize",
      "money", "offer", "claim"
    )
    
    found <- any(sapply(spam_words,
                        function(x) grepl(x, text)))
    
    if (found) {
      "⚠️ Result: SPAM EMAIL"
    } else {
      "✅ Result: NOT SPAM"
    }
  })
}

shinyApp(ui, server)