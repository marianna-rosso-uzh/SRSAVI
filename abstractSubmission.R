library(readxl)
library(tidyverse)

# Load the data
dataAbs <- read_excel("Abstract submission.xlsx")
dataTalks <- dataAbs %>% filter(TalkPoster == "Talk")
dataPoster <- dataAbs %>% filter(TalkPoster == "Poster")

# Initialize vectors for talks and posters
formatted_abstracts_talks <- c()
formatted_abstracts_posters <- c()

# Loop through each row for Talks and create formatted text blocks
for(i in 1:nrow(dataTalks)){
  
  # Extract the data for the current row
  data <- dataTalks[i, ]
  
  # Create the formatted text block for Talks
  formatted_block_talks <- paste0(
    '::: {.callout-caution collapse="true" icon="false" appearance="minimal" .talk}\n',
    "### ", data$FirstName, " ", data$LastName, " - ", data$Title, "\n\n",
    data$Affiliation, "\n\n",
    "*", data$AuthorList, "*\n\n",
    data$AbstractText, "\n\n",
    ":::\n"
  )
  
  # Append the formatted block to the list of Talks abstracts
  formatted_abstracts_talks <- c(formatted_abstracts_talks, formatted_block_talks)
}

# Loop through each row for Posters and create formatted text blocks
for(i in 1:nrow(dataPoster)){
  
  # Extract the data for the current row
  data <- dataPoster[i, ]
  
  # Create the formatted text block for Posters
  formatted_block_posters <- paste0(
    '::: {.callout-caution collapse="true" icon="false" appearance="minimal" .poster}\n',
    "### ", data$FirstName, " ", data$LastName, " - ", data$Title, "\n\n",
    data$Affiliation, "\n\n",
    "*", data$AuthorList, "*\n\n",
    data$AbstractText, "\n\n",
    ":::\n"
  )
  
  # Append the formatted block to the list of Posters abstracts
  formatted_abstracts_posters <- c(formatted_abstracts_posters, formatted_block_posters)
}

# Combine all formatted abstracts with section headers into a single vector
output_content <- c(
  "### Talks\n\n", 
  formatted_abstracts_talks, 
  "\n\n### Posters\n\n", 
  formatted_abstracts_posters
)

# Write the combined content to a single Quarto file
output_file <- "abstracts.qmd"
writeLines(output_content, output_file)
