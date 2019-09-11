#!/bin/sh

if [ $# = 0 ]; then
    EXEC="composer"
else
    EXEC="$1"
fi

$EXEC install --ignore-platform-reqs --no-dev --no-ansi --no-interaction --no-progress

exit 0

