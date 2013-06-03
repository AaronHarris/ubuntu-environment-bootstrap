#!/bin/bash

#Script to bootstrap an App Engine development environment.

sudo echo 'Development Environment Bootstrap Script'

echo 'Installing Packages from APT'

sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo add-apt-repository ppa:chris-lea/node.js

sudo apt-get update
sudo apt-get -yq install build-essential git git-extras wget zip unzip p7zip python-crypto python-httplib2 python-imaging python-lxml python-markupsafe python-oauth python-openssl python-pip python-setuptools python-simplejson phantomjs nodejs npm sublime-text

echo 'Installing Packages with PIP'

sudo pip install unittest2 Jinja2 GitPython PIL Paver Sphinx WebOb WebTest pyflakes

echo 'Installing Karma'

sudo npm install -g karma

echo 'Downloading App Engine SDK'

cd /tmp

rm google_appengine_*
wget http://googleappengine.googlecode.com/files/google_appengine_1.8.0.zip

echo 'Extracting App Engine SDK'
unzip google_appengine_1.8.0.zip

echo 'Moving to ~/bin'
rm -rf ~/bin/google_appengine
mv -f google_appengine ~/bin

echo 'Adding and ~/bin/google_appengine to path'
echo "PATH=\"\$HOME/bin/google_appengine:\$PATH\"" >> ~/.profile
source ~/.profile


echo 'Downloading App Server script'

cd ~/bin

wget -O app-server http://pastie.org/pastes/5489856/download?key=nrv7i9z3tj4xhg2xr8zxgg
chmod +x app-server
