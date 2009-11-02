HTMLTARGET=vo:/var/www/docs/DaCHS
RST_SOURCES=data_checklist.rstx howDoI.rstx ref.rstx tutorial.rstx\
	booster.rstx install.rstx stc.rstx processors.rstx
ALL_HTML=index.html $(subst .rstx,.html,$(RST_SOURCES))
HTML_FILES=$(ALL_HTML)
ALL_PDF=$(subst .rstx,.pdf,$(RST_SOURCES))
LATEXOPTS=--documentoptions=11pt,a4paper --stylesheet stylesheet.tex


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


install: $(HTML_FILES) $(ALL_PDF)
	rsync -av *.css $(HTML_FILES) $(ALL_PDF) $(RST_SOURCES) $(HTMLTARGET)

clean:
	rm -f $(ALL_HTML)
	rm -f *.log *.aux *.out *.pdf
