"""
Outil permettant de créer les cartes du jeu de société Pollos Para Todos.
Conception du jeu : Éva Ricard, Louis Pezet, Léon Lenclos.
Respect à : Hugo Colin, Fabien Carbo-Gil.
Développement : Léon Lenclos.
Production : Association du Drac.

Ce fichier défini la classe Carte. Ses filles : les classes CarteJeu et
CarteParti. Et quelques fonctions facilitant la création des cartes et
leur impression notament à partir de fichiers cvs.
"""

import csv
import weasyprint
import os

def couronnes(str):
    HTML = '<img src="img/couronne.png"/>₵'
    return str.replace("$", HTML)

class Carte():
    """Définie les méthodes
     et les attributs comuns à toutes les cartes"""

    def __init__(self, nom, modele_html):
        """Crèe une nouvelle carte"""
        self.nom = nom
        self.modele_html = modele_html
    
    def attributs(self):
        """
        Doit être écrasé par les méthodes des classes filles. Doit retourner
        un dictionnaire des attributs de carte pour le formattage.
        """
        return {}
    def vers_html(self):
        """Retourne la carte sous format html"""
        html = self.modele_html.format(**self.attributs())
        return couronnes(html)

    def exporter_pdf(self, nom_fichier, css, img_dir):
        """Enregistre la carte sous la forme d'un fichier .pdf"""
        imgs = [os.path.join(img_dir, f) for f in os.listdir(img_dir)]
        print(imgs)
        html = weasyprint.HTML(string=self.vers_html())
        pdf = html.write_pdf(presentational_hints=True, stylesheets=css, attachments=imgs)
        with open(nom_fichier, 'wb') as fichier:
            fichier.write(pdf)

    
    def exporter_html(self, nom_fichier):
        """Enregistre la carte sous la forme d'un fichier .html"""
        with open(nom_fichier, 'w') as fichier:
            fichier.write(self.vers_html())

class CarteJeu(Carte):
    """La classe d'une carte du jeu. Hérite de Carte"""

    MODELE = """
        <!doctype html>
        <html lang="fr">
        <html>
          <head>
            <title>{nom}</title>
            <meta charset="UTF-8">
          </head>
          <body>
            <header>
                <div class="pastille">
                    <div class="persistante" {cacher_persistante}></div>
                    <div class="unique" {cacher_unique}></div>
                    <div class="{type_de_carte}"></div>
                </div>
                <h1>{nom}</h1>
            </header>
            <div class="cout" {cacher_cout}>-{cout}$</div>
            <div class="description"> {description} </div>
            <div class="cout_urgence" {cacher_cout_urgence}>Urgence : -{cout_urgence}$</div>
          </body>
        </html>
    """

    def __init__(self,
        nom,
        type_de_carte,
        description,
        persistante=False,
        unique=False,
        cout=0,
        cout_urgence=0):

        super().__init__(nom, self.MODELE)
        
        self.type_de_carte = type_de_carte
        self.description = description
        self.persistante = persistante
        self.unique = unique
        self.cout = cout
        self.cout_urgence = cout_urgence

    def attributs(self):

        return {
            "nom":self.nom,
            "cacher_persistante": '' if self.persistante else 'style="display:none"',
            "cacher_unique": '' if self.unique else 'style="display:none"',
            "cacher_cout": '' if self.cout != 0 else 'style="display:none"',
            "cacher_cout_urgence": '' if self.cout_urgence != 0 else 'style="display:none"',
            "type_de_carte":self.type_de_carte,
            "cout_urgence":self.cout_urgence,
            "cout":self.cout,
            "description":self.description,
        }

class CarteParti(Carte):
    """La classe d'une carte de Parti. Hérite de Carte"""


    MODELE = """
        <!doctype html>
        <html lang="fr">
        <html>
          <head>
            <title>{nom}</title>
            <meta charset="UTF-8">
          </head>
          <body>
            <header>
                <h1>{nom}</h1>
            </header>
            <div class="description">Zone de départ : {zone}</div>
            <div class="description">{particularite}</div>
          </body>
        </html>
    """

    def __init__(self,
        nom,
        zone,
        particularite):

        super().__init__(nom, self.MODELE)
        
        self.zone = zone
        self.particularite = particularite

    def attributs(self):

        return {
            "nom":self.nom,
            "zone":self.zone,
            "particularite":self.particularite,
        }



if __name__ == '__main__':

    with open('csv/cartes-jeu.csv', 'r') as csvfile:
        reader = csv.reader(csvfile)
        for i, row in enumerate(reader):
            print(row[0])
            carte = CarteJeu(
                nom=row[0],
                type_de_carte='action' if row[6]=='A' else 'evennement',
                description=row[3],
                persistante=int(row[4])==1,
                unique=int(row[5])==1,
                cout='X' if row[1] == 'X' else int(row[1]),
                cout_urgence=int(row[2]))

            for j in range(1 if carte.unique else 3):
                carte.exporter_pdf(
                    nom_fichier="cartes-jeu-pdf/{}-{}.pdf".format(i,j),
                    css=["css/style.css", "css/cartes-jeu.css"],
                    img_dir="img")

    with open('csv/cartes-parti.csv', 'r') as csvfile:
        reader = csv.reader(csvfile)
        for i, row in enumerate(reader):
            print(row[0])
            carte = CarteParti(
                nom=row[0],
                zone=row[1],
                particularite=row[2],
                )
            carte.exporter_pdf(
                nom_fichier="cartes-parti-pdf/{}.pdf".format(i),
                css=["css/style.css", "css/cartes-parti.css"],
                img_dir="img")
