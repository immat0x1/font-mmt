# F-MMT Config Flags

USE_AS_REGULAR=Regular
# custom regular font weight

USE_AS_MEDIUM=Medium
# same, but medium

REPLACE_ONLY=false
# replace only <font_name> from system
# 'GoogleSans' or 'Roboto' or smth else idk

REPLACE_ONLY_IN=false
# replace fonts only in <directory_name>
# /system/fonts or /system/product/fonts

DEBUG=false
# logs with detailed info

HEADLINES=true
# headlines enabler/disabler

TEXT=true
# same, but for regular text

# MMT-EX Logic
SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh