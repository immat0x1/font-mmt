#!/bin/sh

# Simple Font-MMT by @immat0x1
# Support channel: @aloetg
# Based on MMT-EX by @Zackptg5
# Feel free to modify this for your purposes, but keep authorship

# Variables
mpf=$MODPATH/Fonts
t=Thin l=Light
r=Regular b=Bold
it=Italic m=Medium
bl=Black c=Condensed
s=Semibold exl=ExtraLight
exb=ExtraBold

# DELETE_ANOTHER_FONT_MODULES
dafm() {
find /data/adb/modules -path \*$1 | cut -d'/' -f-5 | while read line; do
[ ! $line = $MODPATH ] && [ ! -f $line/system/fonts/NotoColorEmoji.ttf ] && rm -rf $line; ui_print " "; ui_print "* Found conflicting module!"; ui_print "* Deleting $line..."
line=${line//modules/modules_update}
[ -d $line ] && [ ! $line = $MODPATH ] && [ ! -f $line/system/fonts/NotoColorEmoji.ttf ] && rm -rf $line; ui_print " "; ui_print "* Found conflicting module!"; ui_print "* Deleting $line..."; done
}

# All to ttf
for otf in $mpf/*.otf; do
[ -f "$otf" ] && mv "$otf" "${otf%otf}ttf"; done
for woff in $mpf/*.woff; do
[ -f "$woff" ] && mv "$woff" "${woff%woff}ttf"; done

# Checking for Regular.ttf
[ ! -f $mpf/$r.ttf ] && abort "* $r.ttf: not found"

place_font() {
find $1 -type f -name "*$2*" | while read line; do
cp -ar $mpf/$2.ttf $MODPATH$line; done
}

replace_font() {
find $1 -type f -name "*$2*" | while read line; do
cp -ar $mpf/$3.ttf $MODPATH$line; done
}

main_func() {
mkdir -p $MODPATH$1
cd $1

# USE_AS_REGULAR
if [ ! $USE_AS_REGULAR = "$r" ] && [ -f "$mpf/$USE_AS_REGULAR.ttf" ]; then
$2 "* You chose $USE_AS_REGULAR instead of $r"
ls | while read line; do
cp -ar $mpf/$USE_AS_REGULAR.ttf $MODPATH$1/$line; done
[ -f "$mpf/$USE_AS_REGULAR$it.ttf" ] && replace_font $1 $it $USE_AS_REGULAR$it
else
ls | while read line; do
cp -ar $mpf/$r.ttf $MODPATH$1/$line; done; fi

### Non-Condensed ###
for f in $it $b $b$it $m $m$it $bl $bl$it $t $t$it $l $l$it $s $s$it $exb $exb$it $exl $exl$it; do
[ -f $mpf/$f.ttf ] && place_font $1 $f; done

### Condensed ###
for cf in $c-$r $c-$it $c-$b $c-$b$it $c-$m $c-$m$it $c-$l $c-$l$it; do
[ -f $mpf/$cf.ttf ] && place_font $1 $cf; done

# Clean-up unnecessary
for uf in AndroidClock Noto Mono DancingScript DroidSans ComingSoon CarroisGothicSC; do
find $MODPATH$1 -name "*$uf*.*" -exec rm -rf {} \;; done
rm -rf $MODPATH/ExampleFontNames
}

# Start
[ $DELETE_ANOTHER_FONT_MODULES = "true" ] && dafm "system/fonts"
main_func "/system/fonts" "ui_print"

# Check if ROM have /system/product/fonts directory
[ -d /system/product/fonts ] && main_func "/system/product/fonts"; [ $DELETE_ANOTHER_FONT_MODULES = "true" ] && dafm "system/product/fonts"