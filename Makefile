all: presentation.html presentation.pdf

%.html: %.md Makefile assets/style.css
	docker run --rm --volume "`pwd`:/data" --user `id -u`:`id -g` pandoc/latex \
		$< \
		-t revealjs \
		--standalone \
		--output $@ \
		--metadata=date:"`date "+%B %e, %Y"`" \
		--no-highlight \
		--katex \
		--metadata-file=config.yml \
		--shift-heading-level-by=1

%.pdf: %.html
	docker run --rm --volume "`pwd`:/slides" --workdir="/slides" --user `id -u`:`id -g` astefanutti/decktape \
		$< \
		$@

.PHONY: clean

clean:
	rm -rf *.html
