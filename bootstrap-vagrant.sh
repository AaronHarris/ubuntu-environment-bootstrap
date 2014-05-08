#!/bin/bash

set -e

#Script to bootstrap an App Engine development environment.

sudo echo 'Development Environment Bootstrap Script'

echo 'Installing Ubuntu Packages with apt'

# Accept oracle license
sudo apt-get -yq install curl wget build-essential git git-extras wget zip unzip p7zip python-crypto python-httplib2 python-imaging python-lxml python-markupsafe python-oauth python-openssl python-pip python-setuptools python-simplejson nodejs npm

echo 'Installing Python Packages with pip'

sudo pip install unittest2 Jinja2 GitPython Sphinx WebOb WebTest flake8 pyflakes beautifulsoup4 nose
sudo pip install --pre ferrisnose

# Required to get PIL to work with app engine
if [ ! -h /usr/lib/python2.7/PIL ]; then
    if [ -d /usr/lib/python2.7/dist-packages/PIL ]; then
        sudo ln -s /usr/lib/python2.7/dist-packages/PIL /usr/lib/python2.7/PIL
    fi
    if [ -d /usr/local/lib/python2.7/dist-packages/PIL ]; then
        sudo ln -s /usr/local/lib/python2.7/dist-packages/PIL /usr/lib/python2.7/PIL
    fi
fi
if [ ! -h /usr/lib/python2.7/_imaging.so ]; then
    if [ -e /usr/lib/python2.7/dist-packages/_imaging.so ]; then
        sudo ln -s /usr/lib/python2.7/dist-packages/_imaging.so /usr/lib/python2.7/_imaging.so
    fi
    if [ -e /usr/local/lib/python2.7/dist-packages/_imaging.so ]; then
        sudo ln -s /usr/local/lib/python2.7/dist-packages/_imaging.so /usr/lib/python2.7/_imaging.so
    fi
fi

echo 'Installing Node packages (bower)'

sudo npm install -g bower

echo 'Downloading Cloud SDK'

cd /home/vagrant

# Download
wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz
tar xzvpf google-cloud-sdk.tar.gz
rm google-cloud-sdk.tar.gz

# Silent install
env CLOUDSDK_REINSTALL_COMPONENTS=pkg-core,pkg-python ./google-cloud-sdk/install.sh

# Configure path
echo "PATH=\"\$HOME/google-cloud-sdk/bin:\$HOME/bin:\$PATH\"" >> /home/vagrant/.profile
echo "export APPENGINE_SDK_PATH=\$HOME/google-cloud-sdk/platform/google_appengine" >> /home/vagrant/.profile

echo 'Downloading Support Scripts (app-server and ferris-tests)'

if [ ! -d /home/vagrant/bin ]; then
    mkdir /home/vagrant/bin
fi

cd /home/vagrant/bin

wget -O app-server https://bitbucket.org/cloudsherpas/ubuntu-environment-bootstrap/raw/master/app-server.sh
chmod +x app-server

wget -O ferris-tests https://bitbucket.org/cloudsherpas/ubuntu-environment-bootstrap/raw/master/ferris-tests.sh
chmod +x ferris-tests

# Link workspace
ln -s /vagrant /home/vagrant/workspace
