#!/bin/bash

export DIST=`lsb_release -c -s`

if [ "$DIST" == "debian" ] || [ "$DIST" == "ubuntu" ]
then
    bash bootstrap-${DIST}.sh
else
    echo "${DIST} is not supported."
    exit 1
fi

if [ $? -ne 0 ]; then
    echo "Unable to complete environment bootstrap."
    exit 1
fi
echo "Environment bootstrap completed successfully!"
