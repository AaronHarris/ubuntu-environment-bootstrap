#!/bin/bash

NAME=${PWD##*/}
DATA_PATH=~/.appengine_data/$NAME

if [ ! -d "$DATA_PATH" ]; then
    mkdir -p $DATA_PATH
fi

~/bin/google_appengine/dev_appserver.py --storage_path=$DATA_PATH/storage --blobstore_path=$DATA_PATH/blobstore --datastore_path=$DATA_PATH/datastore --search_indexes_path=$DATA_PATH/searchindexes --show_mail_body=yes $@ .
