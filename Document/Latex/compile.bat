#latexmk -g -f CS5811400000.tex

##### OR


xelatex -interaction=nonstopmode -file-line-error -synctex=1 -shell-escape CS5811400000.tex
bibtex CS5811400000.aux
xelatex -interaction=nonstopmode -file-line-error -synctex=1 -shell-escape CS5811400000.tex
xelatex -interaction=nonstopmode -file-line-error -synctex=1 -shell-escape CS5811400000.tex