# Créer les répertoires 
mkdir cartes-jeu-pdf cartes-parti-pdf

# Générer les pdf
python carte.py

# Faire l'assemblage
echo "montage cartes de jeu"
montage -density 300 cartes-jeu-pdf/* -geometry +0+0 -tile 4x4  ../imprimable/cartes-jeu.pdf
echo "montage cartes de parti"
montage -density 300 cartes-parti-pdf/* -geometry +0+0 -tile 2x2  ../imprimable/cartes-parti.pdf

# Faire l'archivage
zip ../imprimable/pollos-para-todos-imprimable.zip ../imprimable/LISEZ_MOI.txt ../imprimable/cartes-jeu.pdf ../imprimable/cartes-parti.pdf

# Suprimer les répertoires
rm -r cartes-jeu-pdf cartes-parti-pdf
