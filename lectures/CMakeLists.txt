cmake_minimum_required(VERSION 2.8.4)
project(lecture.feelpp NONE)

include(UseLATEX.cmake)
set(PDFLATEX_COMPILER xelatex)
SET(SRCS lecture.feelpp.tex lecture.style.tex feelpp.intro.tex feelpp.solver.tex feelpp.toolbox.tex feelpp.programming.tex)

set(FIG_DIRS  figures/applications figures/logos figures/people)
add_latex_document(lecture.feelpp.slides.tex
  INPUTS ${SRCS}
  IMAGE_DIRS ${FIG_DIRS}
  FORCE_PDF)

add_latex_document(lecture.feelpp.handout.tex
  INPUTS ${SRCS}
  IMAGE_DIRS ${FIG_DIRS}
  FORCE_PDF
  )
