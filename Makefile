all: publish

publish:  render
	rm -rf public/
	mkdir public
	cp -r css img libs *.html public/

clean:
	rm -rf public/
	rm -rf *.html *_files/
  
RMDS  = $(filter-out README.Rmd, $(wildcard *.Rmd))
HTMLS = $(RMDS:.Rmd=.html)

KNIT = Rscript -e "rmarkdown::render('$<')"

render: $(HTMLS)

%.html: %.Rmd
	$(KNIT)
