# G. Rajeg (2024-2025)
## Personal note: Ensure that the code `pre-processing.R` has been run first to make `lang_term_gloss` data frame available here.
source("deepl-API-key.R")
# library(deeplr)
the_German <- lang_term_gloss |> 
  pull(German) |> 
  unique()
the_German_df <- tibble(German = the_German)
the_German_df <- the_German_df |> 
  mutate(English = deeplr::translate2(German, target_lang = "EN",
                                      source_lang = "DE",
                                      auth_key = deeplAPIkey,
                                      preserve_formatting = TRUE))

the_English <- vector(mode = "character", length = length(the_German))

for (i in seq_along(the_German)) {
  
  the_English[i] <- deeplr::translate2(the_German[i],
                                       target_lang = "EN",
                                       source_lang = "DE",
                                       auth_key = deeplAPIkey)
  
}
