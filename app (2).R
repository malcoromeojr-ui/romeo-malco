library(shiny)
library(readxl)
library(DT)

ui <- fluidPage(
  titlePanel("Grade 12 Student Attendance Review Application"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("SUBJECT_select", "SUBJECT:", 
                  choices = c("Oral Communication", 
                              "English for academic Purposes", 
                              "Fundamentals in Accountancy"), 
                  selected = "English for academic Purposes"),
      
      selectInput("QUARTER_select", "QUARTER:", 
                  choices = c("Q1", "Q2", "Q3"), 
                  selected = "Q1"),
      
      sliderInput("min_days", "Minimum DAYS PRESENT:", 
                  min = 35, max = 50, value = 40, step = 1),
      
      br(),
      h4("Summary"),
      textOutput("top_result")
    ),
    
    mainPanel(
      h3("Student Attendance Data"),
      DTOutput("attendance_table"),
      br(),
      textOutput("rows_count")
    )
  )
)

server <- function(input, output, session) {
  # Read dataset
  attendance_data <- reactive({
    read_excel("STUDENT_ATTENDANCE_GRADE-12_ZEUS.xlsx")
  })
  
  # Filter Data dynamically using exact column headers from ZEUS dataset
  filtered_data <- reactive({
    req(attendance_data())
    df <- attendance_data()
    subset(df, 
           SUBJECT == input$SUBJECT_select & 
             QUARTER == input$QUARTER_select & 
             `DAYS PRESENT` >= input$min_days)
  })
  
  output$rows_count <- renderText({
    paste("Rows shown:", nrow(filtered_data()))
  })
  
  output$top_result <- renderText({
    df <- filtered_data()
    if (nrow(df) == 0) {
      return("No records match the selected criteria.")
    }
    top_row <- df[which.max(df$`DAYS PRESENT`), ]
    paste0("The highest result is for ", top_row$`Student Name`, 
           " in ", top_row$Quarter, " with ", top_row$`Days Present`, " days present out of ", top_row$`Total School Days`, " school days.")
  })
  
  output$attendance_table <- renderDT({
    datatable(filtered_data(), options = list(pageLength = 5, searching = TRUE))
  })
}

shinyApp(ui = ui, server = server)