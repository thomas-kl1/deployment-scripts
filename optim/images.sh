#!/bin/sh

if [ $# = 0 ]; then
    DIRECTORY="pub/media/"
else
    DIRECTORY=$1
fi

cd $DIRECTORY
nohup sh -c "find -type f -iname \*.png -print0 | xargs -0 optipng -i1 -o7 -strip all -quiet" </dev/null >/dev/null 2>/dev/null &
nohup sh -c "find -type f -iname \*.jpg -print0 -o -type f -iname \*.jpeg -print0 | xargs -0 jpegoptim -m90 --strip-all --all-progressive --quiet" </dev/null >/dev/null 2>/dev/null &

exit 0

