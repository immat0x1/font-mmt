#!/bin/sh

# Simple Font-MMT by @immat0x1
# Support channel: @aloetg
# Based on MMT-EX by @Zackptg5
# Feel free to modify this for your purposes, but keep authorship

# Variables
mpf=$MODPATH/Fonts
xml=/system/etc/fonts.xml
mxml=$(magisk --path)/.magisk/mirror/system/etc/fonts.xml
sf=/system/fonts
msf=$(magisk --path)/.magisk/mirror/system/fonts
spf=/system/product/fonts
mspf=$(magisk --path)/.magisk/mirror/system/product/fonts

t=Thin l=Light
r=Regular b=Bold
it=Italic m=Medium
bl=Black c=Condensed
s=Semibold exl=ExtraLight
exb=ExtraBold

[ -f $xml ] && mkdir -p $MODPATH$sf && mkdir -p $MODPATH/system/etc && cp -af $mxml $MODPATH$xml
sed -i '/"sans-serif">/,/family>/H;1,/family>/{/family>/G}'	$MODPATH$xml
sed -i ':a;N;$!ba;s/ name=\"sans-serif\"/ name="backup-roboto"/2' $MODPATH$xml
sed -i '/\"backup-roboto\">/,/family>/{s/Roboto-/Backup-Roboto-/}' $MODPATH$xml
sed -i 's/ name="backup-roboto"//g' $MODPATH$xml
mkdir $MODPATH/Roboto
find $msf -type f -name "Roboto*" | while read line; do
cp -aR $line $MODPATH/Roboto; done

# DELETE_ANOTHER_FONT_MODULES
dafm() {
find /data/adb/modules -path \*$1 | cut -d'/' -f-5 | while read line; do
[ ! $line = "$MODPATH" ] && [ ! -f $line$sf/NotoColorEmoji.ttf ] && rm -rf $line; ui_print " "; ui_print "* Found conflicting module!"; ui_print "* Deleting $line..."
line=${line//modules/modules_update}
[ -d $line ] && [ ! $line = "$MODPATH" ] && [ ! -f $line$sf/NotoColorEmoji.ttf ] && rm -rf $line; ui_print " "; ui_print "* Found conflicting module!"; ui_print "* Deleting $line..."; done
}

# All to ttf
for otf in $mpf/*.otf; do
[ -f "$otf" ] && mv "$otf" "${otf%otf}ttf"; done
for woff in $mpf/*.woff; do
[ -f "$woff" ] && mv "$woff" "${woff%woff}ttf"; done

# Checking for Regular.ttf
[ ! -f $mpf/$r.ttf ] && abort "* $r.ttf: not found"

place_font() {
find $1 -type f -name "*$2*" | cut -d'/' -f6- | while read line; do
cp -ar $mpf/$2.ttf $MODPATH/$line; done
}

replace_font() {
find $1 -type f -name "*$2*" | cut -d'/' -f6- | while read line; do
cp -ar $mpf/$3.ttf $MODPATH/$line; done
}

main_func() {
mkdir -p $MODPATH$2
cd $1

# USE_AS_REGULAR
if [ ! $USE_AS_REGULAR = "$r" ] && [ -f "$mpf/$USE_AS_REGULAR.ttf" ]; then
$3 "* You chose $USE_AS_REGULAR instead of $r"
ls | while read line; do
cp -ar $mpf/$USE_AS_REGULAR.ttf $MODPATH$2/$line; done
[ -f "$mpf/$USE_AS_REGULAR$it.ttf" ] && replace_font $1 $it $USE_AS_REGULAR$it
else
ls | while read line; do
cp -ar $mpf/$r.ttf $MODPATH$2/$line; done; fi

### Non-Condensed ###
for f in $it $b $b$it $m $m$it $bl $bl$it $t $t$it $l $l$it $s $s$it $exb $exb$it $exl $exl$it; do
[ -f $mpf/$f.ttf ] && place_font $1 $f; done

### Condensed ###
for cf in $c-$r $c-$it $c-$b $c-$b$it $c-$m $c-$m$it $c-$l $c-$l$it; do
[ -f $mpf/$cf.ttf ] && place_font $1 $cf; done

# Clean-up unnecessary
for uf in Noto Mono DancingScript DroidSans ComingSoon CarroisGothicSC; do
find $MODPATH$2 -name "*$uf*.*" -exec rm -rf {} \;; done
}

# Start
[ $DELETE_ANOTHER_FONT_MODULES = "true" ] && dafm "system/fonts"
main_func "$msf" "$sf" "ui_print"

# Check if ROM have /system/product/fonts directory
[ -d $mspf ] && main_func "$mspf" "$spf"; [ $DELETE_ANOTHER_FONT_MODULES = "true" ] && dafm "system/product/fonts"

# Restoring Roboto for fixing glyphs
cd $MODPATH/Roboto
find . -name "*Condensed*" -exec rm -rf {} \;
rm -rf $MODPATH/ExampleFontNames
for a in *; do mv "$a" $MODPATH$sf/Backup-"$a"; done
rm -rf $MODPATH/Roboto
rm -rf $MODPATH/Fonts