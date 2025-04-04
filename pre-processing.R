library(tidyverse)
library(maps)
library(ggrepel)

vrfiles <- dir("ocr-text", pattern = "^vrb", full.names = TRUE)

# Remember to edit the pattern to grep based on the updated, tagged OCR file.
inpfiles <- grep("(598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613)\\.txt", vrfiles, perl = TRUE, value = TRUE)
inpfiles
pages <- str_extract(inpfiles, "(?<=_)[0-9]{3}(?=\\.txt)")


# read the xml-tagged texts
# txt <- read_lines(inpfiles) |> 
#   str_subset("\\<(gloss|lang|term)\\b")

txt <- inpfiles |> 
  purrr::map(read_lines) |> 
  purrr::map(str_subset, "\\<(gloss|lang|term)\\b") |> 
  purrr::map(str_split, "\\s+(?=\\<)") |> 
  purrr::map(unlist)

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
  purrr::map(str_subset, "\\<lang") |> 
  purrr::map(str_extract, "(?<=\\>)[^<]+?(?=\\<\\/lang\\>)") |> 
  unlist() |> 
  unique() |> 
  (\(x) tibble(lang = x))() |>
  mutate(ID = row_number())

glottocode <- data.frame(Glottocode = c("._.", "._.", "._.", "Mentawai_ment1249", "Nias_nias1242", "Enggano_engg1245",
                "Gorontalo_goro1259", "._.", "Manombai_mano1275", "._.",
                "West Tarangan_west2538", "Kur_kurr1245", "Teor_teor1240", "._.",
                "Watubela_watu1247", "Geser-Gorom_gese1240", "Uruangnirin_urua1244", "Biak_biak1248", "Mansim_mans1260",
                "Hatam_hata1243", "Tobati_toba1266")) |> 
  mutate(ID = row_number()) |> 
  separate_wider_delim(Glottocode, delim = "_", names = c("Name", "Glottocode")) |> 
  mutate(across(where(is.character), \(x) if_else(x == ".", NA, x)))
# source for the glottocode: https://glottolog.org/resource/reference/id/112913


# get the relevant Glottocodes
read_csv("data/glottolog-languoids-glottolog-glottolog-d9da5e2.csv") |> 
  filter(Glottocode %in% glottocode$Glottocode) |> 
  write_tsv("data/glottolog-data.tsv")
glottoloc <- read_tsv("data/glottolog-data.tsv") |> 
  select(-ID)

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

lang <- lang |> left_join(lang_grp) |> 
  left_join(glottocode) |> 
  left_join(glottoloc) |> 
  mutate(Latitude = replace(Latitude, lang == "Banjak-Inseln",
                            2.316876),
         Longitude = replace(Longitude, lang == "Banjak-Inseln",
                             97.414167),
         Latitude = replace(Latitude, lang == "Singkel",
                            2.274181),
         Longitude = replace(Longitude, lang == "Singkel",
                             97.859914),
         Latitude = replace(Latitude, lang == "Togean-Inseln",
                            -0.389540),
         Longitude = replace(Longitude, lang == "Togean-Inseln",
                             121.934014),
         Latitude = replace(Latitude, lang == "Wonumbai", # it equals Sungai Manoembai (source: https://zookeys.pensoft.net/article/98097/)
                            -6.0251663460914235),
         Longitude = replace(Longitude, lang == "Wonumbai", # it equals Sungai Manoembai (source: https://zookeys.pensoft.net/article/98097/)
                             134.31429096241527),
         Latitude = replace(Latitude, lang == "Kei-Inseln",
                            -5.7497116289056835),
         Longitude = replace(Longitude, lang == "Kei-Inseln",
                             132.7304827976811))

lang

lang_vct <- unique(lang$lang)

## create a map image for the languages
### source: https://www.r-bloggers.com/2022/10/map-any-region-in-the-world-with-r-part-i-the-basic-map/
map_data_idn <- ggplot2::map_data("world")[ggplot2::map_data("world")$region == "Indonesia", ]
map_data_idn |> 
  ggplot() + 
  geom_polygon(aes(x = long, y = lat, group = group),
               fill = "pink") +
  theme_light() +
  coord_map() +
  coord_fixed(1.3) +
  ggrepel::geom_text_repel(data = filter(lang, !is.na(Latitude)),
                           aes(x = Longitude, y = Latitude,
                               label = if_else(is.na(Glottocode), str_c(lang, " (???)", sep = ""),
                                               str_c(lang, " (", Glottocode, ")", sep = ""))),
                           min.segment.length = 0.1) +
  labs(x = "Longitude",
       y = "Latitude",
       caption = "(???) means inexistent Glottocodes") +
  ggtitle("Languages mentioned in the source (von Rosenberg 1878)\nCodes inside the brackets are the Glottocodes")
ggsave("img/language-map.png", dpi = 600,
       width = 12, height = 8, units = "in")
  


# extract elements into tibble ====
names(txt) <- pages
pattern_to_extract <- "((?<=target\\=\")([^\"]+?)(?=\")|(?<=xml\\:lang\\=\")([^\"]+?)(?=\")|(?<=\\>)([^<]+)(?=\\<)|(?<=change\\=\")([^\"]+?)(?=\"\\>))"
lang_term_gloss <- txt |> 
  purrr::map(str_subset, "\\<gloss\\b") |> 
  purrr::map(str_extract_all, pattern_to_extract, simplify = TRUE) |> 
  purrr::map(as_tibble, .name_repair = "unique") %>% 
  purrr::map2(pages, ., ~mutate(.y, pp = .x)) |> 
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
  select(Pages = pp, Language = lang, Glottocode, LanguageGroup = Group, German = german, Forms = forms, OldFormOrig = form_orig, OldFormChange = form_change)

# handling the English translation of the German gloss
the_German <- read_lines("data/German_Gloss.txt")
the_English <- read_lines("data/English_Translation") # From DeepL translator
the_Indonesian <- read_lines("data/Indonesian_Translation") # From DeepL translator (German to Indonesian)
the_Gloss <- tibble(German = the_German, English = the_English, Indonesian = the_Indonesian)

# re-run this everytime a new page gets updated with tagging.
lang_term_gloss |> 
  # join the Gloss
  left_join(the_Gloss) |> 
  relocate(English, .after = German) |> 
  relocate(Indonesian, .after = English) |> 
  # relocate(Forms, .before = German) |> 
  write_tsv("data/vrosenberg1878.tsv")
