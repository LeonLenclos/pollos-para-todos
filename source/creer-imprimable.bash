# Créer les répertoires 
mkdir cartes-jeu-pdf cartes-parti-pdf

# Générer les pdf
python carte.py

# Faire l'assemblage


echo "montage cartes de jeu"
montage -density 300 cartes-jeu-pdf/* -geometry +0+0 -tile 4x4 -bordercolor black -borderwidth 4 ../imprimable/cartes-jeu.pdf
mogrify -density 300 -bordercolor black -border 4x4 ../imprimable/cartes-jeu.pdf

echo "montage cartes de parti"
montage -density 300 cartes-parti-pdf/* -geometry +0+0 -tile 2x2 -bordercolor black -borderwidth 4 ../imprimable/cartes-parti.pdf
mogrify -density 300 -bordercolor black -border 4x4 ../imprimable/cartes-parti.pdf

# Suprimer les répertoires
rm -r cartes-jeu-pdf cartes-parti-pdf

# Les billets
echo "montage billets"
bash creer-billets.bash 50
bash creer-billets.bash 100
bash creer-billets.bash 500

# Faire l'archivage
cd ../imprimable/
rm *.zip
zip pollos-para-todos-imprimable.zip *