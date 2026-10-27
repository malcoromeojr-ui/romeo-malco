library(readxl)
> attendance <- read_excel("STUDENT_ATTENDANCE_GRADE-12_ZEUS.xlsx")

> print("--- Full Dataset Overview ---")
[1] "--- Full Dataset Overview ---"
> print(attendance)
# A tibble: 27 × 5
`STUDENT NAME` SUBJECT                      QUARTER `DAYS PRESENT` `TOTAL SCHOOL DAYS`
<chr>          <chr>                        <chr>            <dbl>               <dbl>
  1 Ana Reyes      Oral Communication           Q1                  42                  48
2 Ana Reyes      Oral Communication           Q2                  45                  50
3 Ana Reyes      Oral Communication           Q3                  40                  45
4 Ana Reyes      English for academic Purpos… Q1                  40                  48
5 Ana Reyes      English for academic Purpos… Q2                  43                  50
6 Ana Reyes      English for academic Purpos… Q3                  41                  45
7 Ana Reyes      Fundamentals in Accountancy  Q1                  44                  48
8 Ana Reyes      Fundamentals in Accountancy  Q2                  46                  50
9 Ana Reyes      Fundamentals in Accountancy  Q3                  42                  45
10 Juan Santos    Oral Communication           Q1                  45                  48
# ℹ 17 more rows
# ℹ Use `print(n = ...)` to see more rows
> english_q1 <- subset(attendance, SUBJECT == "English for academic Purposes" & QUARTER== "Q1")
> print("--- English for Academic Purposes (Q1) ---")
[1] "--- English for Academic Purposes (Q1) ---"
> print(english_q1)
# A tibble: 3 × 5
`STUDENT NAME` SUBJECT                       QUARTER `DAYS PRESENT` `TOTAL SCHOOL DAYS`
<chr>          <chr>                         <chr>            <dbl>               <dbl>
  1 Ana Reyes      English for academic Purposes Q1                  40                  48
2 Juan Santos    English for academic Purposes Q1                  44                  48
3 Maria Cruz     English for academic Purposes Q1                  46                  48
> print("--- Top Attendance Student in English Q1 ---")
[1] "--- Top Attendance Student in English Q1 ---"
> print(top_english_q1)
# A tibble: 1 × 5
`STUDENT NAME` SUBJECT                       QUARTER `DAYS PRESENT` `TOTAL SCHOOL DAYS`
<chr>          <chr>                         <chr>            <dbl>               <dbl>
  1 Maria Cruz     English for academic Purposes Q1                  46                  48
> english_q1_ranked <- english_q1[order(-english_q1$`DAYS PRESENT`), ]
> english_q1_summary <- data.frame(
  + Average_Days_Present = mean(english_q1$`DAYS PRESENT`),
  + Median_Days_Present  = median(english_q1$`DAYS PRESENT`),
  + Lowest_Attendance   = min(english_q1$`DAYS PRESENT`),
  + Highest_Attendance  = max(english_q1$`DAYS PRESENT`)
  +  )
> q1_all <- subset(attendance, QUARTER == "Q1")
> q1_SUBJECT_averages <- aggregate(`DAYS PRESENT` ~ SUBJECT, q1_all, mean)
> top_q1_students_by_SUBJECT<- q1_all[
  + ave(q1_all$`DAYS PRESENT`, q1_all$SUBJECT, FUN = max) == q1_all$`DAYS PRESENT`, ]
> print("--- Ranked Results ---")
[1] "--- Ranked Results ---"
> print(english_q1_ranked)
# A tibble: 3 × 5
`STUDENT NAME` SUBJECT                       QUARTER `DAYS PRESENT` `TOTAL SCHOOL DAYS`
<chr>          <chr>                         <chr>            <dbl>               <dbl>
  1 Maria Cruz     English for academic Purposes Q1                  46                  48
2 Juan Santos    English for academic Purposes Q1                  44                  48
3 Ana Reyes      English for academic Purposes Q1                  40                  48
> print("--- Attendance Summary ---")
[1] "--- Attendance Summary ---"
> print(english_q1_summary)
Average_Days_Present Median_Days_Present Lowest_Attendance Highest_Attendance
1             43.33333                  44                40                 46
> print("--- Top Students by SUBJECT (q1) ---")
[1] "--- Top Students by SUBJECT (q1) ---"
> print(top_q1_students_by_SUBJECT)
# A tibble: 3 × 5
`STUDENT NAME` SUBJECT                       QUARTER `DAYS PRESENT` `TOTAL SCHOOL DAYS`
<chr>          <chr>                         <chr>            <dbl>               <dbl>
  1 Juan Santos    Oral Communication            Q1                  45                  48
2 Maria Cruz     English for academic Purposes Q1                  46                  48
3 Maria Cruz     Fundamentals in Accountancy   Q1                  45                  48
> write.csv(top_english_q1, "Highest_English_Q1_Result.csv", row.names = FALSE)
> write.csv(english_q1_ranked, "English_Q1_Ranked_Results.csv", row.names = FALSE)
> write.csv(q1_SUBJECT_averages, "Q1_SUBJECT_Averages.csv", row.names = FALSE)
> write.csv(top_q1_students_by_SUBJECT, "Top_Q1_Students_by_SUBJECT.csv", row.names = FALSE)
> 
  > 
  > 