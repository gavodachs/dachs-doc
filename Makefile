HTMLTARGET=vo:/var/www/docs/python-gavo

ALL_HTML=userman.html querulator_devel.html querulator_user.html \
	develNotes.html data_checklist.html

LATEXOPTS=--documentoptions=12pt,a4paper


%.html: %.rstx
	../bin/expandRstx.py < $< | rst2html >$@

%.dvi: %.tex
	latex $<

%.ps: %.dvi
	dvips $<

%.pdf: %.tex
	pdflatex $<

%.tex: %.rstx
	rst2latex $(LATEXOPTS) $< > $@

all: html data_checklist.pdf

html: $(ALL_HTML)

install: html
	rsync -av $(ALL_HTML) $(HTMLTARGET)

clean:
	rm -f $(ALL_HTML)

classes.ps: classes.dot
	dot -T ps < $< > $@
