.SUFFIXES: .tex .pdf
FIGDIR= figures

SLIDES= lecture.feelpp.slides.pdf \
        lecture.feelpp.handout.pdf

all: ${SLIDES}


lecture.feelpp.slides.pdf:
lecture.feelpp.handout.pdf:

%.handout.pdf : %.handout.tex %.tex
	latexmk -pdf $<

%.slides.pdf : %.slides.tex %.tex
	latexmk -pdf $<

clean:
	rm -f *.aux *.log *.nav *.out *.snm

realclean:
	rm -f *.aux *.log *.nav *.out *.snm ${SLIDES}
