#!/bin/sh

if [ $# = 0 ]; then
    DIRECTORY="pub/media/import/"
else
    DIRECTORY=$1
fi

cd $DIRECTORY
rm -f *.jpeg *.JPEG *.jpg *.JPG *.png *.PNG

exit 0

