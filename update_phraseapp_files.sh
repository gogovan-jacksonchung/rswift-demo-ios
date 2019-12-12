#!/bin/sh
ACCESS_TOKEN="fc15db0f3cb06015ba5c4539de3686591e53ad4a9f1e28496933cc930db7d174"

# PhraseApp project properties
CA_PROJECT_ID="1fcf321d4f11502bfb99f57106929467"
LOCALE_ID_EN_HK="1e390afae897929945f5da1bc126f25d"
LOCALE_ID_EN_SG="7c5d648302e1f4a19e5d6c98a0919630"
LOCALE_ID_ZH_TW="f8ddd0e8b587405948e611c9a853ab35"
LOCALE_ID_ZH_HK="8b3d0df6ae780a5a03e3a26ec57409fc"

LOCALE_ID_EN_BASE="25fdec994aadb425a25b03db8c2f0aed"
LOCALE_ID_ZH_BASE="5890b0b0a58e626892ef6e05a3310bd5"

# PhraseApp API Reference: https://developers.phraseapp.com/api/#locales_download
PHRASEAPP_API="https://api.phrase.com/v2/projects"
COMMON_PARAM_EN="convert_emoji=true&encoding=UTF-8&include_unverified_translations=true&include_pluralized_keys=true&include_empty_translations=true&format_options%5Bconvert_placeholder%5D=true&fallback_locale_id=$LOCALE_ID_EN_BASE"
COMMON_PARAM_ZH="convert_emoji=true&encoding=UTF-8&include_unverified_translations=true&include_pluralized_keys=true&include_empty_translations=true&format_options%5Bconvert_placeholder%5D=true&fallback_locale_id=$LOCALE_ID_ZH_BASE"

RESOURCE_FOLDER_PATH="./RSwiftDemo/Resources"

# en-HK
echo "Downloading en files"
LOCALE_FOLDER_NAME="en.lproj"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_EN_HK/download?file_format=strings&$COMMON_PARAM_EN" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.strings"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_EN_HK/download?file_format=stringsdict&$COMMON_PARAM_EN" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.stringsdict"

# zh-HK
echo "Downloading zh-HK files"
LOCALE_FOLDER_NAME="zh-HK.lproj"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_ZH_HK/download?file_format=strings&$COMMON_PARAM_ZH" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.strings"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_ZH_HK/download?file_format=stringsdict&$COMMON_PARAM_ZH" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.stringsdict"

# en-SG
echo "Downloading en-SG files"
LOCALE_FOLDER_NAME="en-SG.lproj"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_EN_SG/download?file_format=strings&$COMMON_PARAM_EN" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.strings"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_EN_SG/download?file_format=stringsdict&$COMMON_PARAM_EN" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.stringsdict"

# zh-TW
echo "Downloading zh-TW files"
LOCALE_FOLDER_NAME="zh-Hant.lproj"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_ZH_TW/download?file_format=strings&$COMMON_PARAM_ZH" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.strings"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_ZH_TW/download?file_format=stringsdict&$COMMON_PARAM_ZH" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.stringsdict"


echo "The localization files have been updated. Please check the changes and build the project."
