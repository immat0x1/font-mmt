# MMT-EX Config Flags

# MINAPI=21
# MAXAPI=25
# DYNLIB=false
# DEBUG=false

# F-MMT Config Flags

# Choose which font will be used instead of Regular
# Example: USE_AS_REGULAR=Bold
USE_AS_REGULAR=Regular

# Auto-removing of all other font modules during installation
# Change "false" to "true" to enable this flag
DELETE_ANOTHER_FONT_MODULES=false

# Keep only Roboto Font Family
# By enabling this flag you can disable the replacement
# of other fonts leaving only Roboto font family
# Not working on ROMs with /system/product/fonts directories
KEEP_ONLY_ROBOTO=false

# MMT-EX Logic
SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh
