# TinyTeX on macOS; other distributions can override TEXBIN.
TEXBIN ?= $(HOME)/Library/TinyTeX/bin/universal-darwin
export PATH := $(TEXBIN):$(PATH)
MAIN ?= resume-zh_CN.tex
OUTDIR ?= build
LATEXMK ?= latexmk
FLAGS = -xelatex -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error -outdir=$(OUTDIR)

.PHONY: all pdf zh_CN watch preview clean distclean
all: pdf

pdf zh_CN:
	$(LATEXMK) $(FLAGS) $(MAIN)

# Save the source to rebuild; stop with Ctrl+C.
watch:
	$(LATEXMK) $(FLAGS) -pvc -view=none $(MAIN)

preview: pdf
	open "$(OUTDIR)/$(basename $(MAIN)).pdf"

# Keep the PDF; never remove PDFs from the repository root.
clean:
	$(LATEXMK) -c -outdir=$(OUTDIR) $(MAIN)

distclean:
	$(LATEXMK) -C -outdir=$(OUTDIR) $(MAIN)
