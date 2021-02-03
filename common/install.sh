#!/bin/sh

# Simple Font-MMT by @immat0x1
# Support channel: @aloetg
# Based on MMT-EX by @Zackptg5
# Feel free to modify this for your purposes, but keep authorship

# Variables
mpf=$MODPATH/Fonts
xml=/system/etc/fonts.xml
sf=/system/fonts
spf=/system/product/fonts
mxml=$(magisk --path)/.magisk/mirror/system/etc/fonts.xml
msf=$(magisk --path)/.magisk/mirror/system/fonts
mspf=$(magisk --path)/.magisk/mirror/system/product/fonts

r=Regular it=Italic m=Medium
b=Bold t=Thin l=Light
bl=Black s=Semibold exl=ExtraLight
exb=ExtraBold c=Condensed mo=Mono

# Checking for Regular.ttf
[ ! -f $mpf/$r.ttf ] && abort "* $r.ttf: Required, but not found"

# mkdir work dirs
mkdir -p $MODPATH/Roboto $MODPATH/system/etc

# All to ttf
for otf in $mpf/*.otf; do
mv "$otf" "${otf%otf}ttf"; done
for woff in $mpf/*.woff; do
mv "$woff" "${woff%woff}ttf"; done

# DELETE_ANOTHER_FONT_MODULES
if [ $DELETE_ANOTHER_FONT_MODULES = "true" ]; then
find /data/adb/modules -path \*system/fonts | cut -d'/' -f-5 | while read line; do
[ ! $line = "$MODPATH" ] && [ ! -f $line$sf/NotoColorEmoji.ttf ] && [ ! -f $line$sf/NotoSansSymbols-Regular-Subsetted2.ttf ] && rm -rf $line
line=${line//modules/modules_update}
[ -d "$line" ] && [ ! $line = "$MODPATH" ] && [ ! -f "$line$sf/NotoColorEmoji.ttf" ] && [ ! -f "$line$sf/NotoSansSymbols-Regular-Subsetted2.ttf" ] && rm -rf $line
done
fi

place_font() {
find $1 -type f -name "*$2*" | cut -d'/' -f6- | while read line; do cp -ar $mpf/$3.ttf $MODPATH/$line; done
}

main_func() {
mkdir -p $MODPATH$2 && cd $1

# USE_AS_REGULAR
if [ ! $USE_AS_REGULAR = "$r" ] && [ -f "$mpf/$USE_AS_REGULAR.ttf" ]; then
$3 "* "
$3 "* You chose $USE_AS_REGULAR instead of $r"
ls | while read line; do
cp -ar $mpf/$USE_AS_REGULAR.ttf $MODPATH$2/$line; done
[ -f "$mpf/$USE_AS_REGULAR$it.ttf" ] && place_font $1 $it $USE_AS_REGULAR$it
else
ls | while read line; do
cp -ar $mpf/$r.ttf $MODPATH$2/$line; done; fi

### Non-Condensed ###
for f in $it $b $b$it $m $m$it $bl $bl$it $t $t$it $l $l$it $s $s$it $exb $exb$it $exl $exl$it $mo; do
[ -f $mpf/$f.ttf ] && place_font $1 $f $f; done

### Condensed ###
for cf in $c-$r $c-$it $c-$b $c-$b$it $c-$m $c-$m$it $c-$l $c-$l$it; do
[ -f $mpf/$cf.ttf ] && place_font $1 $cf $cf; done

# Clean-up unnecessary
for uf in Noto DancingScript DroidSans ComingSoon CarroisGothicSC; do
rm -rf $MODPATH$2/*$uf*.*; done
[ ! -f $mpf/$mo.ttf ] && rm -rf $MODPATH$2/*$mo*.*
}

# Start
main_func "$msf" "$sf" "ui_print"
# Check if ROM have /system/product/fonts directory
[ -d $mspf ] && main_func "$mspf" "$spf"

# Backuping Roboto for Glyph Fix
[ -f $mxml ] && cp -af $mxml $MODPATH$xml
sed -i '/"sans-serif">/,/family>/H;1,/family>/{/family>/G}'	$MODPATH$xml
sed -i ':a;N;$!ba;s/ name=\"sans-serif\"/ name="backup-roboto"/2' $MODPATH$xml
sed -i '/\"backup-roboto\">/,/family>/{s/Roboto-/Backup-Roboto-/}' $MODPATH$xml
sed -i 's/ name="backup-roboto"//g' $MODPATH$xml

find $msf -type f -name "Roboto*" | while read line; do
cp -aR $line $MODPATH/Roboto; done
cd $MODPATH/Roboto && rm -rf *Condensed*
for r in *; do mv "$r" $MODPATH$sf/Backup-"$r"; done

# Clean-up $MODPATH
rm -rf $MODPATH/Roboto $mpf $MODPATH/ExampleFontNames