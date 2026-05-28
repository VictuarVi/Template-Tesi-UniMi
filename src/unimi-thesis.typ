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

/// The current document section e.g. title page, mainmatter...).
/// -> state
#let _document-state = state("init", "TITLE_PAGE")

/// Localization dictionary.
/// -> dict
#let _localization = yaml("utils/locale.yaml")

/// Get the lvl. 1 heading in the current page. Returns an empty array if none are found.
/// -> array
#let _h1-current-page() = query(selector(heading.where(level: 1))).filter(h1 => (
  here().page() == h1.location().page()
))

/// The main thesis formatting function.
/// -> content
#let unimi-thesis(
  /// Name of the university.
  /// -> content | string
  university: "Università degli Studi di Milano",
  /// University logo.
  /// -> image
  unilogo: image(height: 30mm, "img/unimi-black.svg"),
  /// Name of the faculty (or school).
  /// -> string | content
  faculty: none,
  /// Department of your faculty.
  /// -> string | content
  department: none,
  /// Degree course.
  /// -> string | content
  course: none,
  /// Title of the thesis.
  /// -> string | content
  title: "Titolo della Tesi",
  /// Title in the metadata. Defaults to the title.
  /// -> string,
  title-metadata: none,
  /// Type of thesis
  /// -> string
  type-of-thesis: "Elaborato Finale",
  /// Author name and surname.
  /// -> string
  author: "",
  /// Author serial number.
  /// -> string
  serial-number: none,
  /// Language of the thesis.
  /// -> "it" | "en"
  language: "it",
  /// Supervisor(s).
  /// -> string | array
  supervisors: (),
  /// Cosupervisor(s).
  /// -> string | array
  cosupervisors: (),
  /// The academic year of the graduation.
  /// -> content | string
  academic-year: [2026 --- 2027],
  body,
) = {
  set document(
    title: if title-metadata == "" { title } else { title-metadata },
    author: author,
  )

  set text(
    font: "Libertinus Serif",
    lang: language,
  )
  set par(
    justify: true,
    spacing: 0.8em,
    first-line-indent: 1.2em,
  )

  set page(
    paper: "a4",
    margin: (
      top: 3cm,
      bottom: 3.1cm,
      left: 3.5cm,
      right: 2.5cm,
    ),
    numbering: "i",
    header-ascent: 1.03cm,
    header: context {
      if (
        (_document-state.get() in ("TITLE_PAGE", "FRONTMATTER", "ACKNOWLEDGEMENTS", "BACKMATTER"))
          // if there is a lvl 1 heading on the same page, the header must be empty
          or _h1-current-page().len() != 0
      ) {
        none
      } else if (_document-state.get() in ("MAINMATTER", "APPENDIX")) {
        let heading-count = counter(heading).display(
          (..args) => numbering(
            heading.numbering,
            args.pos().first(),
          ),
        )

        let prefix = if _document-state.get() == "MAINMATTER" { _localization.at(text.lang).chapter } else {
          _localization.at(text.lang).appendix
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
    footer: none,
  )

  // TITLE PAGE

  {
    align(
      center,
      context {
        text(size: _sizes.LARGE, university) + linebreak()
        upper(faculty)
        v(0.0135 * page.height)
        upper(department)
        v(0.02 * page.height)
        unilogo
        v(0.0135 * page.height)
        upper(course)
      },
    )

    // v(0.0168 * page.height)
    v(1fr)

    align(
      center,
      text(size: _sizes.Large, upper(title)),
    )

    // v(0.0673 * page.height)
    v(1fr)

    set text(size: _sizes.large)

    align(
      left,
      context {
        let arr = ()
        if type(supervisors) == array and supervisors.len() > 1 {
          for name in supervisors {
            arr.push((_localization.at(text.lang).supervisor + ":", name))
          }
        } else {
          arr.push((_localization.at(text.lang).supervisor + ":", supervisors))
        }
        if type(cosupervisors) == array and cosupervisors.len() > 1 {
          for name in cosupervisors {
            arr.push((_localization.at(text.lang).cosupervisor + ":", name))
          }
        } else {
          arr.push((_localization.at(text.lang).cosupervisor + ":", cosupervisors))
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

    context { v(0.0168 * page.height) }
    // v(1fr)

    align(
      right,
      box({
        context {
          set align(left)
          type-of-thesis + " "
          _localization.at(text.lang).type_of_thesis
          ":" + linebreak()
          author + linebreak()
          _localization.at(text.lang).serial-number + " "
          serial-number
        }
      }),
    )

    // v(0.0337 * paper.height)
    v(1fr)

    align(
      center,
      context {
        smallcaps({
          _localization.at(text.lang).academic_year
          " "
          academic-year
        })
      },
    )
  }

  set page(footer: context align(center, counter(page).display()))

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
      if (_document-state.get() == "MAINMATTER") {
        _localization.at(text.lang).chapter
      } else if (_document-state.get() == "APPENDIX") {
        _localization.at(text.lang).appendix
      }
      " "
      counter(selector(heading)).display()
    }
    v(10pt)
    set par(first-line-indent: 0em)
    it.body
  }

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
  _document-state.update("FRONTMATTER")
  set heading(numbering: none)

  body
}

/// Dedication sections. Sets the text alignment to right and its style to italic.
/// -> content
#let dedication(body) = {
  _document-state.update("DEDICATION")
  pagebreak()

  body
}

/// Acknowledgements section. It sets page numbering to `"i"`.
/// -> content
#let acknowledgements(body) = {
  _document-state.update("ACKNOWLEDGEMENTS")
  set page(numbering: "i", footer: context align(center, counter(page).display()))

  body
}

/// Mainmatter section. Similar to LaTeX's ```tex \mainmatter```. It sets to page numbering
/// to `"1"`, heading numbering to ```typc "1.1"``` and resets the page counter.
/// -> content
#let mainmatter(body) = {
  _document-state.update("MAINMATTER")
  set page(numbering: "1")
  set heading(numbering: "1.1")
  counter(page).update(1)

  // Workaround to print links in monospaced font
  // after the TOC because the outline entries are links
  // show link: set text(font: "JetBrainsMono NF", size: 0.8em)

  body
}

/// Appendix section. Similar to LaTeX's ```tex \appendix```. It sets heading numbering
/// to ```typc"A.1"``` and resets their counter.
/// -> content
#let appendix(body) = {
  _document-state.update("APPENDIX")
  counter(heading).update(0)
  set heading(numbering: "A.1")

  body
}

/// Backmatter section. Similar to LaTeX's ```tex \backmatter``.  It sets heading numbering
/// to ```typc none``` and changes the footer format.
/// -> content
#let backmatter(body) = {
  _document-state.update("BACKMATTER")
  set heading(numbering: none)
  set page(footer: context align(center, counter(page).display()))

  body
}

// Table of Contents settings

// make the outline appear in the outline
#let _toc-figure = figure.with(
  kind: "toc",
  numbering: none,
  supplement: none,
  outlined: true,
  caption: [],
)

#let _target = (
  figure
    .where(
      kind: "toc",
      outlined: true,
    )
    .or(heading.where(outlined: true))
)

/// Custom table of contents. It displays ```typc outline()``` as if it were a normal
/// lvl. 1 heading.
/// -> content
#let toc = context {
  outline(
    title: _toc-figure(_localization.at(text.lang).toc),
    indent: 1em,
    target: _target,
  )
}

/// Ready-made laboratories.
/// -> dictionary
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

  _localization.at(text.lang).lab_prefix + " "
  name + linebreak()
  // laboratories.at(name).company + linebreak()
  link(url)
}
