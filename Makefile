#-----------------------------------------------------
MAIN=feedback
EXT=asc
ICONSDIR=/Users/bruel/dev/asciidoc/images/icons
#-----------------------------------------------------

all: site slides

site: main feed feednotoc cord

cord: cordeuse.$(EXT)
	@echo '==> Compiling asciidoc files to generate HTML'
	asciidoc -b html5 -a icons -a iconsdir=$(ICONSDIR) -a data-uri \
	-a stylesheet=/Users/bruel/Dropbox/Public/dev/SysMLBook/stylesheets/scribe.css \
	-a book \
	cordeuse.$(EXT)

main: $(MAIN).$(EXT)
	@echo '==> Compiling asciidoc files to generate HTML'
	asciidoc -b html5 -a icons -a iconsdir=$(ICONSDIR) -a data-uri \
	-a stylesheet=/Users/bruel/Dropbox/Public/dev/SysMLBook/stylesheets/scribe.css \
	-a book \
	$(MAIN).$(EXT)

feed: feedback-all.$(EXT)
	@echo '==> Compiling asciidoc files to generate HTML'
	asciidoc -b html5 -a toc2 -a icons -a iconsdir=$(ICONSDIR) -a data-uri \
	-a stylesheet=/Users/bruel/Dropbox/Public/dev/SysMLBook/stylesheets/scribe.css \
	-a book \
	feedback-all.$(EXT)

feednotoc: feedback-all.$(EXT)
	@echo '==> Compiling asciidoc files to generate HTML'
	asciidoc -b html5 -a icons -a iconsdir=$(ICONSDIR) -a data-uri \
	-a stylesheet=/Users/bruel/Dropbox/Public/dev/SysMLBook/stylesheets/scribe.css \
	-a book \
	-o feedback-all-notoc.html \
	feedback-all.$(EXT)

slides: *.deckjs.html
	@echo '==> Compiling asciidoc files to generate SLIDES'
	asciidoc -b deckjs -a deckjs -a icons -a iconsdir=$(ICONSDIR) -a data-uri -a numbered \
	 -a deckjs_transition=horizontal-slide -a deckjs_theme=web-2.0 \
	 --conf-file /Users/bruel/.asciidoc/backends/deckjs/deckjs.conf \
	 -o $(MAIN).deckjs.html $(MAIN)-all.$(EXT)

plant: plantuml/*.png

plantuml/%.png: plantuml/%.txt
	@echo '==> Compiling plantUML files to generate PNG'
	java -jar plantuml.jar $<

publish:
	cp *.html /Users/bruel/dev/jmbhome/public/teaching/SysML
	

