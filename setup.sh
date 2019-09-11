#!/bin/sh

if [ $# == 0 ]; then
    echo -e "\e[41mInvalid argument count."
    echo -e "Enter option --help for the documentation.\e[0m"
    exit 1
fi

for i in "$@"; do
    if [ ! -f "./setup/$i.sh" ]; then
        echo -e "\e[41m$i is not a valid setup script.\e[0m"
        exit 1
    fi
done

for i in "$@"; do
    MESSAGE="$(./setup/$i.sh 2>&1 1>/dev/null)"
    RESULT=$?
    if [ "$RESULT" != 0 ]; then
        echo -e "\e[41m$MESSAGE\e[0m"
        exit $RESULT
    else
        echo -e "\e[42m$i has been successfully installed!\e[0m"
    fi
done

exit $RESULT

