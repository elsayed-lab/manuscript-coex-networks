SHELL=/bin/bash

# Analysis version
VERSION="2.0"

all: comparison construction inf-vs-uninf

clean:
	rm -r README_cache

comparison:
	for rmd in settings/$(VERSION)/consensus-nets/*.Rmd; do \
		echo "---------- Processing $$rmd ----------"; \
		title=`grep title $$rmd | grep -o \".*\"`; \
		params="list(settings=\"$$rmd\", title=$$title, version=\"$(VERSION)\")"; \
		cmd="Rscript -e 'rmarkdown::render(\"01-network-comparison.Rmd\", params=$$params)'"; \
		echo $$cmd; \
	done
	
construction:
	for rmd in settings/$(VERSION)/consensus-nets/*.Rmd; do \
		echo "---------- Processing $$rmd ----------"; \
		title=`grep title $$rmd | grep -o \".*\"`; \
		title=$${title/Comparison/Construction} ; \
		params="list(settings=\"$$rmd\", title=$$title, version=\"$(VERSION)\")"; \
		cmd="Rscript -e 'rmarkdown::render(\"02-network-construction.Rmd\", params=$$params)'"; \
		echo $$cmd; \
		#eval $$cmd; \
	done

inf-vs-uninf:
	for rmd in settings/$(VERSION)/difference-nets/*inf-vs-uninf.Rmd; do \
		echo "---------- Processing $$rmd ----------"; \
		title=`grep title $$rmd | grep -o \".*\"`; \
		params="list(settings=\"$$rmd\", title=$$title, version=\"$(VERSION)\")"; \
		cmd="Rscript -e 'rmarkdown::render(\"03-infected-vs-uninfected.Rmd\", params=$$params)'"; \
		echo $$cmd; \
	done
