# Template per le tesi Statali

[Documento originale su Overleaf](https://www.overleaf.com/project/641879675262cde2a670826b).

Compilare con:

```shell
typst c main.typ --pdf-standard a-3b --font-path fonts
```

# TODO

- [x] Header delle pagine col titolo del Capitolo corrente
- [x] Rendere "Capitolo"/"Appendice" modulare sulla base del `context` del documento
- [x] Formattazione elenchi
- [x] Tipologie di numbering per front-,main- e backmatter
- [x] Togliere header ogni volta che c'è una Heading 1
  - [x] Mappare da Int a Characters (1 ==> A, 2 ==> B...) | Non serve più perché questo problema si poneva solo con la prima pagina delle appendici, ma comunque non dev'essere stampata
  - [x] Centralizzare la gestione dell'header mediante gli stati da UNA SOLA FUNZIONE in `project`
- [x] Localizzazione più modulare
- [ ] Rimuovere indentazione del primo paragrafo per ogni heading1
- [ ] Aggiungere un workflow per la preview del template in Github pages
- [x] Dizionario per i laboratori
- [ ] Aggiornare istruzioni (si parla di LaTeX & Co quando non serve più)