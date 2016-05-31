WIDTH = 500
all: logo.png preview.png logo.svg preview.svg

%.png: %.svg
	convert $< $@

%.svg: logo
	./logo -S $(@:%.svg=%) -o $@ -w $(WIDTH)

logo: src/Main.hs
	stack install --local-bin-path=.

clean:
	-rm -f logo logo.png preview.png
	-stack clean
