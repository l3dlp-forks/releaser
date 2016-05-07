# wallabag release creation

## Usage

```
./releaser.sh master
```

Today, this script only do the Package creation (see below) and upload it to our Framabag server.

## Todo

Here are the different steps when we release a new version. 

The idea of this project: automate much steps as possible.

### Steps

* Edit `app/config/config.yml`, `README.md` and documentation to change version
* Update `CHANGELOG.md` 
* Push these changes via a new pull request
* Create a new branch for the release (where we push `composer.lock`) :

```
git checkout master
git pull origin master
git checkout -b release-2.0.0
SYMFONY_ENV=prod composer up --no-dev
git add --force composer.lock
# Edit .travis.yml to travis_wait composer install --no-interaction --no-progress --prefer-dist -o with travis_wait composer update --no-interaction --no-progress
git add README.md
git commit -m "Release wallabag 2.0.0"
git push origin release-2.0.0
```

* Create a new pull request and add in the title: `DON'T MERGE`. This pull request will never be merged. We only open it to launch our testsuite before releasing.
* Package creation : 

```
git clone git@github.com:wallabag/wallabag.git -b release-2.0.0 release-2.0.0
SYMFONY_ENV=prod composer up -d=release-2.0.0 --no-dev
cd release-2.0.0 && bin/console wallabag:install --env=prod
cd .. 
tar czf wallabag-release-2.0.0.tar.gz --exclude="var/cache/*" --exclude="var/logs/*" --exclude="var/sessions/*" --exclude=".git" release-2.0.0
```

* Create a new release on GitHub
* Delete `release-2.0.0` branch on GitHub
* Close the current milestone and create a new one if necessary
* Update links on http://wllbg.org/admin/ (YOURLS application)
* Update wallabag.org website (downloads, releases and new blog post)
* Share on social networks
* Open and drink a fresh beer :beers:!
