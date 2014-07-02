#!/bin/bash

sudo apt-add-repository -y ppa:chris-lea/node.js 
sudo apt-get update
sudo apt-get install nodejs
npm config set prefix /usr
sudo npm install -g npm
npm config set prefix ~/.npm-packages

# Inject paths in ~/.profile.

NPMPATHSTR="PATH=\"\$HOME/.npm-packages/bin:\$PATH\"";
NODEPATHSTR="export NODE_PATH=\"\$HOME/.npm-packages/lib/node_modules:\$NODE_PATH\"";

if ! grep -Fxq "$NPMPATHSTR" ~/.profile; then
    echo "$NPMPATHSTR" >> ~/.profile;
else
    echo 'User npm-packages already in path.';
fi
if ! grep -Fxq "$NODEPATHSTR" ~/.profile; then
    echo "$NODEPATHSTR" >> ~/.profile;
else
    echo 'User npm-packages already in node path.';
fi

source ~/.profile
npm install -g karma-cli gulp bower yo
