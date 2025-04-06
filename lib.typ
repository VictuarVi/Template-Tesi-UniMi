#let sizes = (
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

#let document-state = state("TITLE_PAGE", true)

#let localization = yaml("utils/locale.yaml")

#let project(
  // Name of the university
  university: "Università degli Studi di Milano",
  // Path of the logo of the university
  unilogo: "img/unimi.svg",
  // Faculty, departament and course in which you are enrolled
  faculty: [Facoltà di Scienze e Tecnologie],
  department: [Dipartimento di Informatica \ Giovanni degli Antoni],
  cdl: [Corsi di Laurea Triennale in \ Corso di Laurea],
  // Title to be printed on the thesis
  printedtitle: {
    let typst = {
      set text(
        size: 1.05em,
        weight: "bold",
        fill: rgb("#239dad"),
      )
      box({
        text("t")
        text("y")
        h(0.035em)
        text("p")
        h(-0.025em)
        text("s")
        h(-0.015em)
        text("t")
      })
    }
    [Un template realizzato \ con #typst]
  },
  // Title to be left on metadata
  title: "Un template meraviglioso",
  // Type of thesis
  typeofthesis: "Elaborato Finale",
  // Author and corresponding fullname, serial number
  author: (
    name: "Nome Cognome",
    serial_number: "123456",
  ),
  // Dedication, acknowledgements
  dedication: "",
  acknowledgements: none,
  // Language of the thesis. This will change some prefixex (see utils/locale.yaml)
  language: "it",
  // Supervisors and cosupervisors
  supervisors: (
    "Prof. Enrico Fermi",
  ),
  cosupervisors: (
    "Prof. Ezio Auditore da Firenze",
    "Prof. Francesco Bianchi",
  ),
  // The academic year of the gradutation; defaults to the current year
  academicyear: "",
  body,
) = {
  set document(
    title: title,
    author: author.name,
  )

  set text(lang: language)
  set par(
    justify: true,
    spacing: 0.6em,
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
    numbering: none,

    // TODO is this actually correct?
    header-ascent: 1.03cm,
  )

  // TITLE PAGE
  // name of university, department, logo, course
  let logo(imagepath, height: 30mm) = {
    set align(center)
    image(
      height: height,
      imagepath,
    )
  }

  align(
    center,
    {
      text(size: sizes.LARGE, university) + linebreak()
      upper(faculty)
      v(0.0135 * paper.height)
      upper(department)
      v(0.02 * paper.height)
      logo(unilogo)
      v(0.0135 * paper.height)
      upper(cdl)
    },
  )

  // v(0.0168 * paper.height)
  v(1fr)

  // thesis printed title
  align(
    center,
    text(size: sizes.Large, upper(printedtitle)),
  )

  // v(0.0673 * paper.height)
  v(1fr)

  set text(size: sizes.large)

  // supervisors & co
  align(
    left,
    context {
      let relatori = ()
      for name in supervisors {
        let arr = (localization.at(text.lang).supervisor + ":", name)
        relatori.push(arr)
      }
      for name in cosupervisors {
        let arr = (localization.at(text.lang).cosupervisor + ":", name)
        relatori.push(arr)
      }
      grid(
        columns: 2,
        align: left,
        column-gutter: 0.5cm,
        row-gutter: 0.2cm,
        ..relatori.flatten()
      )
    },
  )

  v(0.0168 * paper.height)
  // v(1fr)

  // final composition
  align(
    right,
    box({
      context {
        set align(left)
        typeofthesis + " "
        localization.at(text.lang).type_of_thesis
        ":" + linebreak()
        author.name + linebreak()
        localization.at(text.lang).serial_number + " "
        author.serial_number
      }
    }),
  )

  // v(0.0337 * paper.height)
  v(1fr)

  // Default academic year = current year
  if (academicyear == "") {
    let current_year = datetime.today().year()
    academicyear = str(current_year) + [ -- ] + str(current_year + 1)
  }

  align(
    center,
    context {
      smallcaps({
        localization.at(text.lang).academic_year
        " "
        academicyear
      })
    },
  )

  // Dedication
  dedication

  // Acknowledgements
  if (acknowledgements != none) {
    localization.at(text.lang).acknowledgements
    acknowledgements
  }

  // Table of contents
  // to override stock indentation
  show outline.entry: it => {
    if it.element.func() == figure {
      let res
      if it.element.numbering != none {
        res = link(
          it.element.location(),
          it.indented(it.prefix(), [--- ] + it.element.body),
        )
      } else {
        res = link(
          it.element.location(),
          it.indented(it.prefix(), it.element.body),
        )
      }

      v(2.3em, weak: true)
      strong(text(size: 16pt, res))
    } else {
      it
    }
  }

  show outline.entry.where(level: 1): it => {
    v(19pt, weak: true)
    strong(it.indented(it.prefix(), it.element.body + h(1fr) + it.page()))
  }

  set heading(numbering: "1.1")

  // Page break before each heading 1, which is begin treated as a LaTeX's Chapter
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

  // Heading sizes
  show heading: it => {
    if (it.level == 1) {
      text(size: sizes.Large, it)
    }
    if (it.level == 2) {
      text(size: sizes.large, it)
    }
    if (it.level >= 3) {
      text(size: sizes.normalsize, it)
    }
    v(8pt)
  }

  // Itemize and Enumerate settings
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

  // Workaround to print links in monospaced font
  show link: it => {
    set text(font: "JetBrainsMono NF")
    it
  }

  // Body
  document-state.update("MAINMATTER")
  pagebreak()
  body
}

