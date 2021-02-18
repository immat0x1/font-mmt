#!/bin/sh

# Font-MMT by @immat0x1 | @aloetg
# Based on MMT-EX by @Zackptg5

# Variables
xml=/system/etc/fonts.xml
sf=/system/fonts
spf=/system/product/fonts
mpf=$MODPATH/Fonts
mpr=$MODPATH/Roboto
modsf=$MODPATH/system/fonts
mxml=$(magisk --path)/.magisk/mirror/system/etc/fonts.xml
msf=$(magisk --path)/.magisk/mirror/system/fonts
mspf=$(magisk --path)/.magisk/mirror/system/product/fonts
name=$(grep_prop name $MODPATH/module.prop)

r=Regular it=Italic m=Medium b=Bold
t=Thin l=Light bl=Black s=SemiBold
exl=ExtraLight exb=ExtraBold c=Condensed mo=Mono

for otf in $mpf/*.otf; do mv "$otf" "${otf%otf}ttf"; done
for woff in $mpf/*.woff; do mv "$woff" "${woff%woff}ttf"; done

drafm() {
find /data/adb/modules -path \*system/fonts | cut -d'/' -f-5 | while read line; do
modupd=${line//modules/modules_update}
if [ ! -f "$line$sf/NotoColorEmoji.ttf" ] && [[ "$line" != "$MODPATH" ]] && [[ "$modupd" != "$MODPATH" ]] && [ ! -f "$line$sf/NotoSansSymbols-Regular-Subsetted2.ttf" ]; then
cd $line; rm -rf disable update remove; touch $1; chmod 644 $1; fi; done
}

clean_up() {
for uf in Noto DancingScript DroidSans ComingSoon CarroisGothicSC; do rm -rf $modsf/*$uf*.*; done
[ ! -f "$mpf/$mo.ttf" ] && rm -rf $modsf/*$mo*.*
rm -rf $mpr $mpf $MODPATH/ExampleFontNames
}

place_font() {
find $1 -type f -name "*$2*" | sed 's/.*\(system\)/\1/g' | while read line; do cp -ar $mpf/$3.ttf $MODPATH/$line; done
}

main_func() {
mkdir -p $MODPATH$2 && cd $1

### USE_AS_REGULAR
if [ ! "$USE_AS_REGULAR" = "$r" ] && [ -f "$mpf/$USE_AS_REGULAR.ttf" ]; then
$3 "* $USE_AS_REGULAR.ttf will be used instead of $r.ttf"
ls -1 | while read line; do cp -ar $mpf/$USE_AS_REGULAR.ttf $MODPATH$2/$line; done
[ -f "$mpf/$USE_AS_REGULAR$it.ttf" ] && place_font $1 $it $USE_AS_REGULAR$it
else ls -1 | while read line; do cp -ar $mpf/$r.ttf $MODPATH$2/$line; done
[ -f "$mpf/$it.ttf" ] && place_font $1 $it $it; fi

### Non-Condensed ###
for f in $b $b$it $m $m$it $bl $bl$it $t $t$it $l $l$it $s $s$it $exb $exb$it $exl $exl$it $mo; do
[ -f "$mpf/$f.ttf" ] && place_font $1 $f $f; done

### Condensed ###
for cf in $c-$b $c-$b$it $c-$m $c-$m$it $c-$l $c-$l$it; do
[ -f "$mpf/$cf.ttf" ] && place_font $1 $cf $cf; done
}

b_roboto() {
[ -f "$mxml" ] && mkdir -p $MODPATH/system/etc $mpr && cp -af $mxml $MODPATH$xml
sed -i '/"sans-serif">/,/family>/H;1,/family>/{/family>/G}'	$MODPATH$xml
sed -i ':a;N;$!ba;s/ name=\"sans-serif\"/ name="backup-roboto"/2' $MODPATH$xml
sed -i '/\"backup-roboto\">/,/family>/{s/Roboto-/Backup-Roboto-/}' $MODPATH$xml
sed -i 's/ name="backup-roboto"//g' $MODPATH$xml
find $msf -type f -name "Roboto-*" | while read line; do
cp -aR $line $mpr; done
cd $mpr && for r in *; do mv "$r" $modsf/Backup-"$r"; done
}

if [ -f "$mpf/$r.ttf" ]; then
main_func "$msf" "$sf" "ui_print"
[ -d "$mspf" ] && main_func "$mspf" "$spf"
else abort "* $r.ttf: Required, but not found"; fi

# Flags
if [ "$DAFM" = "true" ] && [ "$RAFM" = "true" ]; then
export DAFM=false RAFM=false; fi
[ "$RAFM" = "true" ] && drafm remove
[ "$DAFM" = "true" ] && drafm disable
[ "$KEEP_ONLY_ROBOTO" = "true" ] && find $modsf -type f ! -name "*Roboto*" -exec rm -rf {} \; && rm -rf $MODPATH/system/product
[ "$WEIGHT_IN_MODNAME" = "true" ] && sed -i "s/name=$name/name=$name $USE_AS_REGULAR/g" $MODPATH/module.prop

b_roboto && clean_up