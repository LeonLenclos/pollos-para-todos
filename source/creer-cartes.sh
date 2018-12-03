# Créer les répertoires 
mkdir cartes-jeu-pdf cartes-parti-pdf

# Générer les pdf
python carte.py

# Faire l'assemblage
echo "montage cartes de jeu"
montage -density 300 cartes-jeu-pdf/* -geometry +0+0 -tile 4x4  ../imprimable/cartes-jeu.pdf
echo "montage cartes de parti"
montage -density 300 cartes-parti-pdf/* -geometry +0+0 -tile 2x2  ../imprimable/cartes-parti.pdf

# Suprimer les répertoires
rm -r cartes-jeu-pdf cartes-parti-pdf

# Les billets
echo "montage billets"
montage -rotate 90 -density 300 billets/500.png$null{1..20} -geometry +0+0 -tile 4x5 ../imprimable/billets-500.pdf
montage -rotate 90 -density 300 billets/100.png$null{1..20} -geometry +0+0 -tile 4x5 ../imprimable/billets-100.pdf
montage -rotate 90 -density 300 billets/50.png$null{1..20} -geometry +0+0 -tile 4x5 ../imprimable/billets-50.pdf

# Faire l'archivage
rm ../imprimable/*.zip
zip ../imprimable/pollos-para-todos-imprimable.zip ../imprimable/*