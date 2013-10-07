getModule <- function(course, module){
  require(plyr)
  load(file.path(course, module))
  names(mod) = tolower(gsub("\\.", "_", names(mod)))
  mod = transform(mod, type = ifelse(is.na(answer_type), 
    output_type, paste(output_type, answer_type, sep = "_"))
  )
  mod_list = alply(mod, 1, as.list)
  attr(mod_list, 'split_labels') = NULL
  
  info = setNames(as.list(c(names(mod.info)[2], mod.info[-4,2])), 
    c('instructor', 'course', 'module', 'packages')
  )
  info$packages = strsplit(info$packages, ",\\s*")[[1]]
  list(mod = mod_list, info = info)
}


getTemplates <- function(){
  tdir = system.file('templates', package = 'swirlify')
  tfiles = dir(tdir, full = T)
  tpls = lapply(tfiles, read_file_)
  names(tpls) = tools::file_path_sans_ext(basename(tfiles))
  return(tpls)
}

read_file_ <- function(file, warn = F, ...){
  paste(readLines(file, warn = warn, ...), collapse = "\n")
}

#' @import whisker
render_template_ <- function (template, data = parent.frame(1), ...){
  if (file.exists(template)){
    template <- read_file_(template)
  }
  paste(capture.output(
    cat(whisker::whisker.render(template, data = data))
  ), collapse = "\n")
}

zip_vectors_ <- function (...){
  x = list(...)
   lapply(seq_along(x[[1]]), function(i) lapply(x, pluck_(i)))
}

pluck_ <- function (element){
  function(x) x[[element]]
}
