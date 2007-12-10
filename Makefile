HTMLTARGET=vo:/var/www/docs/python-gavo

ALL_HTML=userman.html querulator_devel.html querulator_user.html develNotes.html

%.html: %.rstx
	../bin/expandRstx.py < $< | rst2html >$@


all: html

html: $(ALL_HTML)

install: html
	rsync -av $(ALL_HTML) $(HTMLTARGET)

clean:
	rm -f $(ALL_HTML)

classes.ps: classes.dot
	dot -T ps < $< > $@
