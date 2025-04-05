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

#let project(
  university: "Università degli Studi di Milano",
  unilogo: "img/unimi.svg",
  faculty: [Facoltà di Scienze e Tecnologie],
  department: [Dipartimento di Informatica \ Giovanni degli Antoni],
  cdl: [Laurea],
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
    [Un template serio realizzato \ con #typst]
  },
  title: "Un template serio",
  typeofthesis: "Elaborato Finale",
  author: (
    name: "Nome Cognome",
    matricola: "123456",
  ),
  // dedica
  dedication: "",
  // ringraziamenti
  acknowledgements: none,
  language: "it",
  supervisors: (
    "Relatore 1",
    "Relatore 2",
    "Relatore 2",
  ),
  co-supervisors: (
    "Corelatore 1",
    "Corelatore 2",
    "Corelatore 3",
  ),
  laboratories: (
    (
      name: [],
      url: "",
      logo: "",
    ),
    (
      name: [],
      url: "",
      logo: "",
    ),
  ),
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
  // show math.equation: set text(font: "Palatino")

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

    // da rivedere
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
    text(size: sizes.LARGE, university) + linebreak() + upper(faculty) + linebreak(),
  )

  v(1cm)

  align(
    center,
    upper(department)
      + linebreak()
      + logo(unilogo)
      + linebreak()
      + upper("Corso di Laurea Triennale in")
      + linebreak()
      + upper(cdl),
  )

  v(1cm)

  // thesis title
  align(
    center,
    text(size: sizes.Large, upper(printedtitle)),
  )

  v(1cm)

  // relatori & co
  align(
    left,
    context {
      let relatori = ()
      for name in supervisors {
        (
          if (text.lang == "it") {
            let arr = ("Relatore:", name)
            relatori.push(arr)
          } else {
            let arr = ("Supervisor:", name)
            relatori.push(arr)
          }
        )
      }
      for name in co-supervisors {
        (
          if (text.lang == "it") {
            let arr = ("Co-Relatore:", name)
            relatori.push(arr)
          } else {
            let arr = ("Co-Supervisor:", name)
            relatori.push(arr)
          }
        )
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

  v(1cm)

  // elaborato finale di...
  align(
    right,
    box({
      context {
        set align(left)
        typeofthesis
        if (text.lang == "it") {
          " di"
        } else {
          " by"
        }
        ":" + linebreak() + author.name + linebreak()
        if (text.lang == "it") {
          "Matr. Nr. "
        } else {
          "Matr. No. "
        }
        author.matricola
      }
    }),
  )

  v(1cm)

  if (academicyear == "") {
    let current_year = datetime.today().year()
    academicyear = str(current_year) + [ -- ] + str(current_year + 1)
  }

  align(
    center,
    context {
      smallcaps(
        if (text.lang == "it") {
          "Anno Accademico"
        } else {
          "Academic Year"
        }
          + " "
          + academicyear,
      )
    },
  )

  // DEDICA
  dedication

  // RINGRAZIAMENTI
  context if (acknowledgements != none) {
    if (text.lang == "it") {
      heading("Riconoscimenti", level: 1)
    } else {
      heading("Acknowledgements", 1)
    }
    acknowledgements
  }

  // TABLE OF CONTENTS
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

  // Interr. di pagina prima di ogni heading 1 ~ Chapter di LaTeX
  show heading.where(level: 1): it => {
    // set page(header: {})
    pagebreak()
    v(3cm)
    if (document-state.get() == "MAINMATTER") {
      if (text.lang == "it") {
        "Capitolo "
      } else {
        "Chapter "
      }
      counter(selector(heading)).display()
    } else if (document-state.get() == "APPENDIX") {
      if (text.lang == "it") {
        "Appendice "
      } else {
        "Appendix "
      }
      counter(selector(heading)).display()
    }
    v(10pt)
    set par(first-line-indent: 0em)
    it.body
  }

  show heading: it => {
    if (it.level == 1) {
      text(size: sizes.LARGE, it)
    }
    if (it.level == 2) {
      text(size: sizes.Large, it)
    }
    if (it.level == 3) {
      text(size: sizes.large, it)
    }
    if (it.level == 4) {
      text(size: sizes.normalsize, it)
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

  // BODY
  document-state.update("MAINMATTER")
  pagebreak()
  body
}

// #let faculty(string) = {
//   text(upper(string))
// }

// #let department(string) = {
//   text(upper(string))
// }

// #let cdl(string) = {
//   text(upper(string))
// }

// #let serialnumber(string) = context {
//   if (text.lang == "it") {
//     "Matr Nr."
//   } else {
//     "Matr. No."
//   }
//   string
// }

// #let matricola(string) = {
//   serialnumber(string)
// }

// #let typeofthesis(string) = context {
//   string
//   if (text.lang == "it") {
//     "di"
//   } else {
//     "by"
//   }
//   ":" + string
// }

// #let academicyear(string) = context {
//   if (text.lang == "it") {
//     "Anno Accademico"
//   } else {
//     "Academic year"
//   }
// }

#let language_selector(..args) = {
  if (text.lang == "it") {
    return args.pos().first()
  } else {
    return args.pos().last()
  }
}

// SEZIONI DEL DOCUMENTO

#let frontmatter(body) = {
  document-state.update("FRONTMATTER")
  set heading(numbering: none)

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
        if (text.lang == "it") {
          "Capitolo "
        } else {
          "Chapter "
        }
      } else if (document-state.get() == "APPENDIX") {
        if (text.lang == "it") {
          "Appendice "
        } else {
          "Appendix "
        }
      }

      let headings1 = query(selector(heading.where(level: 1))).filter(h1 => here().page() == h1.location().page())
      let before = query(selector(heading.where(level: 1)).before(here()))

      let number = 0
      let string = if (headings1.len() == 0) {
        if (document-state.get() == "APPENDIX") {
          number = counter(heading).display("A")
        } else {
          number = counter(heading).display()
        }
        before.last().body
      } else if (headings1.last() == headings1.first()) {
        if (document-state.get() == "APPENDIX") {
          number = str(counter(heading).at(headings1.first().location()).at(0))
        } else {
          number = str(counter(heading).at(headings1.first().location()).at(0))
        }
        headings1.first().body
      }

      // combine all
      upper(
        text(
          style: "italic",
          prefix + str(number) + ". " + string,
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

// LABORATORI PREDEFINITI

#let lab(string) = { }
#let llab(string) = { }
#let laburl(string) = { }
#let lablogo(string) = { }

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
