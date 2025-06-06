//
//  String+Localized.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation

extension String {
    
    func localized(ForLanguage language: String? = nil, _ arguments: CVarArg...) -> String {
        let localizedString: String
        
        if let language = language {
            if let path = Bundle.main.path(forResource: language.lowercased(), ofType: "lproj") {
                localizedString = Bundle(path: path)!.localizedString(forKey: self, value: "", table: nil)
            } else {
                Log.log(WithCategory: "Localization", Message: "Localized string is not found for key: \(self) in language code: \(language)", Type: .error)
                
                localizedString = NSLocalizedString(self, comment: "")
            }
        } else {
            localizedString = NSLocalizedString(self, comment: "")
        }
                
        if arguments.count > 0 {
            return String(format: localizedString, arguments: arguments)
        } else {
            return localizedString
        }
    }
    
}
