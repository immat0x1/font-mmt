# F-MMT Config Flags

# USE_AS_REGULAR
# Choose which font will be used instead of Regular
# Example: UAR=Bold
USE_AS_REGULAR=Regular

# Auto-removing/disabling of all other font modules during installation
# Change "false" to "true" to enable this flag
# Remove Another Font Modules
RAFM=false

# Disable Another Font Modules
DAFM=false

# Replace only Roboto Font Family
# With this flag you can enable replacement of Roboto fonts only
# Not working on ROMs with /system/product/fonts directory
REPLACE_ONLY_ROBOTO=false

# Add font weight in Module Name
# Example: GoogleSans Medium
WEIGHT_IN_MODNAME=true

# MMT-EX Logic
SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh