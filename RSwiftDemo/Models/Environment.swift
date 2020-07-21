//
//  Environment.swift
//  RSwiftDemo
//
//  Created by Jackson Chung on 16/12/2019.
//  Copyright © 2019 Jackson Chung. All rights reserved.
//

import Foundation

//
//  Environment.swift
//  GoGoVanClientV2
//
//  Created by Jackson Chung on 6/11/2018.
//  Copyright © 2018 GoGo Tech Limited. All rights reserved.
//

import UIKit

import Foundation

enum PlistKey: String {
    case phraseAppEnvToken = "PhraseApp Environment Token"
    case phraseAppDistributionId = "PhraseApp Distribution ID"
}

struct Environment {
    fileprivate static func infoDict(keyName: String) -> Any? {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict[keyName]
    }

    static func configuration(keyName: PlistKey) -> String {
        return infoDict(keyName: keyName.rawValue) as? String ?? ""
    }
}
