library(tidyverse)

vrfiles <- dir("ocr-text", pattern = "^vrb", full.names = TRUE)

# Remember to edit the pattern to grep based on the updated, tagged OCR file.
inpfiles <- grep("(598|599|600|601|602|603)\\.txt", vrfiles, perl = TRUE, value = TRUE)
inpfiles
pages <- str_extract(inpfiles, "(?<=_)[0-9]{3}(?=\\.txt)")


# read the xml-tagged texts
# txt <- read_lines(inpfiles) |> 
#   str_subset("\\<(gloss|lang|term)\\b")

txt <- inpfiles |> 
  map(read_lines) |> 
  map(str_subset, "\\<(gloss|lang|term)\\b") |> 
  map(str_split, "\\s+(?=\\<)") |> 
  map(unlist)

# txt <- txt |> 
#   str_split("\\s+(?=\\<)") |> 
#   unlist()


# process the languages ====
# lang <- str_subset(txt, "\\<lang") |> 
#   str_extract("(?<=\\>)[^<]+?(?=\\<\\/lang\\>)") |> 
#   unique() |> 
  # (\(x) tibble(lang = x))() |>
  # mutate(ID = row_number())

lang <- txt |> 
  map(str_subset, "\\<lang") |> 
  map(str_extract, "(?<=\\>)[^<]+?(?=\\<\\/lang\\>)") |> 
  unlist() |> 
  unique() |> 
  (\(x) tibble(lang = x))() |>
  mutate(ID = row_number())

lang
lang_grp <- tribble(~ID, ~Group,
                    1, "Sumātra",
                    2, "Sumātra",
                    3, "Inselgruppen weftlich von Sumātra",
                    4, "Inselgruppen weftlich von Sumātra",
                    5, "Inselgruppen weftlich von Sumātra",
                    6, "Inselgruppen weftlich von Sumātra",
                    7, "Selēbes",
                    8, "Selēbes",
                    9, "Aru-Inseln",
                    10, "Aru-Inseln",
                    11, "Aru-Inseln",
                    12, "Südofter-Inseln",
                    13, "Südofter-Inseln",
                    14, "Südofter-Inseln",
                    15, "Südofter-Inseln",
                    16, "Südofter-Inseln",
                    17, "Neuguinea",
                    18, "Neuguinea",
                    19, "Neuguinea",
                    20, "Neuguinea",
                    21, "Neuguinea")

lang <- lang |> left_join(lang_grp)
lang_vct <- unique(lang$lang)

# extract elements into tibble ====
names(txt) <- pages
pattern_to_extract <- "((?<=target\\=\")([^\"]+?)(?=\")|(?<=xml\\:lang\\=\")([^\"]+?)(?=\")|(?<=\\>)([^<]+)(?=\\<)|(?<=change\\=\")([^\"]+?)(?=\"\\>))"
lang_term_gloss <- txt |> 
  map(str_subset, "\\<gloss\\b") |> 
  map(str_extract_all, pattern_to_extract, simplify = TRUE) |> 
  map(as_tibble, .name_repair = "unique") %>% 
  map2(pages, ., ~mutate(.y, pp = .x)) |> 
  list_rbind() |> 

# lang_term_gloss <- str_subset(txt, "\\<gloss\\b") |> 
#   str_extract_all("((?<=target\\=\")([^\"]+?)(?=\")|(?<=xml\\:lang\\=\")([^\"]+?)(?=\")|(?<=\\>)([^<]+)(?=\\<)|(?<=change\\=\")([^\"]+?)(?=\"\\>))", 
#                   simplify = TRUE) |> 
#   as_tibble(.name_repair = "unique") |> 
  
  rename(lang = `...1`,
         german = `...2`,
         form_orig = `...3`,
         form_change = `...4`) |> 
  left_join(select(lang, -ID)) |> 
  mutate(lang = factor(lang, levels = lang_vct)) |> 
  arrange(pp, german, lang) |> 
  mutate(form_change = replace_na(form_change, "")) |> 
  mutate(forms = if_else(form_change == "", form_orig, form_change)) |> 
  select(Pages = pp, Language = lang, LanguageGroup = Group, German = german, Forms = forms, OldFormOrig = form_orig, OldFormChange = form_change)

# re-run this everytime a new page gets updated with tagging.
lang_term_gloss |> 
  write_tsv("data/vrosenberg1878.tsv")
