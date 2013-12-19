!/bin/bash

set -e

#Script to bootstrap an App Engine development environment.

sudo echo 'Development Environment Bootstrap Script'

echo 'Installing Ubuntu Packages with apt'

sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo add-apt-repository ppa:chris-lea/node.js

sudo apt-get update
sudo apt-get -yq install build-essential git git-extras wget zip unzip p7zip python-crypto python-httplib2 python-imaging python-lxml python-markupsafe python-oauth python-openssl python-pip python-setuptools python-simplejson phantomjs nodejs sublime-text

echo 'Installing Python Packages with pip'

sudo pip install unittest2 Jinja2 GitPython Sphinx WebOb WebTest pyflakes beautifulsoup4 nose
sudo pip install --pre ferrisnose

echo 'Installing Karma'

sudo npm install -g karma

echo 'Downloading App Engine SDK'

cd /tmp

LATEST_APPENGINE=$(python -c "from httplib2 import Http; from bs4 import BeautifulSoup; http = Http(); r, c = http.request('http://developers.google.com/appengine/downloads'); soup = BeautifulSoup(c); links = soup.select('a[href*=".zip"]'); print links[0]['href'];")

if [ ! "$LATEST_APPENGINE" ]; then
    echo "Oh no, couldn't find the latest App Engine. This script may need some adjusting!"
fi

rm google_appengine_*

wget $LATEST_APPENGINE

echo 'Extracting App Engine SDK'
unzip google_appengine_*

echo 'Installing App Engine SDK'
rm -rf ~/bin/google_appengine
mkdir -p ~/bin
mv -f google_appengine ~/bin

echo 'Configuring Path'
echo $'\n# Google App Engine\n\nPATH=\"$HOME/bin/google_appengine:$PATH\"\nexport APPENGINE_SDK_PATH=$HOME/bin/google_appengine' >> ~/.profile
source ~/.profile


echo 'Downloading Support Scripts (app-server and ferris-tests)'

cd ~/bin

wget -O app-server https://bitbucket.org/cloudsherpas/ubuntu-environment-bootstrap/raw/master/app-server.sh
chmod +x app-server

wget -O ferris-tests https://bitbucket.org/cloudsherpas/ubuntu-environment-bootstrap/raw/master/ferris-tests.sh
chmod +x ferris-tests
