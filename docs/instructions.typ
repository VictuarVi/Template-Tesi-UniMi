#import "@local/unimi-thesis:1.0.0": *

#show: project.with(language: "it")

#show: frontmatter.with()

#include "sections/dedica.typ"

#show: acknowledgements.with()

#include "sections/ringraziamenti.typ"

#toc

#show: mainmatter.with()

#include "sections/1_introduzione.typ"
#include "sections/2_stato_dellarte.typ"
#include "sections/3_tecnologie.typ"
#include "sections/4_nome.typ"
#include "sections/5_test.typ"
#include "sections/6_conclusioni.typ"

#show: appendix.with()

#include "sections/A1_tirocinio.typ"
#include "sections/A2_documenti.typ"

#show: backmatter.with()

#bibliography(full: true, "bibliografia.bib")

#closingpage("adaptlab")
