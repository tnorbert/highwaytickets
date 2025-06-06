//
//  LogType.swift
//  
//
//  Created by Norbert Tomo on 2020. 12. 14..
//

import Foundation

public enum LogType: Int, Codable {
    
    /// 🟧 Use this level to capture information that may be useful during development or while troubleshooting a specific problem.
    case debug = 0
    
    /// ⬜ Use this level to capture information about anything which might be useful
    case general = 1
    
    /// 🟦 Use this level to capture information that may be helpful for troubleshooting errors.
    case info = 2
    
    /// 🟥 Use this log level to report process-level errors.
    case error = 3
    
}
