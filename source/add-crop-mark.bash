# add crop mark to monted image
# $1 is the image
# $2 is the number of rows
# $3 is the number of columns

w=$(convert -density 300 $1 -format "%w" info:)
h=$(convert -density 300 $1 -format "%h" info:)
margin=7
mark=20
let "totalmargin = ($margin + $mark)"
let "W = $w + $totalmargin*2"
let "H = $h + $totalmargin*2"

draw=""
for i in $(seq 0 $3)
do
	let "y = $h/$3*$i + $totalmargin"
	draw="$draw line 0,$y $W,$y"
done

for i in $(seq 0 $2)
do
	let "x = $w/$2*$i + $totalmargin"
	draw="$draw line $x,0 $x,$H"
done




convert -size "${W}x$H" xc:white \
		-stroke black -draw "$draw" \
		-density 300 $1 \
		-geometry "+${totalmargin}+${totalmargin}" -bordercolor white -border "${margin}x${margin}" -composite \
		$1
