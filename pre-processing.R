library(tidyverse)

vrfiles <- dir("ocr-text", pattern = "^vrb", full.names = TRUE)

inpfiles <- grep("598\\.txt", vrfiles, perl = TRUE, value = TRUE)
inpfiles


# read the xml-tagged texts
txt <- read_lines(inpfiles) |> 
  str_subset("\\<(gloss|lang|term)\\b")
txt <- txt |> 
  str_split("\\s+(?=\\<)") |> 
  unlist()


# process the languages ====
lang <- str_subset(txt, "\\<lang") |> 
  str_extract("(?<=\\>)[^<]+?(?=\\<\\/lang\\>)") |> 
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
lang_vct <- lang$lang

# extract elements into tibble ====
lang_term_gloss <- str_subset(txt, "\\<gloss\\b") |> 
  str_extract_all("((?<=target\\=\")([^\"]+?)(?=\")|(?<=xml\\:lang\\=\")([^\"]+?)(?=\")|(?<=\\>)([^<]+)(?=\\<)|(?<=change\\=\")([^\"]+?)(?=\"\\>))", 
                  simplify = TRUE) |> 
  as_tibble(.name_repair = "unique") |> 
  rename(lang = `...1`,
         german = `...2`,
         form_orig = `...3`,
         form_change = `...4`) |> 
  left_join(select(lang, -ID)) |> 
  mutate(lang = factor(lang, levels = lang_vct)) |> 
  arrange(german, lang)
