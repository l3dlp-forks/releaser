#!/bin/bash
version=$1
[ -z $version ] && echo "Version argument is missing. For example, type ./releaser.sh release-2.0.0" && exit

cd /tmp
mkdir wllbg-release
cd wllbg-release

# Package creation
git clone git@github.com:wallabag/wallabag.git -b $version $version
SYMFONY_ENV=prod composer up -d=$version --no-dev
cd $version && bin/console wallabag:install --env=prod
cd .. 
tar czf wallabag-$version.tar.gz --exclude="var/cache/*" --exclude="var/logs/*" --exclude="var/sessions/*" --exclude=".git" $version

echo "MD5 checksum of the package for wallabag $version"
md5 wallabag-$version.tar.gz

scp wallabag-$version.tar.gz framasoft_bag@78.46.248.87:/var/www/framabag.org/web

rm -rf /tmp/wllbg-release