Digitised comparative word list derived from von Rosenberg’s “Der
Malayische Archipel: Land und Leute in Schilderungen, gesammelt während
eines driessig-jährigen Aufenhaltes in den Kolonien” from 1878.
================
Gede Primahadi Wijaya Rajeg
<a itemprop="sameAs" content="https://orcid.org/0000-0002-2047-8621" href="https://orcid.org/0000-0002-2047-8621" target="orcid.widget" rel="noopener noreferrer" style="vertical-align:top;"><img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon"></a>
& Daniel Krauße
<a itemprop="sameAs" content="https://orcid.org/0000-0002-9340-6960" href="https://orcid.org/0000-0002-9340-6960" target="orcid.widget" rel="noopener noreferrer" style="vertical-align:top;"><img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon"></a>

<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[<img src="file-oxweb-logo.gif" width="84"
alt="The University of Oxford" />](https://www.ox.ac.uk/)
[<img src="file-lingphil.png" width="83"
alt="Faculty of Linguistics, Philology and Phonetics, the University of Oxford" />](https://www.ling-phil.ox.ac.uk/)
[<img src="file-ahrc.png" width="325"
alt="Arts and Humanities Research Council (AHRC)" />](https://www.ukri.org/councils/ahrc/)
</br>*This work is part of the [AHRC-funded
project](https://app.dimensions.ai/details/grant/grant.12915105) on the
lexical resources for Enggano, led by the Faculty of Linguistics,
Philology and Phonetics at the University of Oxford, UK. Visit the
[central webpage of the Enggano
project](https://enggano.ling-phil.ox.ac.uk/)*.

<p xmlns:cc="http://creativecommons.org/ns#">

This work is licensed under
<a href="https://creativecommons.org/licenses/by-nc/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">Creative
Commons Attribution-NonCommercial 4.0 International
<img src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1" style="height:22px!important;margin-left:3px;vertical-align:text-bottom;"/><img src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1" style="height:22px!important;margin-left:3px;vertical-align:text-bottom;"/><img src="https://mirrors.creativecommons.org/presskit/icons/nc.svg?ref=chooser-v1" style="height:22px!important;margin-left:3px;vertical-align:text-bottom;"/></a>

</p>

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.14780144.svg)](https://doi.org/10.5281/zenodo.14780144)

<!-- badges: end -->

## Overview

The work in this repository ([Rajeg & Krauße
2024](#ref-Rajeg_Digitised_comparative_word_2024)) involves XML-tagging
the relevant words (with their respective languages and German gloss) in
the unstructured OCR output. The tagging is used to processed the OCR
into a
[tibble/table](https://github.com/complexico/vrosenberg1878/blob/main/data/vrosenberg1878.tsv).
The comparative word list in von Rosenberg
([1878](#ref-vonrosenberg1878)) includes words from the Enggano language
and they are included in the Shiny app of the
[*EnoLEX*](https://enggano.shinyapps.io/enolex/) database ([Krauße et
al. 2024](#ref-krausse_enolex_2024); [Rajeg, Krauße & Pramartha
2024](#ref-rajeg_enolex_2024)).

The column `OldFormOrig` in the
[table](https://github.com/complexico/vrosenberg1878/blob/main/data/vrosenberg1878.tsv)
contains the original form/spelling in the source text while the
`OldFormChange` contains the changes made (e.g., typo correction,
adjustment, OCR error fixing) on the original form/spelling.

The `English` and `Indonesian` columns are translations in the two
languages of the original German glosses of the forms. The translation
was performed using the DeepL web translator.

## Contributors

| Name                         | GitHub user | Description                                    | Role   |
|------------------------------|-------------|------------------------------------------------|--------|
| Rajeg, Gede Primahadi Wijaya | gederajeg   | Data Curator, XML-tagging, Software, Archiving | Author |
| Krauße, Daniel               |             | Data Curator                                   | Author |

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-krausse_enolex_2024" class="csl-entry">

Krauße, Daniel, Gede Primahadi Wijaya Rajeg, Cokorda Pramartha, Erik
Zobel, Charlotte Hemmings, I Wayan Arka & Mary Dalrymple. 2024. EnoLEX:
A diachronic lexical database of the Enggano language. Online database.
GitHub & Shiny web application: https://github.com/engganolang/enolex.
<https://enggano.shinyapps.io/enolex/>.

</div>

<div id="ref-Rajeg_Digitised_comparative_word_2024" class="csl-entry">

Rajeg, Gede Primahadi Wijaya & Daniel Krauße. 2024.
<span class="nocase">Digitised comparative word list derived from von
Rosenberg’s “Der Malayische Archipel: Land und Leute in Schilderungen,
gesammelt während eines driessig-jährigen Aufenhaltes in den Kolonien”
from 1878.</span> <https://github.com/complexico/vrosenberg1878>.

</div>

<div id="ref-rajeg_enolex_2024" class="csl-entry">

Rajeg, Gede Primahadi Wijaya, Daniel Krauße & Cokorda Pramartha. 2024.
EnoLEX: A diachronic lexical database for the Enggano language. In Ai
Inoue, Naho Kawamoto & Makoto Sumiyoshi (eds.), *AsiaLex 2024
proceedings: Asian Lexicography - Merging cutting-edge and established
approaches*, 123–132. Toyo University, Tokyo, Japan.
<https://doi.org/10.25446/oxford.27013864>.

</div>

<div id="ref-vonrosenberg1878" class="csl-entry">

Rosenberg, Carl Benjamin Hermann von. 1878. *Der malayische archipel:
Land und leute in schilderungen, gesammelt während eines
driessig-jährigen aufenhaltes in den kolonien*. Leipzig: Gustav Weigel.
<https://hdl.handle.net/2027/mdp.39015065356076>.

</div>

</div>
