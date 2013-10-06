swirlify
========

[Swirl](https://github.com/ncarchedi/swirl) is an R package, that allows interactive statistics and R lessons to be delivered directly from the R console. Swirlify complements Swirl by allowing an author to convert a course module into interactive slides that can then be deployed over the web, or as an interactive Shiny application. 

See a [demo](http://slidify.github.io/swirlSlidify/#1) in action!

### Installation

You can install `swirlify` from `github` using `devtools`

```S
library(devtools)
install_github("swirlify", "slidify")
```

### Usage 

The `swirl2slidify` function allows a [swirl](https://github.com/ncarchedi/swirl) course module to be converted into a [slidify](http://slidify.org) compatible R Markdown file.

The first step is to convert the module into slidify markdown

```S
library(swirlify)
course = system.file('Courses', 'Data_Analysis', package = 'swirl')
module = 'Module1.Rda'
deck = swirl2slidify(course, module)
```

The second step is to create a presentation folder for the slides, replace `index.Rmd` with the contents of `deck`, and use `runDeck` to open the course module as a shiny application that allows interactivity.

```S
library(slidify)
author('module1')
cat(deck, file = "index.Rmd")
runDeck()
```

Note that you will need to latest `dev` branch of `slidify` and `slidifyLibraries` installed for these features to work.

### License

MIT License
