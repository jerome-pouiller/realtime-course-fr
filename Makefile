#
# Licence: GPL
# Created: 2011-09-11 11:51:04+02:00
# Main authors:
#     - Jérôme Pouiller <jezz@sysmic.org>
#

all: present print

.PHONY: present print 

present:
	[ -d present ] || mkdir present
	pdflatex -jobname=realtime-lecture-present -file-line-error -output-directory=present "\input{main}"
	#rubber --warn=all --short --pdf --into=present -v --cache -c "\PassOptionsToClass{notes=show}{beamer}" main.tex 
	mv present/*.pdf .

print:
	[ -d print ] || mkdir print
	pdflatex -jobname=realtime-lecture-print -file-line-error -output-directory=print "\PassOptionsToClass{notes=show}{beamer}\input{main}"
	#rubber --warn=all --short --pdf --into=print -v --cache main-print.tex 
	mv print/*.pdf .
