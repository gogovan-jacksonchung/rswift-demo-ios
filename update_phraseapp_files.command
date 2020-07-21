#!/bin/sh

# set current directory to the script folder
cd "$(dirname "$0")"

ACCESS_TOKEN="6446acc6ed3729d20aa1866cd39a3e99036dd31f80c18687938a88fb71f732a1"

# PhraseApp project properties
CA_PROJECT_ID="ef800a979412415e85e6010a507d7ce1"

LOCALE_ID_EN_HK="858f575b32673905051e056f8316fac2"
LOCALE_ID_ZH_HK="fbf1284aaeb6a0da920b94a44f7ba708"
LOCALE_ID_ZH_HANS="d69e1f8a06147ec88a77b867668a7547"
LOCALE_ID_ZH_TW="8351a6a0c4f749e0395936c1433a148c"
LOCALE_ID_EN_SG="4102ad626eee43a19d6107a5009f6793"
LOCALE_ID_VI_VN="0d7aa6ada7d17da8de3bc5f6aac96382"

LOCALE_ID_EN_BASE="f19b545c8967b66ec230241a8523329a"
LOCALE_ID_ZH_BASE="ce8d46f175049e575d979c849ff55372"

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


# zh-Hans
echo "Downloading zh-Hans files"
LOCALE_FOLDER_NAME="zh-Hans.lproj"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_ZH_HANS/download?file_format=strings&$COMMON_PARAM_ZH" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.strings"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_ZH_HANS/download?file_format=stringsdict&$COMMON_PARAM_ZH" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.stringsdict"

# zh-TW
echo "Downloading zh-TW files"
LOCALE_FOLDER_NAME="zh-Hant.lproj"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_ZH_TW/download?file_format=strings&$COMMON_PARAM_ZH" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.strings"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_ZH_TW/download?file_format=stringsdict&$COMMON_PARAM_ZH" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.stringsdict"

# en-SG
echo "Downloading en-SG files"
LOCALE_FOLDER_NAME="en-SG.lproj"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_EN_SG/download?file_format=strings&$COMMON_PARAM_EN" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.strings"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_EN_SG/download?file_format=stringsdict&$COMMON_PARAM_EN" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.stringsdict"

# vi-VN
echo "Downloading vi-VN files"
LOCALE_FOLDER_NAME="vi-VN.lproj"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_VI_VN/download?file_format=strings&$COMMON_PARAM_EN" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.strings"
curl -u $ACCESS_TOKEN: "$PHRASEAPP_API/$CA_PROJECT_ID/locales/$LOCALE_ID_VI_VN/download?file_format=stringsdict&$COMMON_PARAM_EN" > "$RESOURCE_FOLDER_PATH/$LOCALE_FOLDER_NAME/Localizable.stringsdict"

echo "The localization files have been updated. Please check the changes and build the project."
