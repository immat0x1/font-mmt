#!/bin/sh
# Font-MMT by @immat0x1 | @AloeFonts
# Based on MMT-EX by @Zackptg5
mp=$(magisk --path)/.magisk/mirror
xml=/system/etc/fonts.xml
sf=/system/fonts
spf=/system/product/fonts
mpf=$MODPATH/fonts
modsf=$MODPATH$sf
modspf=$MODPATH$spf
mxml=$mp$xml
msf=$mp$sf
mspf=$mp$spf

r=regular it=italic m=medium b=bold t=thin
l=light bl=black s=semi$b exl=extra$l
exb=extra$b c=condensed mo=mono

VER=$(grep_prop version $MODPATH/module.prop)
UAR=$(echo $USE_AS_REGULAR | tr 'A-Z' 'a-z')
UAM=$(echo $USE_AS_MEDIUM | tr 'A-Z' 'a-z')

cd $mpf
for i in `ls`; do
    mv $i `echo $i | tr 'A-Z' 'a-z' | cut -f 1 -d '.'`
done

place_font() {
    find $1 -type f -iname "*$2*" | sed 's/.*\(system\)/\1/g' | while read line; do
        cp $mpf/$3 $MODPATH/$line
    done
}

main() {
    mkdir -p $MODPATH$2 && cd $1

    if [ ! "$UAR" = "$r" ] && [ -f "$mpf/$UAR" ]; then
        ls | while read line; do
            cp $mpf/$UAR $MODPATH$2/$line
        done
        [ -f "$mpf/$UAR$it" ] && place_font $1 $it $UAR$it
    else
        ls | while read line; do
            cp $mpf/$r $MODPATH$2/$line
        done
        [ -f "$mpf/$it" ] && place_font $1 $it $it
    fi

    if [ ! "$UAM" = "$m" ] && [ -f "$mpf/$UAM" ]; then
        place_font $1 $m $UAM; [ -f "$mpf/$UAM$it" ] && place_font $1 $m$it $UAM$it
    else
        place_font $1 $m $m; [ -f "$mpf/$it" ] && place_font $1 $m$it $m$it
    fi

    for f in $b $b$it $bl $bl$it $t $t$it $l $l$it $s $s$it $exb $exb$it $exl $exl$it \
        $c-$r $c-$it $c-$b $c-$b$it $c-$m $c-$m$it $c-$l $c-$l$it; do
        [ -f "$mpf/$f" ] && place_font $1 $f $f
    done
}

if [ -f "$mpf/$r" ]; then
    main "$msf" "$sf"
    [ -d "$mspf" ] && main "$mspf" "$spf"
else
    abort "* Regular: Not found"
fi

# Flags
[ ! "$REPLACE_ONLY" = "false" ] && find $modsf $modspf -type f ! -iname "*$REPLACE_ONLY*" -exec rm -rf {} \;
[ "$WEIGHT_IN_VERSION" = "true" ] && sed -i "s/version=$VER/version=$VER-$USE_AS_REGULAR/g" $MODPATH/module.prop
if [ "$REPLACE_ONLY_IN" = "$sf" ]; then
    rm -rf $modspf
elif [ "$REPLACE_ONLY_IN" = "$spf" ]; then
    rm -rf $modsf
fi

# Backup Roboto
if [ -f "$mxml" ]; then
    mkdir -p $MODPATH/system/etc && cp $mxml $MODPATH$xml
    sed -i '/"sans-serif">/,/family>/H;1,/family>/{/family>/G}'	$MODPATH$xml
    sed -i ':a;N;$!ba;s/ name=\"sans-serif\"/ name="backup-roboto"/2' $MODPATH$xml
    sed -i '/\"backup-roboto\">/,/family>/{s/Roboto-/Backup-Roboto-/}' $MODPATH$xml
    sed -i 's/ name="backup-roboto"//g' $MODPATH$xml
    cd $msf && for r in `ls Roboto-*`; do
        cp $r $MODPATH$sf/Backup-$r
    done
else
    abort "* fonts.xml: Not found"
fi

for uf in Noto Mono DancingScript DroidSans ComingSoon CarroisGothicSC; do
    rm -rf $modsf/*$uf*
done
[ -f "$mpf/$mo" ] && place_font $msf $mo $mo
rm -rf $mpf $MODPATH/ExampleFontNames