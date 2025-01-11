
# R course for beginners
# Week 9
# assignment by < Dana > < Sergeev >, id < 316019785 >

#### CREATE DATAFRAME ----

## Generate vectors
N = 100
subject     = seq(1, N, 1)
gender      = sample(c('female', 'male'), N, replace = TRUE)
age         = runif(N, 15, 40) 
depression  = rbinom(N, 1, 0.5)  
sleep_time = pmin(pmax(rnorm(10, mean = 7, sd = 1.5), 2), 12)
response_time = pmin(pmax(rlnorm(10, meanlog = log(1000), sdlog = 0.5), 200), 6000)


## Add to Df
df <- data.frame(subject, gender, age, depression, sleep_time, response_time)


## Save
write.csv(df,"C:/Users/danas/OneDrive/Desktop/פסיכולוגיה- תואר שני/קורס R/Week_9/analysis.csv", row.names = FALSE)

## שימוש בפונקציה שיצרתי ב- functions.R
source("C:/Users/danas/OneDrive/Desktop/פסיכולוגיה- תואר שני/קורס R/functions.R")

# הערה: הפונקציה כוללת בדיקה אם יש פחות מ-10 תצפיות
#לכן צפויה לעבוד עם 100 תצפיות
results <- generate_statistics(df)

# יצירת דאתה עם פחות מ-10 תצפיות לבדיקת התנאי
df_small <- data.frame(
  subject = seq(1, 5, 1),
  gender = sample(c("male", "female"), 5, replace = TRUE),
  age = runif(5, min = 15, max = 40),
  response_time = pmin(pmax(rlnorm(5, meanlog = log(1000), sdlog = 0.5), 200), 6000),
  depression = runif(5, min = 0, max = 100),
  sleep_time = pmin(pmax(rnorm(5, mean = 7, sd = 1.5), 2), 12)
)

# הערה: הפונקציה לא תעבוד כי יש 5 משתנים
results <- generate_statistics(df_small)


### הוספת תנאי סינון 
# סינון ה-Data Frame לפי מספרי נבדקים (subject_start, subject_end)
# אם אין נבדקים בטווח, הפונקציה מחזירה שגיאה: "No subjects in the specified range"

# יצירת Data Frame נוסף עם נבדקים מחוץ לטווח
df_out_of_range <- data.frame(
  # נבדקים מחוץ לטווח של ה-Data Frame המקורי (למשל, 101–110)
  subject = seq(101, 110, 1), 
  gender = sample(c("male", "female"), 10, replace = TRUE), 
  age = runif(10, min = 15, max = 40),
  response_time = pmin(pmax(rlnorm(10, meanlog = log(1000), sdlog = 0.5), 200), 6000), 
  depression  = rbinom(10, 1, 0.5), 
  sleep_time = pmin(pmax(rnorm(10, mean = 7, sd = 1.5), 2), 12)  
)

# הערה: הפונקציה לא תעבוד כי הנבדקים לא בטווח
results <- generate_statistics(df_out_of_range, subject_start = 1, subject_end = 10)


  