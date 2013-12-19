#!/bin/bash

nosetests --with-ferris --logging-level=INFO --gae-sdk-path=$HOME/google-cloud-sdk/platform/google_appengine $@
