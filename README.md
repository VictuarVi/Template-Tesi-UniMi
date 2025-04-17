# unimi-thesis 🎓

This template is the result of the conversion from the [original LaTeX template](https://www.overleaf.com/project/641879675262cde2a670826b).

## Preview ✨

<p align="center">
  <img alt="Frontispiece/First page" src="thumbnail.png" width="45%">
</p>

> [!TIP]
> See `docs/instructions.pdf` for more informations about the template.

## Usage 🚀

Compile with con:

```shell
typst c main.typ --pdf-standard a-3b
```

> [!WARNING]
> The generated PDF _must be_ PDF/A compliant.

The following is the canonical example of how the template can be structured:

```typ
#import "@preview/unimi-thesis:1.0.0": *

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

```

# TODO 📝

- [x] Header delle pagine col titolo del Capitolo corrente
- [x] Rendere "Capitolo"/"Appendice" modulare sulla base del `context` del documento
- [x] Formattazione elenchi
- [x] Tipologie di numbering per front-,main- e backmatter
- [x] Togliere header ogni volta che c'è una Heading 1
  - [x] Mappare da Int a Characters (1 ==> A, 2 ==> B...) | Non serve più perché questo problema si poneva solo con la prima pagina delle appendici, ma comunque non dev'essere stampata
  - [x] Centralizzare la gestione dell'header mediante gli stati da UNA SOLA FUNZIONE in `project`
- [x] Localizzazione più modulare
- [ ] Rimuovere indentazione del primo paragrafo per ogni heading1
- [ ] Aggiungere un workflow per la preview del template in Github pages (vedi [qui](https://github.com/VictuarVi/wt-intellij-guide))
- [x] Dizionario per i laboratori
- [x] Aggiornare istruzioni (si parla di LaTeX & Co quando non serve più)
