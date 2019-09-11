#!/bin/sh

if [ $# = 0 ]; then
    EXEC="bin/magento"
else
    EXEC="$1"
fi

if [ "$($EXEC setup:db:status 2>&1 1>/dev/null)" != "All modules are up to date." ]; then
    $EXEC cron:remove
    $EXEC maintenance:enable
    $EXEC setup:upgrade --keep-generated
    $EXEC maintenance:disable
    $EXEC cron:install
fi

exit 0

