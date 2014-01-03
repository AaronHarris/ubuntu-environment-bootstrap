!/bin/bash

set -e

#Script to bootstrap an App Engine development environment.

sudo echo 'Development Environment Bootstrap Script'

echo 'Installing Ubuntu Packages with apt'

sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo add-apt-repository ppa:chris-lea/node.js

sudo apt-get update
sudo apt-get -yq install curl build-essential git git-extras wget zip unzip p7zip python-crypto python-httplib2 python-imaging python-lxml python-markupsafe python-oauth python-openssl python-pip python-setuptools python-simplejson phantomjs nodejs sublime-text-installer

echo 'Installing Python Packages with pip'

sudo pip install unittest2 Jinja2 GitPython Sphinx WebOb WebTest pyflakes beautifulsoup4 nose
sudo pip install --pre ferrisnose

echo 'Installing Karma'

sudo npm install -g karma

echo 'Downloading Cloud SDK'
echo 'About to download and run the Cloud SDK installer. Please be sure do the following:'
echo ' - Install in your home directory. (enter at the first prompt)'
echo ' - Either allow Google to collect data or not. (Y/n at second prompt)'
echo ' - Install the Python and PHP App Engine runtime. (2 at the third prompt) (you can install java later)'
echo ' - Allow it to update system path (enter at the fourth prompt)'
echo ' - Use ~/.bashrc (enter at the fifth prompt)'
echo ' - Enable completion (enter at the sixth prompt)'
echo 'Press enter when you feel like you are ready to party'

read _

curl https://dl.google.com/dl/cloudsdk/release/install_google_cloud_sdk.bash | bash

echo 'Downloading Support Scripts (app-server and ferris-tests)'

cd ~/bin

wget -O app-server https://bitbucket.org/cloudsherpas/ubuntu-environment-bootstrap/raw/master/app-server.sh
chmod +x app-server

wget -O ferris-tests https://bitbucket.org/cloudsherpas/ubuntu-environment-bootstrap/raw/master/ferris-tests.sh
chmod +x ferris-tests
