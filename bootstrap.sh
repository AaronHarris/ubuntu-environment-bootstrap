!/bin/bash

set -e

#Script to bootstrap an App Engine development environment.

sudo echo 'Development Environment Bootstrap Script'

echo 'Adding package sources. Be sure to accept the next couple of prompts'
echo 'Press enter when you feel like you are ready to party'
read _

sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo add-apt-repository ppa:chris-lea/node.js
sudo add-apt-repository ppa:webupd8team/java

sudo apt-get update

echo 'Installing Ubuntu Packages with apt'

# Accept oracle license
sudo echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get -yq install curl wget build-essential git git-extras wget zip unzip p7zip python-crypto python-httplib2 python-imaging python-lxml python-markupsafe python-oauth python-openssl python-pip python-setuptools python-simplejson phantomjs nodejs sublime-text-installer oracle-java7-installer

echo 'Installing Python Packages with pip'

sudo pip install unittest2 Jinja2 GitPython Sphinx WebOb WebTest flake8 pyflakes beautifulsoup4 nose
sudo pip install --pre ferrisnose

echo 'Installing Node packages (karma, jshint, bower)'

sudo npm install -g karma jshint bower

echo 'Downloading Cloud SDK'

cd ~

# Download
wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz
tar xzvpf google-cloud-sdk.tar.gz
rm google-cloud-sdk.tar.gz

# Silent install
env CLOUDSDK_REINSTALL_COMPONENTS=pkg-core,pkg-python ./google-cloud-sdk/install.sh

# Configure path
echo "PATH=\"\$HOME/google-cloud-sdk/bin:\$PATH\"" >> ~/.profile
echo "export APPENGINE_SDK_PATH=\$HOME/google-cloud-sdk/platform/google_appengine" >> ~/.profile

echo 'Downloading Support Scripts (app-server and ferris-tests)'

cd ~/bin

wget -O app-server https://bitbucket.org/cloudsherpas/ubuntu-environment-bootstrap/raw/master/app-server.sh
chmod +x app-server

wget -O ferris-tests https://bitbucket.org/cloudsherpas/ubuntu-environment-bootstrap/raw/master/ferris-tests.sh
chmod +x ferris-tests
