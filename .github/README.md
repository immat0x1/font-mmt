# Font-MMT
Simple template for creating your own font magisk module

![logo](https://github.com/immat0x1/font-mmt/blob/main/.github/logo.png?raw=true)

### Features:
- Almost all ROMs supported
- Almost all fonts are replacing
- /system/product/fonts directory support
- Fast installation
- Many additional features in customize.sh

### Instruction:
- Firstly download font family which you need
- Unpack fonts in custom directory
- Rename all fonts, they must have only weight in name (Regular.ttf, BoldItalic.ttf, Condensed-Italic.ttf)
- Push them in fonts directory in F-MMT
- Edit module.prop
- Compress all the files in zip
- Flash

### Customize.sh flags:
- USE_AS_REGULAR and USE_AS_MEDIUM allow you to replace regular and medium thickness with any other
- REPLACE_ONLY intended to replace fonts with only a specific name
- REPLACE_ONLY_IN replaces fonts only in the selected directory
- DEBUG for detailed logs
- TEXT and HEADLINES to enable or disable headlines or regular text replacement

Based on MMT-EX by @Zackptg5, for changelog check changelog.md <br><br>
Contact [Me](https://t.me/immat0x1) if you have problems with F-MMT <br>
Check [AloeFonts](https://t.me/AloeFonts) for more font modules <br>