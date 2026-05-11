#import "@preview/simple-unimi-thesis:0.2.0": *

#show: unimi-thesis.with(
  title: "Thesis title",
  author: "Name Surname",
  serial-number: "123456",
  supervisors: (
    "Prof. Supervisor First",
  ),
  cosupervisors: (
    "Prof. Cosupervisor First",
  ),
  type-of-thesis: "Elaborato Finale",
  academic-year: [2026 --- 2027],
)

#show: frontmatter

// dedication

#dedication[
  #lorem(20)
]

// acknowledgements

#show: acknowledgements

= Acknowledgements

#lorem(100)

#toc // table of contents

#show: mainmatter

// main section of the thesis

= First chapter

#lorem(100)

= Second chapter

#lorem(100)

// appendix

#show: appendix

= First appendix

#lorem(100)

#show: backmatter

// bibliography

// associated laboratory
#closingpage()
