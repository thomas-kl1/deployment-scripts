#!/bin/sh

if [ $# == 0 ]; then
    echo -e "\e[41mInvalid argument count."
    echo -e "Enter option --help for the documentation.\e[0m"
    exit 1
fi

for SETUPS in "$@"; do
    NAME=$(echo $SETUPS | cut -d'=' -f1)
    if [ ! -f "./setup/$NAME.sh" ]; then
        echo -e "\e[41m$NAME is not a valid setup script.\e[0m"
        EXIT=1
    fi
done

if [ -n "$EXIT" -a "$EXIT" = 1 ]; then
    exit 1
fi

for SETUPS in "$@"; do
    NAME=$(echo $SETUPS | cut -d'=' -f1)
    ARGUMENTS=$(echo $SETUPS | cut -d'=' -f2)
    MESSAGE="$(./setup/$NAME.sh $ARGUMENTS 2>&1 1>/dev/null)"
    RESULT=$?
    if [ "$RESULT" != 0 ]; then
        echo -e "\e[41m$MESSAGE\e[0m"
        exit $RESULT
    else
        echo -e "\e[42m$NAME has been successfully installed!\e[0m"
    fi
done

exit $RESULT

