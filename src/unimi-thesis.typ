/// LaTeX sizes to match original templates (https://tex.stackexchange.com/questions/24599/what-point-pt-font-size-are-large-etc)
/// -> dict
#let _sizes = (
  tiny: 0.5em,
  scriptsize: 0.7em,
  footnotesize: 0.8em,
  small: 0.9em,
  normalsize: 1em,
  large: 1.2em,
  Large: 1.44em,
  LARGE: 1.728em,
  huge: 2.074em,
  Huge: 2.488em,
)

#let document-state = state("init", "TITLE_PAGE")

#let localization = yaml("utils/locale.yaml")

/// Get the lvl. 1 heading in the current page. Returns an empty array if none are found.
/// -> array
#let _h1-current-page() = query(selector(heading.where(level: 1))).filter(h1 => (
  here().page() == h1.location().page()
))

/// Main styling function.
/// -> content
#let unimi-thesis(
  /// Name of the university.
  /// -> content | string
  university: "Università degli Studi di Milano",
  /// University logo.
  /// -> image
  unilogo: rect(height: 30mm, align(center + horizon, "UNIVERSITY\nLOGO\nPLACEHOLDER")),
  /// Name of the faculty (or school).
  /// -> string | content
  faculty: [Facoltà di Scienze e Tecnologie],
  /// Department of your faculty.
  /// -> string | content
  department: [Dipartimento di Informatica \ Giovanni degli Antoni],
  /// Degree course.
  /// -> string | content
  cdl: [Corsi di Laurea Triennale in \ Corso di Laurea],
  /// Printed title of the thesis, that is the one what will appear in the document.
  /// -> string | content
  printed-title: "",
  /// Metadata title.
  /// -> string
  title: "Un template meraviglioso",
  /// Type of thesis
  /// -> string
  type-of-thesis: "Elaborato Finale",
  /// Author name and surname.
  /// -> string
  author: "Nome Cognome",
  /// Author serial number.
  /// -> string
  serial-number: "123456",
  /// Language of the thesis. This will change some prefixes (see `locale.yaml`).
  /// -> string
  language: "it",
  /// Supervisor(s).
  /// -> array
  supervisors: (
    "Prof. Enrico Fermi",
  ),
  /// Cosupervisor(s).
  /// -> array
  cosupervisors: (
    "Prof. Ezio Auditore da Firenze",
    "Prof. Francesco Bianchi",
  ),
  /// The academic year of the graduation. If empty, defaults to the current year.
  /// -> content | string
  academic-year: "",
  body,
) = {
  set document(
    title: title,
    author: author,
  )

  set text(lang: language)
  set par(
    justify: true,
    spacing: 0.8em,
    first-line-indent: 1.2em,
  )

  let paper = (
    height: 24cm,
    width: 17cm,
  )

  set page(
    // height: 24cm,
    // width: 17cm,
    paper: "a4",
    margin: (
      top: 3cm,
      bottom: 3.1cm,
      left: 3.5cm,
      right: 2.5cm,
    ),
    numbering: "i",
    header-ascent: 1.03cm, // TODO is this actually correct?
    header: context {
      if (
        (document-state.get() in ("TITLE_PAGE", "FRONTMATTER", "ACKNOWLEDGEMENTS", "BACKMATTER"))
          // if there is a lvl 1 heading on the same page, the header must be empty
          or _h1-current-page().len() != 0
      ) {
        none
      } else if (document-state.get() in ("MAINMATTER", "APPENDIX")) {
        let heading-count = counter(heading).display(
          (..args) => numbering(
            heading.numbering,
            args.pos().first(),
          ),
        )

        let prefix = if document-state.get() == "MAINMATTER" { localization.at(text.lang).chapter } else {
          localization.at(text.lang).appendix
        }

        // if there is no level 1 heading on the current page, print the last lvl 1 heading
        let before = query(selector(heading.where(level: 1)).before(here()))
        let string = if (before.len() != 0) {
          before.last().body
        }

        upper(
          text(
            style: "italic",
            prefix + " " + str(heading-count) + ". " + string,
          ),
        )
        h(1fr) + counter(page).display()
      }
    },
    footer: context {
      // if there is a lvl 1 heading on the same page, the footer must display the page numbering at the bottom center
      if (_h1-current-page().len() != 0) {
        align(center, counter(page).display())
      }
    },
  )

  // TITLE PAGE

  align(
    center,
    {
      text(size: _sizes.LARGE, university) + linebreak()
      upper(faculty)
      v(0.0135 * paper.height)
      upper(department)
      v(0.02 * paper.height)
      unilogo
      v(0.0135 * paper.height)
      upper(cdl)
    },
  )

  // v(0.0168 * paper.height)
  v(1fr)

  if (printed-title == "") {
    printed-title = title
  }

  align(
    center,
    text(size: _sizes.Large, upper(printed-title)),
  )

  // v(0.0673 * paper.height)
  v(1fr)

  set text(size: _sizes.large)

  // (co)supervisors(s)
  align(
    left,
    context {
      let arr = ()
      for name in supervisors {
        let tmp = (localization.at(text.lang).supervisor + ":", name)
        arr.push(tmp)
      }
      for name in cosupervisors {
        let tmp = (localization.at(text.lang).cosupervisor + ":", name)
        arr.push(tmp)
      }
      grid(
        columns: 2,
        align: left,
        column-gutter: 0.5cm,
        row-gutter: 0.2cm,
        ..arr.flatten()
      )
    },
  )

  v(0.0168 * paper.height)
  // v(1fr)

  align(
    right,
    box({
      context {
        set align(left)
        type-of-thesis + " "
        localization.at(text.lang).type_of_thesis
        ":" + linebreak()
        author + linebreak()
        localization.at(text.lang).serial-number + " "
        serial-number
      }
    }),
  )

  // v(0.0337 * paper.height)
  v(1fr)

  // default academic year == current year
  if (academic-year == "") {
    let current_year = datetime.today().year()
    academic-year = str(current_year) + [ -- ] + str(current_year + 1)
  }

  align(
    center,
    context {
      smallcaps({
        localization.at(text.lang).academic_year
        " "
        academic-year
      })
    },
  )

  show outline.entry.where(level: 1): it => {
    v(19pt, weak: true)
    link(
      it.element.location(),
      strong(it.indented(it.prefix(), it.element.body + h(1fr) + it.page())),
    )
  }

  // page break before lvl.1 headings
  show heading.where(level: 1): it => {
    pagebreak()
    v(3cm)
    if (it.numbering != none) {
      if (document-state.get() == "MAINMATTER") {
        localization.at(text.lang).chapter
      } else if (document-state.get() == "APPENDIX") {
        localization.at(text.lang).appendix
      }
      " "
      counter(selector(heading)).display()
    }
    v(10pt)
    set par(first-line-indent: 0em)
    it.body
  }

  // heading sizes
  show heading: it => {
    if (it.level == 1) {
      text(size: _sizes.Large, it)
    }
    if (it.level == 2) {
      text(size: _sizes.large, it)
    }
    if (it.level >= 3) {
      text(size: _sizes.normalsize, it)
    }
    v(8pt)
  }

  set list(
    indent: 1.2em,
    tight: false,
    marker: (
      [•],
      [--],
      [\*],
    ),
  )

  show list: it => {
    set par(spacing: 1.2em)
    it
  }

  set enum(
    indent: 1.2em,
    tight: true,
    numbering: "1.a.i.",
  )

  show enum: it => {
    set par(spacing: 1.2em)
    it
  }

  show raw.where(block: true): it => {
    set text(font: "JetBrainsMono NF", weight: "light")
    align(
      center,
      block(
        // width: 100%,
        fill: rgb("#ebf1f5"),
        inset: 10pt,
        stroke: rgb("#9cc9e7"),
        // radius: 4pt,
        align(center, it),
      ),
    )
  }

  show figure.where(kind: "toc"): it => {
    align(start, it.body + v(1em))
  }

  // Body
  body
}

