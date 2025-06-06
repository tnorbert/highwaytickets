//
//  LogSymbols.swift
//  Log
//
//  Created by Norbert Tomo on 2021. 01. 22..
//

import Foundation

enum LogSymbols: RawRepresentable {
    /// ⬜ 
    case boxWhite
    
    /// 🟦
    case boxBlue
    
    /// 🟥
    case boxRed
    
    /// 🟧
    case boxOrange
    
    public typealias RawValue = String
    
    public init?(rawValue: String) {
        if rawValue == "⬜" {
            self = .boxWhite
        } else if rawValue == "🟦" {
            self = .boxBlue
        } else if rawValue == "🟥" {
            self = .boxRed
        } else if rawValue == "🟧" {
            self = .boxOrange
        } else {
            return nil
        }
    }
    
    public var rawValue: String {
        switch  self {
        case .boxWhite:
            return "⬜"
        case .boxBlue:
            return "🟦"
        case .boxRed:
            return "🟥"
        case .boxOrange:
            return "🟧"
        }
    }
}
