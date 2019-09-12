#!/bin/sh

if [ $# = 0 ]; then
    EXEC="composer"
else
    EXEC="$1"
fi

MESSAGE="$($EXEC dump-autoload --optimize --apcu 2>&1 1>/dev/null)"
RESULT=$?
if [ "$RESULT" != 0 ]; then
    echo -e "\e[41m$MESSAGE\e[0m"
else
    echo -e "\e[42m$MESSAGE\e[0m"
fi
exit $RESULT

