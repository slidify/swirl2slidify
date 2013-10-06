process_q = function(q, course, templates){
  class(q) = as.character(q$type)
  if (class(q) %in% names(templates)){
    template = templates[[class(q)]]
  } else {
    template = templates[['text']]
  }
  render_template_(
    template = template,
    list(q = Filter(Negate(is.na), qParse(q, course)))
  )
}

swirl2slidify <- function(course, module){
  module <- getModule(course, module)
  templates <- getTemplates()
  slides <- paste(
    lapply(module, process_q, course = course, templates = templates),
    collapse = '\n\n'
  )
  deck <- render_template_(
    template = templates[['master']],
    list(slides = slides)
  )
  return(deck)
}

