# F-MMT Vars
mp=$(magisk --path)/.magisk/mirror
xml=/system/etc/fonts.xml
sf=/system/fonts
spf=/system/product/fonts
mpf=$MODPATH/Fonts
mpr=$MODPATH/Roboto
modsf=$MODPATH$sf
mxml=$mp$xml
msf=$mp$sf
mspf=$mp$spf

r=regular it=italic m=medium b=bold t=thin
l=light bl=black s=semi$b exl=extra$l
exb=extra$b c=condensed


# MMT-EX Logic
SKIPUNZIP=1
unzip -qjo "$ZIPFILE" 'common/functions.sh' -d $TMPDIR >&2
. $TMPDIR/functions.sh