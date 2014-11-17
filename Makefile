# Makefile
TEXFILES = $(wildcard *.tex)
PDFFILES = $(TEXFILES:.tex=.pdf)

all: pdflatex clean

pdf: $(PDFFILES)

%.pdf: %.tex
	@if [ -d publish ];then mv *.pdf publish; else mkdir publish; mv *.pdf publish/;fi

pdflatex: $(TEXFILES)
	@xelatex $(TEXFILES:.tex=)
	@TEXMFOUTPUT=`pwd` bibtex `pwd`/$(TEXFILES:.tex=)
	@xelatex $(TEXFILES:.tex=)
	@xelatex $(TEXFILES:.tex=)
	@if [ -d publish ];then mv *.pdf publish; else mkdir publish; mv *.pdf publish/;fi

clean:
	@rm -f *.lof *.lot *.log *.bak *.aux *.bbl *.blg *.idx *.toc *.out *~

distclean: clean
	@rm -rf publish
	@rm -f $(PDFFILES)

x:
	@open publish/$(PDFFILES) &> /dev/null &
