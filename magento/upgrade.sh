#!/bin/sh

if [ $# = 0 ]; then
    PHP_EXEC="php"
    EXEC="bin/magento"
else
    if [ $# = 2 ]; then
        PHP_EXEC=$1
        EXEC=$2
    else
        PHP_EXEC=$1
        EXEC="bin/magento"
    fi
fi

STATE_MESSAGE="$($PHP_EXEC $EXEC setup:db:status 2>/dev/null 1>&1)"

if [[ $STATE_MESSAGE != "All modules are up to date." ]]; then
    CMDS=(
        "cron:remove" 
        "maintenance:enable" 
        "setup:upgrade --keep-generated" 
        "maintenance:disable" 
        "cron:install" 
    )

    for CMD in "${CMDS[@]}"; do
        MESSAGE="$($PHP_EXEC $EXEC $CMD 2>/dev/null 1>&1)"
        RESULT=$?
        if [ "$RESULT" != 0 ]; then
            echo -e "\e[41m$MESSAGE\e[0m"
            exit $RESULT
        else
            echo -e "\e[42m$MESSAGE\e[0m"
        fi
    done
else
    echo -e "\e[42m$STATE_MESSAGE\e[0m"
fi

exit 0

