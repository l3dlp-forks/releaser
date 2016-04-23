# wallabag release creation

## Usage

```
./releaser.sh master
```

Today, this script only creates package and upload it to our Framabag server.

## Todo

Here are (in french) the different steps when we release a new version. 

The idea of this project: automate much steps as possible.

### Steps (in french)

* éditer le fichier app/config/config.yml pour changer la version 
* éditer le README.md pour l'installation (numéro de version)
* éditer la doc pour l'installation (numéro de version)
* Commandes à jouer

```
git checkout master
git pull origin master
git checkout -b release-2.0.0
SYMFONY_ENV=prod composer up --no-dev
git add --force composer.lock
git add README.md
git commit -m "Release wallabag 2.0.0"
git push origin release-2.0.0
```

* Mettre dans le titre de la PR : `DON'T MERGE`
* ~~Création du package~~ : 

```
git clone git@github.com:wallabag/wallabag.git -b release-2.0.0 release-2.0.0
SYMFONY_ENV=prod composer up -d=release-2.0.0 --no-dev
cd release-2.0.0 && bin/console wallabag:install --env=prod
cd .. 
tar czf wallabag-release-2.0.0.tar.gz --exclude="var/cache/*" --exclude="var/logs/*" --exclude="var/sessions/*" --exclude=".git" release-2.0.0
```

* Création de la release sur GitHub
* Suppression de la branche créée
* Fermeture de la milestone et ouverture de la suivante si nécessaire
* Mise à jour de http://wllbg.org/admin/
* Mise à jour de la page downloads du site 
* Publication
