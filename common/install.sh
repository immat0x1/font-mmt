#!/bin/sh

# Simple Font-MMT by @immat0x1
# Support channel: @aloetg
# Based on MMT-EX by @Zackptg5
# Feel free to modify this for your purposes, but keep authorship

# Variables
mpf=$MODPATH/Fonts
device=$(getprop ro.build.product)
evox=$(getprop ro.product.system.name)
t=Thin
l=Light
r=Regular
b=Bold
it=Italic
m=Medium
bl=Black
c=Condensed
s=Semibold
exl=ExtraLight
exb=ExtraBold

# DELETE_ANOTHER_FONT_MODULES
dafm() {
if [ $DELETE_ANOTHER_FONT_MODULES = "true" ]; then
find /data/adb/modules -path \*$1 | cut -d'/' -f-5 | while read line; do
ui_print " "
ui_print "* Found conflicting module!"
ui_print "* Deleting $line..."
rm -rf $line; done; fi
}

# All to ttf
for otf in $mpf/*.otf; do
[ -f "$otf" ] && mv "$otf" "${otf%otf}ttf"
done
for woff in $mpf/*.woff; do
[ -f "$woff" ] && mv "$woff" "${woff%woff}ttf"
done

# Checking for Regular.ttf
if [ ! -f $mpf/$r.ttf ]; then
abort "* Required $r.ttf does not exist!"; fi

# Function #1
find_font() {
find $1 -type f -name "*$2*" | while read line; do
cp -ar $mpf/$2.ttf $MODPATH$line
done
}

find_font_ex() {
find $1 -type f -name "*$2*" | while read line; do
cp -ar $mpf/$3.ttf $MODPATH$line
done
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
cp -ar $mpf/$USE_AS_REGULAR.ttf $MODPATH$1/$line
done
else
ls | while read line; do
cp -ar $mpf/$r.ttf $MODPATH$1/$line
done
fi


# Italic
if [ -f $mpf/$it.ttf ]; then
find_font $1 $it; fi

# Bold/BoldItalic
if [ -f $mpf/$b.ttf ]; then
find_font $1 $b; fi
if [ -f $mpf/$b$it.ttf ]; then
find_font $1 $b$it; fi

# Medium/MediumItalic
if [ -f $mpf/$m.ttf ]; then
find_font $1 $m; fi
if [ -f $mpf/$m$it.ttf ]; then
find_font $1 $m$it; fi

# Black/BlackItalic
if [ -f $mpf/$bl.ttf ]; then
find_font $1 $bl
find_font $1 $exb; fi
if [ -f $mpf/$bl$it.ttf ]; then
find_font $1 $bl$it
find_font $1 $exb$it; fi

# Thin/ThinItalic
if [ -f $mpf/$t.ttf ]; then
find_font $1 $t
find_font $1 $exl; fi
if [ -f $mpf/$t$it.ttf ]; then
find_font $1 $t$it
find_font $1 $exl$it; fi

# Light/LightItalic
if [ -f $mpf/$l.ttf ]; then
find_font $1 $l; fi
if [ -f $mpf/$l$it.ttf ]; then
find_font $1 $l$it; fi

# SemiBold/SemiBold Italic
if [ -f $mpf/$s.ttf ]; then
find_font $1 $s; fi
if [ -f $mpf/$s$it.ttf ]; then
find_font $1 $s$it; fi

# ExtraBold/ExtraBoldItalic
if [ -f $mpf/$exb.ttf ]; then
find_font_ex $1 $exb $bl; fi
if [ -f $mpf/$exb$it.ttf ]; then
find_font_ex $1 $exb$it $bl$it; fi

# ExtraLight/ExtraLightItalic
if [ -f $mpf/$exl.ttf ]; then
find_font_ex $1 $exl $t; fi
if [ -f $mpf/$exl$it.ttf ]; then
find_font_ex $1 $exl$it $t$it; fi


### Condensed Section ###

# C-Regular Font
if [ -f $mpf/$c-$r.ttf ]; then
find_font $1 $c-$r; fi

# C-Italic
if [ -f $mpf/$c-$it.ttf ]; then
find_font $1 $c-$it; fi

# C-Bold/BoldItalic
if [ -f $mpf/$c-$b.ttf ]; then
find_font $1 $c-$b; fi
if [ -f $mpf/$c-$b$it.ttf ]; then
find_font $1 $c-$b$it; fi

# C-Medium/MediumItalic
if [ -f $mpf/$c-$m.ttf ]; then
find_font $1 $c-$m; fi
if [ -f $mpf/$c-$m$it.ttf ]; then
find_font $1 $c-$m$it; fi

# C-Light/LightItalic
if [ -f $mpf/$c-$l.ttf ]; then
find_font $1 $c-$l; fi
if [ -f $mpf/$c-$l$it.ttf ]; then
find_font $1 $c-$l$it; fi

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