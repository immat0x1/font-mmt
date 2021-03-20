# F-MMT Config Flags

# USE_AS_REGULAR
# Choose which font will be used instead of Regular
# After changing this flag, it is advisable to change
# the weight of the Medium font to a thicker one (using UAM)
# Example: USE_AS_REGULAR=Medium
USE_AS_REGULAR=Regular

# USE_AS_MEDIUM
# Choose which font will be used instead of Medium
# Example: USE_AS_MEDIUM=Bold
USE_AS_MEDIUM=Medium

# Replace only Roboto Font Family
# With this flag you can enable replacement of Roboto fonts only
# Not working on ROMs with /system/product/fonts directory
REPLACE_ONLY_ROBOTO=false

# Add font weight in Module Version
# Example: v1.9-Medium
WEIGHT_IN_VERSION=true

# Use this if something not working and I asked you for logs
# Don't forget to tap 'Save' button after installation
# Log will be saved in /sdcard/Download/magisk_install_log...
DEBUG=false

# MMT-EX Logic
SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh