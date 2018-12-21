# # Créer les répertoires 
# mkdir cartes-jeu-pdf cartes-parti-pdf

# # Générer les pdf
# python carte.py

# # Faire l'assemblage


# echo "montage cartes de jeu"
# montage -density 300 cartes-jeu-pdf/* -geometry +0+0 -tile 4x4 ../imprimable/cartes-jeu-%d.tiff
# # Dos :
# # f=$(echo cartes-jeu-pdf/*  | head -n1 | cut -d " " -f1)
# # s=$(convert -density 300 $f -format "%wx%h" info:)
# # montage -border 500x500 img/action.png$null{1..16} -geometry "${s}+0+0" -tile 4x4 ../imprimable/cartes-jeu-dos.tiff
# # echo $s
# for f in ../imprimable/cartes-jeu*.tiff
# do
# 	bash add-crop-mark.bash $f 4 4
# 	convert -density 300 -frame 50x50 -mattecolor white $f -page A4 "${f::-4}pdf"
# done


# echo "montage cartes de parti"
# montage -density 300 cartes-parti-pdf/* -geometry +0+0 -tile 2x2 ../imprimable/cartes-parti-%d.tiff
# for f in ../imprimable/cartes-parti*.tiff
# do
# 	bash add-crop-mark.bash $f 2 2
# 	convert -density 300 -frame 50x50 -mattecolor white $f -page A4 "${f::-4}pdf"
# done





# Les billets
echo "montage billets"
bash creer-billets-cutter.bash 50
bash creer-billets-cutter.bash 100
bash creer-billets-cutter.bash 500

for f in ../imprimable/billets*.pdf
do
	convert -density 300 -frame 50x50 -mattecolor white $f -page A4 "${f::-4}ok.pdf"
done


# echo "montage map"
# convert -density 300 -frame 100x0 -mattecolor white map/map-1.png -page A4 ../imprimable/map-1.pdf
# convert -density 300 -frame 100x0 -mattecolor white map/map-2.png -page A4 ../imprimable/map-2.pdf
# convert -density 300 -frame 100x0 -mattecolor white map/map-3.png -page A4 ../imprimable/map-3.pdf


# # Suprimer les tmp
# rm -r cartes-jeu-pdf cartes-parti-pdf
# rm ../imprimable/*.tiff

# # Faire l'archivage
# cd ../imprimable/
# rm *.zip
# zip pollos-para-todos-imprimable.zip *.pdf