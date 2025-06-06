//
//  LogConfig.swift
//  
//
//  Created by Norbert Tomo on 2020. 12. 14..
//

import Foundation

public struct LogConfig {
    
    public var shouldPrintDebugLevelToConsole: Bool {
        didSet {
            Log.log(WithCategory: "Log", Message: "shouldPrintDebugLevel set to:\(shouldPrintDebugLevelToConsole)", Type: .info)
        }
    }
    
    public var shouldPrintGeneralLevelToConsole: Bool {
        didSet {
            Log.log(WithCategory: "Log", Message: "shouldPrintGeneralLevel set to:\(shouldPrintGeneralLevelToConsole)", Type: .info)
        }
    }
    
    public var shouldPrintInfoLevelToConsole: Bool {
        didSet {
            Log.log(WithCategory: "Log", Message: "shouldPrintInfoLevel set to:\(shouldPrintInfoLevelToConsole)", Type: .info)
        }
    }
    
    public var shouldPrintErrorLevelToConsole: Bool {
        didSet {
            Log.log(WithCategory: "Log", Message: "shouldPrintErrorLevel set to:\(shouldPrintErrorLevelToConsole)", Type: .info)
        }
    }
    
    public var timeFormat: LogTimeFormat {
        didSet {
            Log.log(WithCategory: "Log", Message: "Log time format set to:\(timeFormat)", Type: .info)
        }
    }
    
}
