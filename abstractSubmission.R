library(readxl)

dataAbs <- read_excel("Abstract submission.xlsx")

formatted_abstracts <- c()

# Loop through each row in the data
for(i in 1:nrow(dataAbs)){
  
  # Extract the data for the current row
  data <- dataAbs[i, ]
  
  # Create the formatted text block
  formatted_block <- paste0(
    '::: {.callout-caution collapse="true" icon="false" appearance="minimal"}\n',
    "### ", data$FirstName, " ", data$LastName, " - ", data$Title, "\n\n",
    data$Affiliation,"\n\n",
    "*",data$AuthorList,"*\n\n",
    data$AbstractText, "\n\n",
    ":::\n"
  )
  
  # Append the formatted block to the list of abstracts
  formatted_abstracts <- c(formatted_abstracts, formatted_block)
}

# Write all the formatted abstracts to a Quarto file
output_file <- "abstracts.qmd"
writeLines(formatted_abstracts, output_file)


