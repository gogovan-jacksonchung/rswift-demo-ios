//
//  LocalizationManager.swift
//  RSwiftDemo
//
//  Created by Jackson Chung on 21/7/2020.
//  Copyright © 2020 Jackson Chung. All rights reserved.
//

import Foundation
import PhraseSDK

class LocalizationManager {

    /**
        For global access the AppLocale
     */
    public static var appLocale: AppLocale = .english

    class func initialize() {
        Bundle.swizzleLocalizedStringImplementation
    }
}

/**
 Swizzle to use specific AppLocale localizable.string
 */
private extension Bundle {
    static let swizzleLocalizedStringImplementation: Void = {
        let instance: Bundle = Bundle.main
        let aClass: AnyClass! = object_getClass(instance)
        let originalMethod = class_getInstanceMethod(aClass, #selector(Bundle.localizedString(forKey:value:table:)))
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(Bundle.swizzleLocalizedString(forKey:value:table:)))
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()

    @objc
    func swizzleLocalizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        // 1. get the default string from embedded resource for fallback
        guard
            let basePath = Bundle.main.path(forResource: "en", ofType: "lproj"),
            let baseBundle = Bundle(path: basePath)
            else {
                return swizzleLocalizedString(forKey: key, value: value, table: tableName)
        }
        let fallback = baseBundle.swizzleLocalizedString(forKey: key, value: key, table: tableName)
        let appLocaleString = LocalizationManager.appLocale.rawValue

        // 2. get the string from OTA folder, if exists
        let distributionId = Environment.configuration(keyName: .phraseAppDistributionId)
        let phraseAppVersionKey = "PhraseSDK_\(distributionId)_Locale_Version_\(appLocaleString)"
        if let applicationSupportFolder = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first,
            let phraseAppVersion = UserDefaults.standard.string(forKey: phraseAppVersionKey),
            let otaBundle = Bundle(path: "\(applicationSupportFolder.path)/PhraseSDK/Translations/\(phraseAppVersion)/\(appLocaleString).lproj")
        {
            // OTA folder exists
            return otaBundle.swizzleLocalizedString(forKey: key, value: fallback, table: tableName)
        }

        // 3. get the localized string from embedded resource
        guard
            let localizedPath = Bundle.main.path(forResource: appLocaleString, ofType: "lproj"),
            let localizedBundle = Bundle(path: localizedPath)
            else {
                return fallback
        }

        return localizedBundle.swizzleLocalizedString(forKey: key, value: fallback, table: tableName)
    }
}
