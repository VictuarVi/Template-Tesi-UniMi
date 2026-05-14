#import "@preview/simple-unimi-thesis:0.2.0": *
#import "@preview/touying:0.7.3": *

#show: unimi-presentation.with(
  config-info(
    title: [Titolo della Presentazione],
    course: [Corso di Laurea],
    author: [Nome Cognome],
    serial-number: [123456],
    date: datetime.today(),
  ),
)

#set text(lang: "it")

#title-slide()

= Prima sezione

== Prima diapositiva

#lorem(20)

#lorem(20)

== Seconda diapositiva

#lorem(20)

#lorem(20)

= Seconda sezione

== Terza diapositiva

#columns[
  #for i in range(0, 6) {
    [- #lorem(15) #pause]
  }
]

#focus-slide("Grazie per l'ascolto.")
