# Template per le tesi Statali

[Documento originale su Overleaf](https://www.overleaf.com/project/641879675262cde2a670826b).

Compilare con:

```shell
typst w main.typ --pdf-standard a-3b
```

# TODO

- [x] Header delle pagine col titolo del Capitolo corrente
- [x] Rendere "Capitolo"/"Appendice" modulare sulla base del `context` del documento
- [x] Formattazione elenchi
- [x] Tipologie di numbering per front-,main- e backmatter
- [ ] Togliere header ogni volta che c'è una Heading 1
- [x] Localizzazione più modulare
- [ ] Rimuovere indentazione del primo paragrafo per ogni heading1
- [ ] Mappare da Int a Characters (1 ==> A, 2 ==> B...)
