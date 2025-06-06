//
//  ApplicationConfiguration.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import UIKit
import Alamofire

enum ApplicationEnvironment: String {
    case development
    case stage
    case production
}

class ApplicationConfiguration {
    
    //MARK: - Properties
    
    static let shared: ApplicationConfiguration = ApplicationConfiguration()
    
    let isDebugBuild: Bool
    let environment: ApplicationEnvironment
    let apiBaseUrl: URL
    let appStoreURL: URL
    let deviceInfo: String
    let formattedAppVersion: String
    let version: String
    let build: String
    let bundleId: String
    let model: String
    let operatingSystem: String
    let sharedKeychain: String
    let userDefaultsGroup: String
        
    //MARK: - Life cycle methods
    
    private init() {
        #if DEBUG
        isDebugBuild = true
        #else
        isDebugBuild = false
        #endif
        
        operatingSystem = "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)"
        model = UIDevice.current.localizedModel
        bundleId = Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String
        version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        sharedKeychain = "\(bundleId).sharedKeychain"
        userDefaultsGroup = "group.\(bundleId)"
        
        var appVersionString = "\(version) (\(build))"

        #if DEVELOPMENT
        environment = .development
        appStoreURL = URL(string: "https://www.google.hu")!
        apiBaseUrl = URL(string: "http://192.168.1.1:8080")!
        appVersionString += " DEV"
        #elseif STAGE
        environment = .stage
        appStoreURL = URL(string: "")!
        apiBaseUrl = URL(string: "")!
        appVersionString += " STAGE"
        #elseif PRODUCTION
        environment = .production
        appStoreURL = URL(string: "")!
        apiBaseUrl = URL(string: "")!
        appVersionString += ""
        #endif
        
        formattedAppVersion = appVersionString

        deviceInfo = "Device: '\(UIDevice.current.localizedModel)', Operating system: '\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)'', App version: '\(formattedAppVersion)'";
    }
    
}
