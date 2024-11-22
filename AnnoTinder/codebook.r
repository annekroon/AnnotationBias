## main codebook annotation

read_and_concatenate <- function(file_path) {
  instructies <- readLines(file_path, warn = FALSE)
  text_string <- paste(instructies, collapse = "\n")
  return(text_string)
}


## misinformation
stellingen <- question("stellingen", 
                  "In hoeverre zijn de volgende stellingen waar?",
             type='scale',
             instruction = read_and_concatenate("AnnoTinder/instructions/instructions_variables.txt")  , 
             items = list(
               political_stance = "Deze tweet reflecteert een rechts (in vergelijking tot links) politiek standpunt.",
               sentiment = "Deze tweet heeft een negatieve toon.",
               toxic = "Deze tweet bevat toxische taal.",
               misinformation = "Deze tweet bevat misinformatie."
             ),
             codes = c( 'Helemaal niet waar', 
                        'Gedeeltelijk niet waar', 
                        'Neutraal', 
                        'Gedeeltelijk waar',
                        'Helemaal waar'))

codebook <- create_codebook(stellingen)
