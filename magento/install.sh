#!/bin/sh

if [ $# = 0 ]; then
    EXEC="bin/magento"
else
    EXEC="$1"
fi

$EXEC setup:install
$EXEC deploy:mode:set production
$EXEC config:set dev/translate/translate_inline 0
$EXEC config:set dev/translate/inline_active 0
$EXEC config:set dev/js/merge_files 1
$EXEC config:set dev/js/enable_js_bundling 1
$EXEC config:set dev/js/minify_files 1
$EXEC config:set dev/css/merge_css_files 1
$EXEC config:set dev/css/minify_files 1
$EXEC config:set dev/grid/async_indexing 1
$EXEC indexer:reindex
$EXEC cache:flush

exit 0

