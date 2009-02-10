HTMLTARGET=vo:/var/www/docs/python-gavo

ALL_HTML=userman.html develNotes.html data_checklist.html

LATEXOPTS=--documentoptions=12pt,a4paper


#%.html: %.rstx
#	../bin/expandRstx.py < $< | rst2html >$@

%.html: %.rstx
	rst2html --stylesheet ref.css --link-stylesheet < $<  >$@

%.dvi: %.tex
	latex $<
	rm $*.log

%.ps: %.dvi
	dvips $<

%.pdf: %.tex
	pdflatex $<

%.tex: %.rstx
	rst2latex $(LATEXOPTS) $< > $@

.PHONY: ref.rstx
ref.rstx:
	gavogendoc > ref.rstx

html: $(ALL_HTML)

install: html
	rsync -av $(ALL_HTML) $(HTMLTARGET)

clean:
	rm -f $(ALL_HTML)
	rm -f *.log *.aux *.out *.pdf

classes.ps: classes.dot
	dot -T ps < $< > $@
