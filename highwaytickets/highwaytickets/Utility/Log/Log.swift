//
//  Log.swift
//
//  Created by Norbert Tömő
//

import Foundation
import OSLog

/**
 Logger service
 */
public class Log {
    
    //MARK: - Properties -
    
    fileprivate static let shared: Log = Log()
    
    fileprivate var _config: LogConfig = .init(shouldPrintDebugLevelToConsole: true, shouldPrintGeneralLevelToConsole: true, shouldPrintInfoLevelToConsole: true, shouldPrintErrorLevelToConsole: true, timeFormat: .long)
        
    final private let _longDateFormatter = DateFormatter()
    final private let _shortDateFormatter = DateFormatter()

    final private var _delegates = [() -> LogDelegate?]()
        
    public static var config: LogConfig = .init(shouldPrintDebugLevelToConsole: true, shouldPrintGeneralLevelToConsole: true, shouldPrintInfoLevelToConsole: true, shouldPrintErrorLevelToConsole: true, timeFormat: .long) {
        didSet {
            shared._config = config
        }
    }
    
    private let _logger: Logger
    
    //MARK: - Life cycle methods -
    
    private init() {
        _longDateFormatter.dateFormat = "YYYY.MM.dd HH:mm:ss"
        _shortDateFormatter.dateFormat = "HH:mm:ss"
        
        _logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "")
    }
    
    //MARK: - Public methods

    /**
        Prints a formatted string with the 'print()' function. Formatting is based on Log.config values which can be set at any time, preferably in AppDelegate's didFinishLaunching
     
        It also sends the raw 'LogItem' object via the delegates even if loglevel is not set to .all so you can decide if you want to do anything with the log item.
     
        - Parameter title: Custom title, usually, the class name goes here
        - Parameter text: The actual text you want to print out
        - Parameter type: it can be set to .general .important .debug .error each has its own unique color associated with the type.
        - Parameter customIcon: If you wish, you can use any string or unicode to represent any special message. For example, you can assign a "💾" to every database log so it is even more distinguishable in the log flow
     */
    public static func log(WithCategory category: String, Message message: String, Type type: LogType, CustomIcon customIcon: String? = nil) -> Void {
        let item = LogItem(WithDate: Date(), Category: category, Message: message, Type: type, CustomIcon: customIcon ?? "")
        
        let formattedLogText = shared.formattedLogText(ForItem: item, TimeFormat: shared._config.timeFormat)
        let formattedUnifiedLogText = shared.formattedLogText(ForItem: item, TimeFormat: .none)

        shared._delegates.forEach {
            $0()?.didLog(Item: item, FormattedText: formattedLogText)
        }
        
        if shared.shouldPrint(ForType: type) {
            switch type {
            case .debug:
                shared._logger.debug("\(formattedUnifiedLogText, privacy: .public)")
            case .general:
                shared._logger.notice("\(formattedUnifiedLogText, privacy: .public)")
            case .info:
                shared._logger.info("\(formattedUnifiedLogText, privacy: .public)")
            case .error:
                shared._logger.error("\(formattedUnifiedLogText, privacy: .public)")
            }
        }
    }
    
    /**
        Creates a formatted String from the logItem. If nil is passed for timeFormat, Log's timeFormat setting is used
     */
    public static func formattedText(FromItem item: LogItem, TimeFormat timeFormat: LogTimeFormat? = nil) -> String {
        return shared.formattedLogText(ForItem: item, TimeFormat: timeFormat ?? shared._config.timeFormat)
    }
    
    /**
        Registers the delegate so it can receive the individual LogItem objects and the formatted string also.
     */
    public static func register(Delegate delegate: LogDelegate) {
        shared._delegates.append({ [weak delegate] in return delegate })
    }
    
    /**
        Unregisters the delegate so it won't receive any LogItem objects or formatted string.
     */
    public static func unregister(Delegate delegate: LogDelegate) {
        shared._delegates.removeAll { delegateToCheck in
            return delegateToCheck() == nil
        }
    }
    
    //MARK: - Private methods
    
    private func formattedLogText(ForItem item: LogItem, TimeFormat timeFormat: LogTimeFormat) -> String {
        let category = item.category
        let textToPrint = item.message
        let type = item.type
        let customIcon = item.customIcon
                        
        var dateText: String
                
        if timeFormat == .long {
            dateText = "\(_longDateFormatter.string(from: item.date))"
        } else if timeFormat == .short {
            dateText = "\(_shortDateFormatter.string(from: item.date))"
        } else {
            dateText = ""
        }
        
        var textToReturn = ""
        
        textToReturn += "\(icon(ForType: type))"
        
        if customIcon != "" {
            textToReturn += " \(customIcon)"
        }
        
        if dateText != "" {
            textToReturn += " \(dateText)"
        }
        
        
        if dateText != "" || customIcon != "" {
            textToReturn += " :"
        }
        
        textToReturn += " \(category) - \(textToPrint)"
               
        return textToReturn
    }
    
    private func icon(ForType type: LogType) -> String {
        switch type {
        case .general:
            return LogSymbols.boxWhite.rawValue
        case .error:
            return LogSymbols.boxRed.rawValue
        case .info:
            return LogSymbols.boxBlue.rawValue
        case .debug:
            return LogSymbols.boxOrange.rawValue
        }
    }
    
    private func shouldPrint(ForType type: LogType) -> Bool {
        switch type {
        case .debug:
            return _config.shouldPrintDebugLevelToConsole
        case .general:
            return _config.shouldPrintGeneralLevelToConsole
        case .info:
            return _config.shouldPrintInfoLevelToConsole
        case .error:
            return _config.shouldPrintErrorLevelToConsole
        }
    }
    
}
