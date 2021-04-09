# F-MMT Config Flags
USE_AS_REGULAR=Regular # Custom Regular font weight
USE_AS_MEDIUM=Medium # Same, but Medium
REPLACE_ONLY=false # Replace only <font_name>
REPLACE_ONLY_IN=false # Replace only in <directory_name>
WEIGHT_IN_VERSION=true # Example: v2.1-Regular
DEBUG=false # If u need logs with detailed info

# MMT-EX Logic
SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh