APPNAME = baul-rename
APPVERSION := $(shell python3 -B -c "from baulrename.appdata import APPVERSION; print(APPVERSION)")
BUGS_URL = https://github.com/cafe-desktop/baul-rename/issues
POTFILE = po/$(APPNAME).pot

# Archivos a escanear
PY_SOURCES = data/usr/share/baul-python/extensions/baul-rename.py
GLADE_SOURCES = data/usr/share/baulrename/baulrename.glade

.PHONY: all pot

all: pot

pot:
	rm -f po/glade.pot po/python.pot
	xgettext --language=Glade \
		--package-name=$(APPNAME) \
		--package-version=$(APPVERSION) \
		--msgid-bugs-address=$(BUGS_URL) \
		-o po/glade.pot $(GLADE_SOURCES)

	xgettext --language=Python \
		--keyword=_ --keyword=N_ --add-comments \
		--from-code=UTF-8 \
		--package-name=$(APPNAME) \
		--package-version=$(APPVERSION) \
		--msgid-bugs-address=$(BUGS_URL) \
		-o po/python.pot $(PY_SOURCES)

	msgcat --use-first po/glade.pot po/python.pot -o $(POTFILE)
	rm -f po/glade.pot po/python.pot
	@echo "¡$(POTFILE) updated!"