// Document sections

/// Frontmatter section. Similar to LaTeX's ```tex \frontmatter```. It sets
/// ```typc numbering: none``` for headings.
/// -> content
#let frontmatter(body) = {
  document-state.update("FRONTMATTER")
  set heading(numbering: none)

  body
}

/// Dedication sections. Sets the text alignment to right and its style to italic.
/// -> content
#let dedication(body) = {
  document-state.update("DEDICATION")
  pagebreak()
  set align(right)
  set text(style: "italic")

  body
}

/// Acknowledgements section. It sets page numbering to `"i"`.
/// -> content
#let acknowledgements(body) = {
  document-state.update("ACKNOWLEDGEMENTS")
  set page(numbering: "i")

  body
}

/// Mainmatter section. Similar to LaTeX's ```tex \mainmatter```. It sets to page numbering
/// to `"1"`, heading numbering to ```typc "1.1"``` and resets the page counter.
/// -> content
#let mainmatter(body) = {
  document-state.update("MAINMATTER")
  set page(numbering: "1")
  set heading(numbering: "1.1")
  counter(page).update(1)

  // Workaround to print links in monospaced font
  // after the TOC because the outline entries are links
  show link: set text(font: "JetBrainsMono NF", size: 0.8em)

  body
}

/// Appendix section. Similar to LaTeX's ```tex \appendix```. It sets heading numbering
/// to ```typc"A.1"``` and resets their counter.
/// -> content
#let appendix(body) = context {
  document-state.update("APPENDIX")
  counter(heading).update(0)
  set heading(numbering: "A.1")

  body
}

/// Backmatter section. Similar to LaTeX's ```tex \backmatter``.  It sets heading numbering
/// to ```typc none``` and changes the footer format.
/// -> content
#let backmatter(body) = context {
  document-state.update("BACKMATTER")
  set heading(numbering: none)
  set page(footer: align(center, counter(page).display()))

  body
}

// Table of Contents settings

// make the outline appear in the outline
#let list = figure.with(
  kind: "toc",
  numbering: none,
  supplement: none,
  outlined: true,
  caption: [],
)

#let target = (
  figure
    .where(
      kind: "toc",
      outlined: true,
    )
    .or(heading.where(outlined: true))
)

/// Custom table of contents. It also displays ```typc outline()```..
/// -> content
#let toc = context {
  set page(footer: align(center, counter(page).display()))
  outline(
    title: list(localization.at(text.lang).toc),
    indent: 1em,
    target: target,
  )
}

#let laboratories = yaml("utils/laboratories.yaml")

/// Display the laboratory involved in the thesis development.
/// -> content
#let closingpage(
  /// Name of the laboratory.
  /// -> string
  name: "Name",
  /// URL of the laboratory.
  /// -> string
  url: "https://laboratory.url",
  /// Logo of the laboratory.
  /// -> image
  logo: none,
) = context {
  set page(footer: none)
  set align(center)
  v(1fr)

  if logo == none {
    block(
      inset: 0.5em,
      stroke: black,
      align(
        center + horizon,
        "LAB\nLOGO",
      ),
    )
  } else {
    if type(logo) == str {
      image(height: 25mm, logo)
    } else {
      logo
    }
  }

  localization.at(text.lang).lab_prefix + " "
  name + linebreak()
  // laboratories.at(name).company + linebreak()
  link(url)
}
