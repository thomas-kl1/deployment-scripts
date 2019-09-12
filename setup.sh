#!/bin/sh

if [ $# == 0 ]; then
    echo -e "\e[41mInvalid argument count."
    echo -e "Enter option --help for the documentation.\e[0m"
    exit 1
fi

BASE_DIR=$(dirname $0)
BASE_DIR_SETUP="$BASE_DIR/setup/"

for SETUP in "$@"; do
    NAME=$(echo $SETUP | cut -d'=' -f1)
    if [ ! -f "$BASE_DIR_SETUP$NAME.sh" ]; then
        echo -e "\e[41m$NAME is not a valid setup script.\e[0m"
        EXIT=1
    fi
done

if [ -n "$EXIT" -a "$EXIT" = 1 ]; then
    exit 1
fi

for SETUP in "$@"; do
    if [[ $SETUP = *"="* ]]; then
        NAME=$(echo $SETUP | cut -d'=' -f1)
        ARGUMENTS=$(echo $SETUP | cut -d'=' -f2)
    else
        NAME=$SETUP
        ARGUMENTS=""
    fi
    MESSAGE="$($BASE_DIR_SETUP$NAME.sh $ARGUMENTS 2>&1 1>/dev/null)"
    RESULT=$?
    if [ "$RESULT" != 0 ]; then
        echo -e "\e[41m$MESSAGE\e[0m"
    else
        echo -e "\e[42m$NAME has been successfully installed!\e[0m"
    fi
done

exit $RESULT

