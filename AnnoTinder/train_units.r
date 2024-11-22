
read_and_concatenate <- function(file_path) {
  instructies <- readLines(file_path, warn = FALSE)
  text_string <- paste(instructies, collapse = "\n")
  return(text_string)
}


intro_unit_1 = create_unit("welkom", 
                           set_markdown("intro",  read_and_concatenate('AnnoTinder/instructions/general_instructions.txt'), text_size = 1.5, align = 'center'), 
                           set_markdown("general_definitions", read_and_concatenate('AnnoTinder/instructions/general_definitions.txt'), text_size = 1.2, align = 'center', background = 'lightgrey', marginTop = '3rem'),
                           set_question('confirm', question = 'Ga door als u klaar bent met lezen', type='confirm'))


intro_unit_2 = create_unit("welkom2", 
                           set_markdown("intro",  
                                        "Voordat het volgende deel begint, oefenen we met een aantal Tweets.\nBeoordeel alstublieft de volgende Tweets:"),
                           set_question('confirm', question = 'Ga door als u klaar bent met lezen', type='confirm')) 



political_stance_training <- question("political_stance_training", 
                                      "Deze tweet reflecteert een rechts (in vergelijking tot links) politiek standpunt",
                                      instruction = read_and_concatenate("AnnoTinder/instructions/political_stance.txt")  , 
                                      codes = c( darkgrey = 'Niet waar',
                                                 grey = 'Neutraal', 
                                                 darkgrey = 'Waar'))

## sentiment
sentiment_training <- question("sentiment_training", 
                               "Deze tweet heeft een negatieve toon.",
                               instruction = read_and_concatenate("AnnoTinder/instructions/sentiment.txt") , 
                                      codes = c( darkgrey = 'Niet waar',
                                                 grey = 'Neutraal', 
                                                 darkgrey = 'Waar'))
## toxic
toxic_training <- question("toxic_training", 
                           "Deze tweet bevat toxische taal",
                           instruction = read_and_concatenate("AnnoTinder/instructions/toxic.txt")  , 
                                      codes = c( darkgrey = 'Niet waar',
                                                 grey = 'Neutraal', 
                                                 darkgrey = 'Waar'))
## misinformation
misinformation_training  <- question("misinformation_training", "Deze tweet bevat misinformatie.",
                                     instruction = read_and_concatenate("AnnoTinder/instructions/misinformation.txt")  , 
                                      codes = c( darkgrey = 'Niet waar',
                                                 grey = 'Neutraal', 
                                                 darkgrey = 'Waar'))

training_codebook <- create_codebook(political_stance_training, sentiment_training, toxic_training, misinformation_training)


train_unit_1 <- create_unit(
  'test vraag 1',
  type = 'train',
  codebook=training_codebook,
  set_text('text', 'We hebben NU een rechts kabinet nodig! Geen GL/PvdA! Stop die asielwaanzin en bouw meer woningen! Nederland kan niet langer naar die linkse flauwekul luisteren!'),
  set_train(variable = "sentiment_training", 
            value = 'Waar', 
            message = "Het sentiment van de tweet is negatief vanwege de negatieve en verontwaardigde toon die wordt uitgedrukt in de bewoordingen zoals 'geen GL/PvdA', 'stop die asielwaanzin' en 'luisteren naar die linkse flauwekul'. Deze bewoordingen geven een sterke afkeuring van linkse politieke ideeën en benadrukken de behoefte aan een rechts kabinet, wat duidt op een negatieve houding ten opzichte van linkse politieke partijen."), 
  set_train(variable = "political_stance_training", 
            value = 'Waar', 
            message = "Het politieke standpunt van deze tweet kan worden beschouwd als rechts of conservatief, vanwege de steun voor een rechts kabinet en de afwijzing van linkse partijen zoals GroenLinks (GL) en de Partij van de Arbeid (PvdA). De tweet drukt de wens uit voor beleid dat gericht is op het stoppen van wat wordt gezien als linkse maatregelen. Het suggereert een voorkeur voor conservatieve beleidsmaatregelen en een afkeer van progressieve of linkse initiatieven."),
  set_train(variable = "misinformation_training", 
            value = "Waar", 
            message = "De tweet bevat onjuiste beweringen, zoals het beschuldigen van 'linkse flauwekul' en het gebruik van termen als 'asielwaanzin'. Deze uitspraken zijn subjectief en overdreven, en ze geven mogelijk een vertekend beeld van de realiteit. Daarom kan worden geconcludeerd dat de tweet misinformatie bevat."), 
  set_train(variable = "toxic_training", 
            value = "Waar", 
            message = "Deze tweet bevat toxische taal omdat het negatieve bewoordingen gebruikt om een politiek standpunt over te brengen en andere politieke partijen bekritiseert op een respectloze manier"))


##=============

train_unit_2 <- create_unit('test vraag 2',
  type = 'train',
  set_text('text', 'Geweldig nieuws dat het gerechtshof heeft besloten dat de regering moet stoppen met de levering van F-35 onderdelen aan Israël. Eindelijk een stap in de richting van een rechtvaardiger buitenlands beleid dat de Palestijnse zaak serieus neemt. Dit geeft hoop voor een vreedzamere toekomst in het Midden-Oosten!'),
  codebook = training_codebook,
  set_train(variable = "sentiment_training", 
            value = 'Niet waar', 
            message = "Het sentiment van de tweet is positief omdat de auteur enthousiast reageert op het nieuws dat het gerechtshof heeft besloten om de levering van F-35 onderdelen aan Israël te stoppen. De auteur beschouwt dit als een stap in de richting van een rechtvaardiger buitenlands beleid en een serieuze erkenning van de Palestijnse zaak. De bewoordingen 'Geweldig nieuws' en 'Eindelijk een stap in de richting van een rechtvaardiger buitenlands beleid' geven aan dat de auteur het besluit toejuicht en hoopvol is over de mogelijke impact ervan op de toekomst van het Midden-Oosten."),
  set_train(variable = "political_stance_training", 
            value = 'Niet waar', 
            message = 'Het politieke standpunt van de tweet kan worden beschouwd als links of progressief. De auteur ondersteunt het besluit van het gerechtshof om de levering van F-35 onderdelen aan Israël stop te zetten en beschouwt dit als een stap in de richting van een rechtvaardiger buitenlands beleid. Door te spreken over een "rechtvaardiger buitenlands beleid" en de "Palestijnse zaak serieus te nemen", lijkt de auteur te pleiten voor een meer evenwichtige en empathische benadering van de kwestie Israël-Palestina, wat over het algemeen wordt geassocieerd met progressieve politieke standpunten.'), 
  set_train(variable = "misinformation_training", 
            value = 'Niet waar', 
            message = "De tweet bevat mogelijk geen misinformatie, aangezien het bericht gaat over een gerechtelijke beslissing en geen feitelijke onjuistheden lijkt te bevatten."),
  set_train(variable = "toxic_training",
            value = 'Niet waar',
            message = "De tweet lijkt niet toxisch te zijn, aangezien de boodschap positief is en hoopvolle perspectieven biedt voor een vreedzamere toekomst in het Midden-Oosten."))


lets_go_unit = create_unit("letsgo", 
                           set_markdown("intro",  
                                        "U heeft de oefenfase afgerond. U kunt nu doorgaan met de echte annotatiefase."),
                           set_question('confirm', question = 'Begin annotatiefase', type='confirm')) 

intro_units = c(intro_unit_1, intro_unit_2, train_unit_1,  train_unit_2, lets_go_unit)
