library(tidyverse)
txt <- read_lines("ocr-text/vrb1878_598.txt") |> 
  str_subset("\\<(gloss|lang|term)\\b")
txt <- txt |> 
  str_split("\\s+(?=\\<)") |> 
  unlist()

lang <- str_subset(txt, "\\<lang") |> 
  str_extract("(?<=\\>)[^<]+?(?=\\<\\/lang\\>)") |> 
  (\(x) tibble(lang = x))()
lang

lang_term_gloss <- str_subset(txt, "\\<gloss\\b") |> 
  str_extract_all("((?<=target\\=\")([^\"]+?)(?=\")|(?<=lang\\=\")([^\"]+?)(?=\")|(?<=\\>)([^<]+)(?=\\<))", 
                  simplify = TRUE) |> 
  as_tibble(.name_repair = "unique") |> 
  rename(lang = `...1`,
         german = `...2`,
         form = `...3`)
