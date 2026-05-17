#import "@preview/simple-unimi-thesis:0.2.0": *
#import "@preview/zebraw:0.6.3": *

#show: zebraw.with(numbering: false, inset: (left: 1.25em))
#show: unimi-presentation.with(
  config-info(
    title: [Manuale di `unimi-presentation`],
    author: [Vittorio Robecchi],
    date: datetime.today(),
  ),
)

#set text(lang: "it")

#title-slide()

= Introduzione

== Titolo

- È necessario compilare le seguenti informazioni in ```typ #config-info()``` all'inizio della presentazione:
  ```typ
  #show: unimi-presentation.with(
    config-info(
      title: [Titolo della Presentazione],
      course: [Corso di Laurea],
      author: [Nome Cognome],
      serial-number: [123456],
      date: datetime.today(),
    ),
  )
  ```

- Impostare la lingua:
  ```typ
  #set text(lang: "it")
  ```

- Sia la diapositiva del titolo che quelle normali faranno riferimento a quei dati; rispettivamente per tutto e solo per autore, titolo

- Essa è chiamabile mediante ```typ #title-slide()``` e generalmente si piazza appena dopo la precedente funzione

== Comandi generali

- La presentazione si può dividere in sezioni e diapositive, rispettivamente utilizzando i titoli di livello 1 (```typ =```) e 2 (```typ ==```)

- Il titolo della sezione sarà quello del titolo corrispondente

- Ogni volta che si cambia sezione, viene invocato l'indice con il titolo corrente evidenziato, mentre gli altri leggermente sbiaditi

= Realizzazione della presentazione

== Punti a elenco

- Una tipica diapositiva è costituita da punti a elenco che vengono mostrati uno per volta #pause

- I punti a elenco si scrivono come segue:
  ```typ
  - Primo
  - Secondo
  ``` #pause

- Per farli apparire uno per diapositiva, Touying offre la funzione ```typ #pause```:
  ```typ
  - Primo #pause
  - Secondo #pause
  ``` #pause

- Si noti come il numero della diapositiva sia rimasto il medesimo

== Colonne

#columns[
  - Spesso è utile disporre il contenuto in un certo numero di colonne in base alla necessità #pause

  - Typst offre la funzione ```typ #columns(n)```, che distruibuisce il contenuto su più colonne in base al `n`umero specificato #pause

  #colbreak()

  - Inoltre è utile utilizzare anche ```typ #colbreak()``` per l'interruzione di colonna #pause

  - Touying invece offre ```typc #components.adaptive-columns()```, che distruibuisce il contenuto  su diverse colonne in base alle dimensioni
]

== Conclusione

- Generalmente le presentazioni terminano con una singola dispositiva che scrive "Grazie per l'attenzione" o auguri affini #pause

- La funzione per questo scopo è ```typc #focus-slide(content)```, dove `content` è la frase di chiusura

#focus-slide("Grazie per l'attenzione.")
