#import "@local/unimi-thesis:1.0.0": *

#show: project.with(language: "en")

#show: frontmatter.with()

// dedication

#show: acknowledgements.with()

// acknowledgements

#toc

#show: mainmatter.with()

// main section of the thesis

#show: appendix.with()

// appendix

#show: backmatter.with()

// bibliography

// associated laboratory
#closingpage("adaptlab")

// if there is the missing laboratory add it like this
// #let missinglab = yaml("myoverride.yml")
// #closingpage("mylab", laboratories: missinglab)
