#import "lib.typ": *

#show: project.with(language: "it")

#show: frontmatter.with()

#include "sections/dedica.typ"

#show: acknowledgements.with()

#include "sections/ringraziamenti.typ"

#outline(indent: 1em)

#show: mainmatter.with()

#include "sections/introduzione.typ"
#include "sections/argomento_1.typ"
#include "sections/argomento_2.typ"
#include "sections/argomento_3.typ"

#show: appendix.with()

#include "sections/appendice_1.typ"
#include "sections/appendice_2.typ"

#show: backmatter.with()

#bibliography(full: true, "bibliografia.bib")

#closingpage("adaptlab")
