#import "utils.typ": *
#import "presentami.typ": _make-logo

#let frontispieces = (
  "alternate": (
    university,
    faculty,
    department,
    unilogo,
    course,
    title,
    subtitle,
    supervisors,
    cosupervisors,
    thesis-type,
    author,
    serial-number,
    academic-year,
  ) => page(
    footer: none,
    {
      set align(center + top)

      // image(
      //   "img/unimi-black.svg",
      //   height: 40mm
      // )
      {
        set par(spacing: 0cm)
        scale(80%, _make-logo(color: black))
        set text(size: 1.7em, font: "Liberation Serif")

        if faculty != none {
          upper(faculty)
        }

        // if faculty != none {
        //   parbreak()
        //   upper(department)
        // }

        // if course != none {
        //   parbreak()
        //   upper(course)
        // }
      }

      // image(unilogo)
      // unilogo

      v(1.5cm)

      block(
        width: 100%,
        stroke: (bottom: black),
        inset: (bottom: 2em),
        text(
          size: 3.5em,
          weight: 500,
          smallcaps(title),
        ),
      )

      if subtitle != none {
        align(
          right,
          block(
            width: 70%,
            text(
              size: 1.6em,
              style: "italic",
              subtitle,
            ),
          ),
        )
      }

      v(4em)

      {
        set text(size: 1.3em)
        set align(left)

        // emph("A cura di")
        set text(size: 1.1em)
        parbreak()
        // "Laureando: " + author
        smallcaps(author)
        if serial-number != none {
          parbreak()
          "Matricola: " + serial-number
        }

        if course != none {
          parbreak()
          course
        }

        set align(right)
        if supervisors != none {
          v(2em)
          _show-starvisor(supervisors, "supervisor")
        }
        if cosupervisors != none {
          _show-starvisor(cosupervisors, "supervisor")
        }

        if department != none {
          parbreak()
          // emph(department)
          department
        }
      }

      set align(bottom + center)

      text(
        size: 1.2em,
        smallcaps({
          "Anno Accademico "
          if type(academic-year) == datetime {
            let current-year = academic-year.year()
            str(current-year - 1) + [ --- ] + str(current-year)
          } else {
            academic-year
          }
        }),
      )
    },
  ),
  "lim": (
    university,
    faculty,
    department,
    unilogo,
    course,
    title,
    supervisors,
    cosupervisors,
    thesis-type,
    author,
    serial-number,
    academic-year,
  ) => page(
    footer: none,
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
        {
          _show-starvisor(supervisors, "supervisor")
          _show-starvisor(cosupervisors, "cosupervisor")
        },
      )

      context { v(0.0168 * page.height) }
      // v(1fr)

      align(
        right,
        box({
          context {
            set align(left)
            if author != none {
              thesis-type + " "
              _localization.at(text.lang).type_of_thesis
              ":" + linebreak()
              author + linebreak()
            }
            if serial-number != none {
              _localization.at(text.lang).serial-number + " "
              serial-number
            }
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
    },
  ),
)

