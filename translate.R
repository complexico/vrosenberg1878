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

# Error in `mutate()`:
#   ℹ In argument: `English = deeplr::translate2(...)`.
# Caused by error in `purrr::pmap_chr()`:
#   ℹ In index: 31.
# Caused by error in `response_check()`:
#   ! Too many requests. Please wait and resend your request.
# Run `rlang::last_trace()` to see where the error occurred.

# There is the above error, hence decided to do it manually on DeepL page

the_English <- vector(mode = "character", length = length(the_German))

for (i in seq_along(the_German)) {
  
  the_English[i] <- deeplr::translate2(the_German[i],
                                       target_lang = "EN",
                                       source_lang = "DE",
                                       auth_key = deeplAPIkey)
  
}
