#!/bin/sh

if [ \( -n "$1" \) -a \( "$1" = "--help" -o "$1" = "-h" \) ]; then
    echo -e "\e[33mUsage:"
    echo -e "./composer.sh <DIR> <FILE>"
    echo -e "Argument DIR: [optional] [default=/usr/local/bin/]"
    echo -e "Argument FILE: [optional] [default=composer]\e[0m"
    exit 0
fi

if [ $# = 0 ]; then
    DIR="/usr/local/bin/"
    FILE="composer"
else
    if [ $# = 2 ]; then
        DIR=$1
        FILE=$2
    else
        DIR=$1
        FILE="composer"
    fi
fi

if [ -f "$DIR/$FILE" ]; then
    MESSAGE="$(composer self-update 2>&1 1>/dev/null)"
    RESULT=$?
else
    EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then
        >&2 echo -e "\e[41mERROR: Invalid installer signature\e[0m"
        rm composer-setup.php
        exit 1
    fi

    mkdir -p $DIR

    MESSAGE="$(php composer-setup.php --quiet --install-dir=$DIR --filename=$FILE 2>&1 1>/dev/null)"
    RESULT=$?
    rm composer-setup.php
fi

RESULT=$?
if [ "$RESULT" != 0 ]; then
    echo -e "\e[41m$MESSAGE\e[0m"
else
    echo -e "\e[42m$MESSAGE\e[0m"
fi
exit $RESULT

