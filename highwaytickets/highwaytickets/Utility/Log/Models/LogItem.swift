//
//  LogItem.swift
//  
//
//  Created by Norbert Tomo on 2020. 12. 16..
//

import Foundation

public class LogItem: Codable {
    
    public let date: Date
    public let category: String
    public let message: String
    public let type: LogType
    public let customIcon: String
    
    public init(WithDate date: Date, Category category: String, Message message: String, Type type: LogType, CustomIcon customIcon: String) {
        self.date = date
        self.category = category
        self.message = message
        self.type = type
        self.customIcon = customIcon
    }
    
    public var encodedJSONData: Data {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(self)
        
        return data
    }
    
}
