WIDTH = 500
ALL = logo.png preview.png logo.svg preview.svg logo@2x.png

all: $(ALL)

%.png: %.unopt.png
	optipng -o7 -out $@ $<

%@2x.unopt.png: %.svg
	convert -density 180 $< $@

%.unopt.png: %.svg
	convert $< $@

%.svg: logo
	./logo -S $(@:%.svg=%) -o $@ -w $(WIDTH)

logo: src/Main.hs
	stack install --local-bin-path=.

clean:
	-rm -f logo $(ALL)
	-stack clean
