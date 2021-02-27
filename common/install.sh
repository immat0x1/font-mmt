#!/bin/sh
# Font-MMT by @immat0x1 | @aloetg
# Based on MMT-EX by @Zackptg5

# Fonts to lowercase
cd $mpf && for i in `ls`; do new_name=`echo "$i" | tr 'A-Z' 'a-z'`
mv "$i" "Font-$new_name"; mv "Font-$new_name" "$new_name"; done

# Fonts to ttf 
find . -type f -name '*' -exec sh -c 'mv "$1" "${1%.*}.ttf"' sh_mv {} \;

place_font() {
find $1 -type f -iname "*$2*" | sed 's/.*\(system\)/\1/g' | while read line; do cp -ar $mpf/$2.ttf $MODPATH/$line; done
}

main_func() {
mkdir -p $MODPATH$2 && cd $1

ls -1 | while read line; do cp -ar $mpf/$r.ttf $MODPATH$2/$line; done
for f in $it $b $b$it $m $m$it $bl $bl$it $t $t$it $l $l$it $s $s$it $exb $exb$it $exl $exl$it \
$c-$r $c-$it $c-$b $c-$b$it $c-$m $c-$m$it $c-$l $c-$l$it; do
[ -f "$mpf/$f.ttf" ] && place_font $1 $f; done
}

if [ -f "$mpf/$r.ttf" ]; then
main_func "$msf" "$sf"
[ -d "$mspf" ] && main_func "$mspf" "$spf"
else abort "* Regular.ttf: Not found"; fi

# Backup Roboto
[ -f "$mxml" ] && mkdir -p $MODPATH/system/etc $mpr && cp -af $mxml $MODPATH$xml
sed -i '/"sans-serif">/,/family>/H;1,/family>/{/family>/G}'	$MODPATH$xml
sed -i ':a;N;$!ba;s/ name=\"sans-serif\"/ name="backup-roboto"/2' $MODPATH$xml
sed -i '/\"backup-roboto\">/,/family>/{s/Roboto-/Backup-Roboto-/}' $MODPATH$xml
sed -i 's/ name="backup-roboto"//g' $MODPATH$xml
ls $msf/Roboto-* | while read line; do cp -aR $line $mpr; done
for rob in $mpr/*; do mv "$rob" $modsf/Backup-"$rob"; done

for uf in Noto Mono DancingScript DroidSans ComingSoon CarroisGothicSC; do rm -rf $modsf/*$uf*.*; done
rm -rf $mpr $mpf $MODPATH/ExampleFontNames