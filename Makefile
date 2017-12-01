SHELL=/bin/bash

all: construction

clean:
	rm -r README_cache

comparison:
	for rmd in settings/*.Rmd; do \
		if [[ $$rmd == 'settings/host-analysis.Rmd' ]]; then \
			continue; \
		fi; \
		echo "Processing $$rmd"; \
		title=`grep title $$rmd | grep -o \".*\"`; \
		params="list(settings=\"$$rmd\", title=$$title)"; \
		cmd="Rscript -e 'rmarkdown::render(\"01-network-comparison.Rmd\", params=$$params)'"; \
		echo $$cmd; \
	done
	
construction:
	for rmd in settings/*.Rmd; do \
		if [[ $$rmd == 'settings/host-analysis.Rmd' ]]; then \
			continue; \
		fi; \
		echo "Processing $$rmd"; \
		title=`grep title $$rmd | grep -o \".*\"`; \
		title=$${title/Comparison/Construction} ; \
		params="list(settings=\"$$rmd\", title=$$title)"; \
		cmd="Rscript -e 'rmarkdown::render(\"02-network-construction.Rmd\", params=$$params)'"; \
		echo $$cmd; \
	done

host:
	rmd="settings/host-analysis.Rmd"; \
	title=`grep title $$rmd | grep -o \".*\"`; \
	params="list(settings=\"$$rmd\", title=$$title)"; \
	cmd="Rscript -e 'rmarkdown::render(\"03-host-network-analysis.Rmd\", params=$$params)'"; \
	echo $$cmd;
