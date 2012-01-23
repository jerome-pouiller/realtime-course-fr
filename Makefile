

.PHONY: split

# SRC=$( *.tex) $(subst res/*.tex)

presentation: realtime-lecture.pdf
realtime-lecture.pdf: $(SRC)
	./make.sh -f out/presentation
	mv out/presentation/realtime-presentation.pdf ./realtime-lecture.pdf

handout: realtime-lecture-handout.pdf
realtime-lecture-handout.pdf:
	./make.sh -f -b handout out/print
	mv out/print/realtime-print.pdf ./realtime-lecture-handout.pdf


split: realtime-lecture.pdf
	./make.sh -f -d pages=1,2-39    -d in=$< -i split.tex split/lecture-1
	./make.sh -f -d pages=1,40-75   -d in=$< -i split.tex split/lecture-2
	./make.sh -f -d pages=1,76-146  -d in=$< -i split.tex split/lecture-3
	./make.sh -f -d pages=1,147-207 -d in=$< -i split.tex split/lecture-4
	./make.sh -f -d pages=1,208- -d in=$< -i split.tex split/lecture-5
	mv split/lecture-[0-9]/realtime-lecture-[0-9].pdf .

mozaic-presentation: realtime-lecture.pdf
	 ./make.sh -f -d in=$< -i mozaic.tex split/lecture-mozaic
	 mv split/realtime-lecture-mozaic/realtime-lecture-mozaic.pdf .

mozaic-handout: realtime-lecture-handout.pdf
	 ./make.sh -f -d in=$< -i mozaic.tex split/handout-mozaic
	 mv split/realtime-lecture-mozaic/realtime-handout-mozaic.pdf .

all_parts: problematique monotache multitaches ordonnancement ressources architectures
problematique: $(SRC)
	./make.sh -f -o problematique  part1_problematique
monotache: $(SRC)
	./make.sh -f -o monotache      part2_monotache
multitaches: $(SRC)
	./make.sh -f -o multitache     part3_multitache
ordonnancement: $(SRC)
	./make.sh -f -o ordonnancement part4_ordonnancement
ressources: $(SRC)
	./make.sh -f -o ressources     part5_ressources
architectures: $(SRC)
	./make.sh -f -o architectures  part6_architectures





