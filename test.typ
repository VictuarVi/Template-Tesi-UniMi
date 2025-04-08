#let labsizes = (
  space: 1mm,
  size: 25mm,
)

#let closingpage(name, laboratories) = context {
  set page(footer: none)
  // pagebreak()
  v(1fr)
  set align(center)
  image(
    laboratories.at(name).logo,
    height: labsizes.size,
    width: labsizes.size,
  )

  localization.at(text.lang).lab_prefix + " "
  laboratories.at(name).name + linebreak()
  // laboratories.at(name).company + linebreak()
  link("", laboratories.at(name).url)
}

#let miolab = yaml("fiero.yml")

#closingpage("aislab", miolab)
