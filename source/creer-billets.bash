# Les billets
echo "montage billets $1"
montage -rotate 90 -density 300 billets/$1.png$null{1..20} -geometry +0+0 -tile 5x4 -bordercolor black -borderwidth 2 ../imprimable/billets-$1.pdf
mogrify -density 300 -bordercolor black -border 3x3 ../imprimable/billets-$1.pdf
