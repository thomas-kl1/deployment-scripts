#!/bin/sh

composer global require \
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
    --update-no-dev

