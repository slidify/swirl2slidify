qParse <- function (x, ...) {
  UseMethod("qParse", x)
}

qParse.default <- function(x, course){
  x
}

qParse.figure <- function(x, course){
  x$code <- read_file_(
    file.path(course, 'Figures', x$figure),
    warn = F
  )
  return(x)
}

qParse.question_multiple <- function(x, course){
  require(stringr)
  x$Choices = gsub(
    paste0("^(", x$correct_answer, ')$'), 
    '_\\1_', 
    strsplit(x$choices, '\\;\\s*')[[1]], 
    perl = TRUE
  )
  x$choices = zip_vectors_(
    options = x$Choices,
    num = seq_along(x$Choices)
  )
  return(x)
}