#let frontmatter(body) = {
  document-state.update("FRONTMATTER")
  set heading(numbering: none)

  body
}

#let acknowledgements(body) = {
  document-state.update("ACKNOWLEDGEMENTS")
  counter(page).update(0)
  set page(numbering: "i")

  body
}

#let mainmatter(body) = {
  document-state.update("MAINMATTER")
  set heading(numbering: "1.1")
  set page(
    numbering: "1",
    footer: { },
    header: context {
      let prefix = if (document-state.get() == "MAINMATTER") {
        localization.at(text.lang).chapter
      } else if (document-state.get() == "APPENDIX") {
        localization.at(text.lang).appendix
      }

      // Queries the heading FOR THE CURRENT PAGE
      let headings1 = query(selector(heading.where(level: 1))).filter(h1 => here().page() == h1.location().page())
      let before = query(selector(heading.where(level: 1)).before(here()))

      let number = 0
      let string = if (headings1.len() == 0) {
        if (document-state.get() == "APPENDIX") {
          number = counter(heading).display("A")
        } else {
          number = counter(heading.where(level: 1)).display()
        }
        // if there is no level 1 heading on the current page, print the last lvl 1 heading
        before.last().body
      } else if (headings1.last() == headings1.first()) {
        if (document-state.get() == "APPENDIX") {
          number = str(counter(heading).at(headings1.first().location()).at(0))
        } else {
          number = str(counter(heading).at(headings1.first().location()).at(0))
        }
        headings1.first().body
      }

      // combinining all
      upper(
        text(
          style: "italic",
          prefix + " " + str(number) + ". " + string,
        ),
      )
      h(1fr) + counter(page).display()
    },
  )

  body
}

#let appendix(body) = context {
  document-state.update("APPENDIX")
  counter(heading).update(0)
  set heading(numbering: "A.1")

  body
}

#let backmatter(body) = context {
  document-state.update("BACKMATTER")
  set heading(numbering: none)
  set page(header: none, footer: align(center, counter(page).display()))

  body
}

// Laboratories

#let lab(string) = context {
  if (text.lang == "it") {
    labprefix.it
  } else {
    labprefix.en
  }
}
#let llab(string) = { }
#let laburl(string) = { }
#let lablogo(string) = { }

#let labsizes = (
  space: 1mm,
  size: 25mm,
)

#let closingpage(laboratories) = context {
  set page(footer: none)
  pagebreak()
  v(1fr)
  set align(center)
  image(
    laboratories.logo,
    height: labsizes.size,
    width: labsizes.size,
  )

  localization.at(text.lang).lab_prefix + " "
  laboratories.name + linebreak()
  laboratories.company + linebreak()
  link("", laboratories.url)
}

