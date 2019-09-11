#!/bin/sh

if [ $# = 0 ]; then
    EXEC="composer"
else
    EXEC="$1"
fi

$EXEC install dump-autoload --optimize-autoloader --apcu

exit 0

