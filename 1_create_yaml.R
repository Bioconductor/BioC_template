
gsheet <- 'https://docs.google.com/spreadsheets/d/1tGtGffcbCRxQFjE3ej42IcWlN4FJCsuQeZvETt9g0oA/gviz/tq?tqx=out:csv&sheet=schedule_table'
fname <- tempfile()
download.file(url = gsheet, destfile = fname, quiet = TRUE)
data <- read.csv(fname)
discard_lgl <- vapply(data, function(x) all(is.na(x)), logical(1))
data <- data[,!discard_lgl]
data$time <- sub("^.+ (.+):00", "\\1", data$time)

output_dir <- 'data/abstracts/'

if (!file.exists(output_dir)) {
    message('Creating yaml files in ', output_dir, '.')
    dir.create(output_dir)
} else {
    message('Replacing content in ', output_dir, '.')
    unlink(output_dir, recursive = TRUE)
    dir.create(output_dir)
}

for (i in 1:nrow(data)) {
    one_row <- data[i,, drop = FALSE]
    yaml_filename <- paste0(
        one_row$day, "_",
        one_row$time, "_",
        one_row$session_type, "_",
        one_row$paper,
        '.yaml'
    ) |> 
        {\(y) gsub(" |:", '', y)}() |> 
        {\(y) sub('_.yaml$', '.yaml', y)}()
    
    for (j in seq_along(one_row)) {
        
        one_value_name <- names(one_row)[j]
        one_value <- one_row[j]
        
        if (one_value_name == 'abstract') {
            one_value <- gsub('"', '', one_value)
        }
        
        one_value <- paste0("\"", one_value, "\"")
        
        if (one_value_name == "talks" && any(grepl("paper", one_value))) {
            one_value <- sub("^\"(.+)\"$", "\\1", one_value)
        }
        
        line <- paste0(one_value_name, ": ", one_value)
        filename <- paste0(output_dir, yaml_filename)
        
        if (j == 1) {
            write.table(
                x = line, col.names = FALSE, row.names = FALSE, 
                file = filename, append = FALSE, quote = FALSE
            )
        } else {
            write.table(
                x = line, col.names = FALSE, row.names = FALSE, 
                file = filename, append = TRUE, quote = FALSE
            )
        }
    }
}