//
//  Font+Montserrat.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import SwiftUI
import Foundation
import UIKit

enum TextFontSize {
    ///32
    case h1
    ///26
    case h2
    ///20
    case h3
    ///16
    case large
    ///14
    case medium
    ///12
    case small
    ///11
    case extraSmall
    
    ///Provided by constructor
    case custom(CGFloat)
    
    var value: CGFloat {
        switch self {
        case .h1: return 32
        case .h2: return 26
        case .h3: return 20
        case .large: return 16
        case .medium: return 14
        case .small: return 12
        case .extraSmall: return 11
        case .custom(let size): return size
        }
    }
}

extension Font {
    
    enum Montserrat {
        static func variable(size: TextFontSize, weight: Font.Weight = .regular) -> Font {
            .custom("Montserrat", size: size.value, relativeTo: .body).weight(weight)
        }
        
        static func uiFont(size: TextFontSize, weight: Font.Weight = .regular) -> UIFont {
            if weight == .semibold || weight == .bold || weight == .black {
                if let boldDescriptor = UIFont.init(name: "Montserrat", size: size.value)!.fontDescriptor.withSymbolicTraits(.traitBold) {
                    return UIFont(descriptor: boldDescriptor, size: size.value)
                } else {
                    return .init(name: "Montserrat", size: size.value)!
                }
            } else {
                return .init(name: "Montserrat", size: size.value)!
            }
        }
        
    }
    
}
