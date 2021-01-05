#!/bin/sh

# Simple Font-MMT by @immat0x1
# Support channel: @aloetg
# Based on MMT-EX by @Zackptg5
# Feel free to modify this for your purposes, but keep authorship

# Variables
mpf=$MODPATH/Fonts
device=$(getprop ro.build.product)
evox=$(getprop ro.product.system.name)
t=Thin l=Light
r=Regular b=Bold
it=Italic m=Medium
bl=Black c=Condensed
s=Semibold exl=ExtraLight
exb=ExtraBold

# DELETE_ANOTHER_FONT_MODULES
dafm() {
[ $DELETE_ANOTHER_FONT_MODULES = "true" ] && find /data/adb/modules -path \*$1 | cut -d'/' -f-5 | while read line; do
ui_print " "
ui_print "* Found conflicting module!"
ui_print "* Deleting $line..."
rm -rf $line
line=${line//modules/modules_update}
[ -d $line ] && rm -rf $line; done
}

# All to ttf
for otf in $mpf/*.otf; do
[ -f "$otf" ] && mv "$otf" "${otf%otf}ttf"; done
for woff in $mpf/*.woff; do
[ -f "$woff" ] && mv "$woff" "${woff%woff}ttf"; done

# Checking for Regular.ttf
[ ! -f $mpf/$r.ttf ] && abort "* Required $r.ttf does not exist!"

# Function #1
find_font() {
find $1 -type f -name "*$2*" | while read line; do
cp -ar $mpf/$2.ttf $MODPATH$line; done
}

find_font_ex() {
find $1 -type f -name "*$2*" | while read line; do
cp -ar $mpf/$3.ttf $MODPATH$line; done
}

# Function #2
main_func() {
mkdir -p $MODPATH$1
cd $1

### Non-Condensed Section ###

# Regular
if [ ! $USE_AS_REGULAR = "Regular" ] && [ -f "$mpf/$USE_AS_REGULAR.ttf" ]; then
$2 "* You choosed $USE_AS_REGULAR instead of Regular"
ls | while read line; do
cp -ar $mpf/$USE_AS_REGULAR.ttf $MODPATH$1/$line; done
[ -f "$mpf/$USE_AS_REGULAR$it.ttf" ] && find_font_ex $1 $it $USE_AS_REGULAR$it
else
ls | while read line; do
cp -ar $mpf/$r.ttf $MODPATH$1/$line; done; fi


# Italic
[ -f $mpf/$it.ttf ] && find_font $1 $it

# Bold/BoldItalic
[ -f $mpf/$b.ttf ] && find_font $1 $b
[ -f $mpf/$b$it.ttf ] && find_font $1 $b$it

# Medium/MediumItalic
[ -f $mpf/$m.ttf ] && find_font $1 $m
[ -f $mpf/$m$it.ttf ] && find_font $1 $m$it

# Black/BlackItalic
[ -f $mpf/$bl.ttf ] && find_font $1 $bl; find_font $1 $exb
[ -f $mpf/$bl$it.ttf ] && find_font $1 $bl$it; find_font $1 $exb$it

# Thin/ThinItalic
[ -f $mpf/$t.ttf ] && find_font $1 $t; find_font $1 $exl
[ -f $mpf/$t$it.ttf ] && find_font $1 $t$it; find_font $1 $exl$it

# Light/LightItalic
[ -f $mpf/$l.ttf ] && find_font $1 $l
[ -f $mpf/$l$it.ttf ] && find_font $1 $l$it

# SemiBold/SemiBold Italic
[ -f $mpf/$s.ttf ] && find_font $1 $s
[ -f $mpf/$s$it.ttf ] && find_font $1 $s$it

# ExtraBold/ExtraBoldItalic
[ -f $mpf/$exb.ttf ] && find_font_ex $1 $exb $bl
[ -f $mpf/$exb$it.ttf ] && find_font_ex $1 $exb$it $bl$it

# ExtraLight/ExtraLightItalic
[ -f $mpf/$exl.ttf ] && find_font_ex $1 $exl $t
[ -f $mpf/$exl$it.ttf ] && find_font_ex $1 $exl$it $t$it


### Condensed Section ###

# C-Regular Font
[ -f $mpf/$c-$r.ttf ] && find_font $1 $c-$r

# C-Italic
[ -f $mpf/$c-$it.ttf ] && find_font $1 $c-$it

# C-Bold/BoldItalic
[ -f $mpf/$c-$b.ttf ] && find_font $1 $c-$b
[ -f $mpf/$c-$b$it.ttf ] && find_font $1 $c-$b$it

# C-Medium/MediumItalic
[ -f $mpf/$c-$m.ttf ] && find_font $1 $c-$m
[ -f $mpf/$c-$m$it.ttf ] && find_font $1 $c-$m$it

# C-Light/LightItalic
[ -f $mpf/$c-$l.ttf ] && find_font $1 $c-$l
[ -f $mpf/$c-$l$it.ttf ] && find_font $1 $c-$l$it

# Clean-up unnecessary
find $MODPATH$1 -name "AndroidClock*.*" -exec rm -rf {} \;
find $MODPATH$1 -name "Noto*.*" -exec rm -rf {} \;
find $MODPATH$1 -name "*Mono*.*" -exec rm -rf {} \;
rm -rf $MODPATH/ExampleFontNames
}

# Start
dafm "system/fonts"
main_func "/system/fonts" "ui_print"

# Check if ROM is Evolution X
if [ $evox = "evolution_$device" ]; then
ui_print " "
ui_print "* EvolutionX ROM Detected!"
ui_print "* /system/product/fonts path added..."
ui_print " "
dafm "system/product/fonts"
main_func "/system/product/fonts"
fi