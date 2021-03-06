#!/bin/bash

NAME=${PWD##*/}
DATA_PATH=./.appengine_data/$NAME

if [ ! -d "$DATA_PATH" ]; then
    mkdir -p $DATA_PATH
fi

if [ -e "./.gitignore" ]; then
    if ! grep -Fxq ".appengine_data" .gitignore; then
        echo "Configuring gitignore"
        echo ".appengine_data" >> .gitignore
        git add .gitignore
        git commit .gitignore -m "Auto-ignoring App Engine local data"
    fi
fi

dev_appserver.py --storage_path=$DATA_PATH/storage --blobstore_path=$DATA_PATH/blobstore --datastore_path=$DATA_PATH/datastore --search_indexes_path=$DATA_PATH/searchindexes --show_mail_body=yes --host=0.0.0.0 --admin_host=0.0.0.0 $@ .
