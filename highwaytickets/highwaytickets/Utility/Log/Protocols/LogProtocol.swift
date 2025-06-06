//
//  LogProtocols.swift
//  
//
//  Created by Norbert Tomo on 2021. 01. 21..
//

import Foundation

public protocol LogDelegate: AnyObject {
    func didLog(Item item: LogItem, FormattedText formattedText: String)
}
