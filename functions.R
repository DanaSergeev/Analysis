multiply_or_add <- function(a, b) {
  if (a > 5 & b > 5) {
    result <- a * b
  } else {
    result <- a + b
  }
  return(result)
}


generate_statistics <- function(df, subject_start, subject_end) {
  # סינון ה-Data Frame לפי מספרי נבדקים (subject_start, subject_end)
  filtered_df <- df[df$subject >= subject_start & df$subject <= subject_end, ]
  
  # תנאי: אם אין נבדקים בטווח, מחזירים שגיאה
  if (nrow(filtered_df) == 0) {
    stop("Error: No subjects in the specified range")
  }
  
  # תנאי: אם יש פחות מ-10 תצפיות, מחזירים הודעת שגיאה
  if (nrow(filtered_df) < 10) {
    stop("Error: data is too short")
  }
  
  # יצירת רשימה לאחסון התוצאות
  results_list <- list()
  
  # לולאה על כל המשתנים ב-Data Frame
  for (var_name in colnames(filtered_df)) {
    # שליפת המשתנה מתוך ה-Data Frame
    var <- filtered_df[[var_name]]
    
    # בדיקה אם המשתנה הוא רציף (Numeric)
    if (class(var) %in% c("numeric", "integer")) {
      # חישוב סטטיסטיקות רציפות
      results_list[[var_name]] <- data.frame(
        Variable = var_name,
        Min = min(var, na.rm = TRUE),
        Max = max(var, na.rm = TRUE),
        Mean = mean(var, na.rm = TRUE),
        Level = NA,  # עמודות ריקות למשתנים רציפים
        Count = NA
      )
    }
    # בדיקה אם המשתנה הוא קטגוריאלי (Factor/Character)
    else if (class(var) %in% c("factor", "character")) {
      # חישוב שכיחויות של כל רמה
      freq_table <- as.data.frame(table(var))
      colnames(freq_table) <- c("Level", "Count")
      freq_table$Variable <- var_name
      freq_table$Min <- NA  # עמודות ריקות למשתנים קטגוריאליים
      freq_table$Max <- NA
      freq_table$Mean <- NA
      results_list[[var_name]] <- freq_table
    }
  }
  
  # שילוב כל התוצאות ל-Data Frame אחד
  results <- do.call(rbind, results_list)
  rownames(results) <- NULL  # הסרת שמות השורות
  return(results)
}
