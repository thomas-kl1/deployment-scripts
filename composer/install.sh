#!/bin/sh

if [ $# = 0 ]; then
    EXEC="composer"
else
    EXEC="$1"
fi

MESSAGE="$($EXEC install --ignore-platform-reqs --no-dev --no-ansi --no-interaction --no-progress --optimize-autoloader 2>&1 1>/dev/null)"
RESULT=$?
if [ "$RESULT" != 0 ]; then
    echo -e "\e[41m$MESSAGE\e[0m"
    exit $RESULT
fi

echo -e "\e[42m$MESSAGE\e[0m"
exit 0

