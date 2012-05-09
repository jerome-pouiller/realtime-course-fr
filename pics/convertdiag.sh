#!/bin/zsh

if [[ $# != 2 ]]; then
    echo "Usage: $0 IN LETTER"
    echo "Exemple: $0 AABB1AA1X2AABB1AA33 AB123"
    return 1;
fi

IN=$1
LET=$2
COL=(cgreen cred cblue cpurple corange ccyan)
POS=(   1.5  3.0   4.5     6.0     7.5   9.0)
echo "% $IN"
echo "\\\\begin{center}"
echo "\\\\begin{tikzpicture}[scale=0.5]"
echo -n "  \\\\timeline{$(($#IN))}{-5}{"
for ((k = 1; k <= $#LET; k++))
  echo -n "-$((${POS[$k]} - 0.5))/${LET[$k]}, "
echo "}"
for ((k = 1; k <= $#LET; k++)); do
  j=$LET[k]
  printf "  \\\\fill%-9s (0,%1.1f)" "[${COL[$k]}]" "-${POS[$k]}"
  n=
  for i in {1..$#IN}; do
    if [[ "${IN[$i]}" == "${IN[$i-1]}" ]]; then
      ((n++))
      continue
    fi
    if [[ "${IN[$i]}" == "$j" ]]; then
      echo -n "$n \hi "
    else
      echo -n "$n \lo "
    fi
    n=1
  done
  echo "$n;"
done
echo "  % Adapt to your needs:"
for ((k = 1; k <= $#LET; k++)); do
   printf  "  \\\\foreach \\\\i in {0, 4, ..., 20}\n"
   printf  "    \\\\draw%-9s (\\\\i + 0.5, %1.1f) circle (3pt);\n" "[${COL[$k]}]" "-$((${POS[$k]} - 0.5))"
done
echo "\\\\end{tikzpicture}"
echo "\\\\end{center}"

