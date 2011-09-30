


# SRC=$( *.tex) $(subst res/*.tex)

presentation: realtime-lecture.pdf
realtime-lecture.pdf: $(SRC)
	./make.sh -f out/presentation
	mv presentation/presentation.pdf ./realtime-lecture.pdf

handout: realtime-lecture-handout.pdf
realtime-lecture-handout.pdf:
	./make.sh -f -b handout print
	mv print/print.pdf ./realtime-lecture-handout.pdf


split: realtime-lecture.pdf
	./make.sh -f -d pages=1,40-76 -d in=realtime-lecture.pdf -m split.tex split/realtime-lecture-1
	./make.sh -f -d pages=1,40-76 -d in=realtime-lecture.pdf -m split.tex split/realtime-lecture-2
	./make.sh -f -d pages=1,40-76 -d in=realtime-lecture.pdf -m split.tex split/realtime-lecture-3
	./make.sh -f -d pages=1,40-76 -d in=realtime-lecture.pdf -m split.tex split/realtime-lecture-4
	mv split/realtime-lecture-[1234]/realtime-lecture-[1234].pdf .

mozaic-presentation: realtime-lecture.pdf
	 ./make.sh -f -d in=$< -m mozaic.tex split/realtime-lecture-mozaic
	 mv split/realtime-lecture-mozaic/realtime-lecture-mozaic.pdf .

mozaic-handout: realtime-lecture-handout.pdf
	 ./make.sh -f -d in=$< -m mozaic.tex split/realtime-lecture-mozaic
	 mv split/realtime-lecture-mozaic/realtime-lecture-mozaic.pdf .

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





