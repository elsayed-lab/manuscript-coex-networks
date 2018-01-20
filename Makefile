SHELL=/bin/bash

# Analysis version
VERSION="4.0"

all: similarity construction analysis inf-vs-uninf

clean:
	rm -r README_cache

indiv_enrichment:
	echo "---------- Processing Individual Network Enrichment Results ----------"; \
	params="list(version=\"$(VERSION)\")"; \
	cmd="Rscript -e 'rmarkdown::render(\"01-individual-network-enrichment.Rmd\", params=$$params)'"; \
	echo $$cmd; \
	#eval $$cmd; \

similarity:
	for rmd in settings/$(VERSION)/individual-nets/*.Rmd; do \
		echo "---------- Processing $$rmd ----------"; \
		title=`grep title $$rmd | grep -o \".*\"`; \
		params="list(settings=\"$$rmd\", title=$$title, version=\"$(VERSION)\")"; \
		cmd="Rscript -e 'rmarkdown::render(\"02-individual-network-similarity.Rmd\", params=$$params)'"; \
		echo $$cmd; \
		#eval $$cmd; \
	done

construction:
	for rmd in settings/$(VERSION)/consensus-nets/*.Rmd; do \
		echo "---------- Processing $$rmd ----------"; \
		title=`grep title $$rmd | grep -o \".*\"`; \
		params="list(settings=\"$$rmd\", title=$$title, version=\"$(VERSION)\")"; \
		cmd="Rscript -e 'rmarkdown::render(\"03-consensus-network-construction.Rmd\", params=$$params)'"; \
		echo $$cmd; \
		#eval $$cmd; \
	done
	
analysis:
	for rmd in settings/$(VERSION)/consensus-nets/*.Rmd; do \
		echo "---------- Processing $$rmd ----------"; \
		title=`grep title $$rmd | grep -o \".*\"`; \
		title=$${title/Comparison/Construction} ; \
		params="list(settings=\"$$rmd\", title=$$title, version=\"$(VERSION)\")"; \
		cmd="Rscript -e 'rmarkdown::render(\"04-consensus-network-analysis.Rmd\", params=$$params)'"; \
		echo $$cmd; \
		#eval $$cmd; \
	done

inf-vs-uninf:
	for rmd in settings/$(VERSION)/difference-nets/*inf-vs-uninf.Rmd; do \
		echo "---------- Processing $$rmd ----------"; \
		title=`grep title $$rmd | head -n1 | grep -o \".*\"`; \
		params="list(settings=\"$$rmd\", title=$$title, version=\"$(VERSION)\")"; \
		cmd="Rscript -e 'rmarkdown::render(\"05-infected-vs-uninfected.Rmd\", params=$$params)'"; \
		echo $$cmd; \
		#eval $$cmd; \
	done

hslm-vs-hstc:
	rmd="settings/$(VERSION)/difference-nets//hslm-vs-hstc.Rmd"; \
	echo "---------- Processing $$rmd ----------"; \
	title=`grep title $$rmd | head -n1 | grep -o \".*\"`; \
	params="list(settings=\"$$rmd\", title=$$title, version=\"$(VERSION)\")"; \
	cmd="Rscript -e 'rmarkdown::render(\"06-conserved-signature-of-infection.Rmd\", params=$$params)'"; \
	echo $$cmd; \
	#eval $$cmd; \

