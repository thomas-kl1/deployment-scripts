#!/bin/sh

if [ $# = 0 ]; then
    EXEC="composer"
else
    EXEC="$1"
fi

MESSAGE="$($EXEC global require \
    edgedesign/phpqa \
    jakub-onderka/php-parallel-lint \
    squizlabs/php_codesniffer \
    friendsofphp/php-cs-fixer \
    phpmd/phpmd \
    sebastian/phpcpd \
    phpstan/phpstan \
    vimeo/psalm \
    phpunit/phpunit \
    sensiolabs/security-checker \
    pdepend/pdepend \
    --update-no-dev \
    2>&1 1>/dev/null \
)"
RESULT=$?
if [ "$RESULT" != 0 ]; then
    echo -e "\e[41m$MESSAGE\e[0m"
else
    echo -e "\e[42m$MESSAGE\e[0m"
fi

exit $RESULT