// ADAPT Lab
#let adaptlab = {
  llab("ADAPT La")
  laburl("https://cazzola.di.unimi.it/adapt-lab.html")
  lablogo("immagini/loghi/adapt")
}
// AIS Lab - Sistemi Intelligenti Applicati
#let aislab = {
  lab("Laboratorio di Sistemi Intelligenti Applicati (AIS Lab")
  laburl("http://ais-lab.di.unimi.it")
  lablogo("immagini/loghi/aislab")
}
// AnacletoLab - Laboratorio di Biologia Computazionale e Bioinformatica
#let anacletolab = {
  llab("AnacletoLa")
  laburl("http://anacletolab.di.unimi.it")
  lablogo("immagini/loghi/anacleto")
}
// BiSP Lab - Biomedical Image and Signal Processing Lab
#let bisplab = {
  lab("Biomedical Image and Signal Processing (BiSP) La")
  laburl("https://bisp.di.unimi.it")
  lablogo("immagini/loghi/bisp")
}
// CONNETS - Computer Networks and Network Science Lab
#let connetslab = {
  lab("Computer Networks and Network Science (CONNETS) La")
  laburl("https://connets.di.unimi.it")
  lablogo("immagini/loghi/connets")
}
// EveryWare Lab - Data Management for Mobile and Pervasive Computing
#let everywarelab = {
  llab("EveryWare La")
  laburl("http://everywarelab.di.unimi.it")
  lablogo("immagini/loghi/everyware")
}
// FALSE Lab - Metodi Formali ed Algoritmi per Sistemi Large-Scale
// TODO ricontrollare
#let falselab = {
  lab("Formal methods and Algorithms for Large-Scale systEms (FALSE)")
  laburl("http://false.di.unimi.it")
  lablogo("immagini/loghi/false")
}
// IEBI Lab - Industrial, Environmental and Biometric Informatics Laboratory
// TODO ricontrollare
#let iebilab = {
  llab("Industrial, Environmental and Biometric Informatics (IEBI) Laboratory")
  laburl("http://iebil.di.unimi.it")
  lablogo("immagini/loghi/iebil")
}
// ISLab - Information Systems and Knowledge Management
// TODO ricontrollare
#let islab = {
  llab("Information Systems and Knowledge Management Laboratory (ISLab)")
  laburl("http://islab.di.unimi.it")
  lablogo("immagini/loghi/islab")
}
// LAILA - Laboratory of Artificial Intelligence and Learning Algorithms
// TODO ricontrollare
#let lailalab = {
  lab("Laboratory of Artificial Intelligence and Learning Algorithms (LAILA)")
  laburl("https://sites.google.com/view/lailaunimi")
  lablogo("immagini/loghi/laila")
}
// LALALab - Linguaggi, Automi, Logica Algebrica
#let lalalab = {
  lab("Laboratorio di Linguaggi, Automi, Logica Algebrica (LALALab)")
}
// LAW - Laboratorio di Algoritmica per il Web
#let lawlab = {
  lab("Laboratorio di Algoritmica per il Web (LAW)")
  laburl("http://law.di.unimi.it")
  lablogo("immagini/loghi/law")
}
// LaSER - System security and cryptography Lab
#let laserlab = {
  lab("System security and cryptography Lab (LaSER")
  laburl("https://security.di.unimi.it/")
  lablogo("immagini/loghi/laser")
}
// LIM - Laboratorio di Informatica Musicale
#let limlab = {
  lab("Laboratorio di Informatica Musicale (LIM")
  laburl("https://www.lim.di.unimi.it")
  lablogo("immagini/loghi/lim")
}
// MIPS Lab - Multimedia Interaction Perception and Social Lab
#let mipslab = {
  lab("Multimedia Interaction Perception and Social (MIPS) La")
  laburl("http://mips.di.unimi.it")
  lablogo("immagini/loghi/mips")
}
// OptLab - Laboratorio di Ricerca Operativa
#let optlab = {
  lab("Laboratorio di Ricerca Operativa (OptLab")
  laburl("http://optlab.di.unimi.it")
  lablogo("immagini/loghi/opt")
}
// PHuSe - Perceptual Computing and Human Sensing Lab
#let phuselab = {
  lab("Perceptual Computing and Human Sensing (PHuSe) La")
  laburl("http://phuselab.di.unimi.it")
  lablogo("immagini/loghi/phuse")
}
// PONG - Playlab for innovation in games
#let ponglab = {
  lab("Playlab for innovation in games (PONG")
  laburl("https://pong.di.unimi.it")
  lablogo("immagini/loghi/pong")
}
// SESAR Lab - SEcure Service-oriented Architectures Research Lab
#let sesarlab = {
  lab("SEcure Service-oriented Architectures Research (SESAR) La")
  laburl("http://sesar.di.unimi.it")
  lablogo("immagini/loghi/sesar")
}
// SPDP - Security, Privacy and Data Protection
#let spdplab = {
  lab("Security, Privacy and Data Protection (SPDP) La")
  laburl("http://spdp.di.unimi.it")
  lablogo("immagini/loghi/spdp")
}
