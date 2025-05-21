#import "@preview/modern-unimi-thesis:1.0.0": *

#show: project.with(
  language: "en",
)

#show: frontmatter.with()

// dedication

#show: acknowledgements.with()

// acknowledgements
= Acknowledgements

#lorem(100)

#toc // table of contents

#show: mainmatter.with()

// main section of the thesis

= First chapter

#lorem(100)

#lorem(100)

= Second chapter

#lorem(100)

#lorem(100)

#show: appendix.with()

// appendix

#show: backmatter.with()

// bibliography

// associated laboratory

// if the laboratory you want to cite is missing:
#let missinglab = yaml("myoverride.yml")
#closingpage("mylab", laboratories: missinglab)
