#!/bin/zsh
#
# Licence: GPL
# Created: 2011-09-11 11:51:04+02:00
# Main authors:
#     - Jérôme Pouiller <jezz@sysmic.org>
#

# Exemple:
# ./make.sh arch '\includeonly{architectures}\PassOptionsToClass{notes=show}{beamer}'

EXTRA=
OPTIND=1
FORCE=
while [[ $OPTIND -le $# ]]; do
    while getopts fb:o:e: OPT; do
        case $OPT in
            o)
                EXTRA+="\includeonly{$OPTARG}"
                ;;
            b)
                EXTRA+="\PassOptionsToClass{$OPTARG}{beamer}"
                ;;
            e)
                EXTRA+="$OPTARG"
                ;;
            f)
                FORCE=1
                ;;
            *)
                echo "Bad arguments"
                exit 1
                ;;
        esac
    done
    [ -z "$OUT" ] && OUT=$argv[$OPTIND]
    ((OPTIND++))
done

[ -n "$OUT" ] || exit 1

if  [ -z "$FORCE" -a -d "$OUT" -a -n "$EXTRA" ]; then
    echo Please do not provide options for a predefined compilation
    exit 1
fi

if [ ! -d $OUT ]; then  
    mkdir $OUT
    echo "$EXTRA" > $OUT/options
fi

EXTRA=$(cat $OUT/options)
echo Compiling $OUT with options $EXTRA
pdflatex -jobname=realtime-$OUT -file-line-error -output-directory=$OUT "$EXTRA\input{main}" < /dev/null
mv $OUT/realtime-$OUT.pdf .


