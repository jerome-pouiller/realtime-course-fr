#!/bin/zsh
#
# Licence: GPL
# Created: 2011-09-11 11:51:04+02:00
# Main authors:
#     - Jérôme Pouiller <jezz@sysmic.org>
#

# Exemple:
# ./make.sh arch -o architectures,ordonnancement -b beamer -e \RequirePackage{calc}'

EXTRA=
OPTIND=1
FORCE=

#fun() { 
#    typeset -A Args
#    Args=(-sl 0 -si 0 -sm 0 -ss x)
#    echo ${(kvqq)Args}
#    zparseopts -K -D -E -A Args sl si sm ss sd
#    echo ${(kvqq)Args}
#}

FILE=main
while [[ $OPTIND -le $# ]]; do
    while getopts fb:o:e:d:i: OPT; do
        case $OPT in
            o)
                EXTRA+="\includeonly{$OPTARG}"
                ;;
            b)
                EXTRA+="\PassOptionsToClass{$OPTARG}{beamer}"
                ;;
            d)
                if [[ $OPTARG = *=* ]]; then
                    EXTRA+="\def\\${OPTARG%\=*}{${OPTARG#*\=}}"
                else
                    EXTRA+="\def\\$OPTARG{1}"
                fi
                ;;
            e)
                EXTRA+="$OPTARG"
                ;;
            i)
                FILE="$OPTARG"
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

[ -n "$OUT" ] || OUT=.

if  [ -z "$FORCE" -a -d "$OUT" -a -n "$EXTRA" ]; then
    echo Please do not provide options for a predefined compilation
    exit 1
fi

if [ ! -d $OUT -o -n "$FORCE" ]; then  
    [ ! -d $OUT ] && mkdir -p $OUT
    echo -E "$EXTRA\input{$FILE}" > $OUT/input
    pwd > $OUT/source
elif [ -d $OUT -a ! -e $OUT/source -o ! -e $OUT/input ]; then
    echo "\"$OUT/source\" or \"$OUT/input\" not found. Target is corrupted?"
    exit 1
fi

TARGET="$(readlink -f $OUT)"
INPUT="$(cat $OUT/input)"
SRC="$(cat $OUT/source)"
echo -E "Compiling $OUT with $INPUT"
pushd "$SRC"
pdflatex -interaction=nonstopmode -jobname=realtime-$(basename "$TARGET") -file-line-error -output-directory=$TARGET "$INPUT" < /dev/null
popd
# mv $OUT/realtime-$OUT.pdf .

