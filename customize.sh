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
# With this flag you can enable replacement of Roboto fonts only
# Not working on ROMs with /system/product/fonts directory
KEEP_ONLY_ROBOTO=false

# Replace your System Emojis
# You must put the emoji font in the fonts folder
# Example: REPLACE_EMOJI=ios.ttf
REPLACE_EMOJI=false

# MMT-EX Logic
SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh
