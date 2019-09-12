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

CMDS=(
    "setup:install" 
    "deploy:mode:set production" 
    "config:set dev/translate/translate_inline 0" 
    "config:set dev/translate/inline_active 0" 
    "config:set dev/js/merge_files 1" 
    "config:set dev/js/enable_js_bundling 1" 
    "config:set dev/js/minify_files 1" 
    "config:set dev/css/merge_css_files 1" 
    "config:set dev/css/minify_files 1" 
    "config:set dev/grid/async_indexing 1" 
    "indexer:reindex" 
    "cache:flush" 
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

exit $RESULT

