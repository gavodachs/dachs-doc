RST_SOURCES=data_checklist.rstx howDoI.rstx ref.rstx tutorial.rstx\
	booster.rstx install.rstx stc.rstx processors.rstx adql.rstx\
	votable.rstx commonproblems.rstx tapquery.rstx develNotes.rstx\
	elemref.rstx templating.rstx
ALL_HTML=index.html $(subst .rstx,.html,$(RST_SOURCES))
HTML_FILES=$(ALL_HTML)
ALL_PDF=$(subst .rstx,.pdf,$(RST_SOURCES))
LATEXOPTS=--documentoptions=11pt,a4paper --stylesheet stylesheet.tex


%.html: %.rstx
	rst2html --template rst2html-template.txt --stylesheet ref.css\
		--link-stylesheet < $<  >$@

%.dvi: %.tex
	latex $<
	latex $<
	rm $*.log

%.ps: %.dvi
	dvips $<

%.pdf: %.tex
	pdflatex $<

%.tex: %.rstx
	rst2latex $(LATEXOPTS) $< > $@

.PHONY: ref.rstx elemref.rstx apidoc-stamp

all: $(HTML_FILES) $(ALL_PDF)

clean:
	rm -f $(ALL_HTML)
	rm -f *.log *.aux *.out *.pdf
	rm -f apidoc-stamp
