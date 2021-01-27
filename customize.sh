
# MMT-EX Config Flags

# MINAPI=21
# MAXAPI=25
# DYNLIB=false
# DEBUG=false

# F-MMT Config Flags

# With this flag you can choose which font will be used instead of Regular
# Example: USE_AS_REGULAR=Bold
USE_AS_REGULAR=Regular

# With this flag you can enable automatical removing of all other font modules during installation
# Change "false" to "true" to enable this flag
DELETE_ANOTHER_FONT_MODULES=false

# MMT-EX Logic
SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh
