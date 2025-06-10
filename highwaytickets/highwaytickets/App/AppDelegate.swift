//
//  AppDelegate.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import UIKit
import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                
        Log.log(WithCategory: "AppDelegate", Message: "didFinishLaunchingWithOptions: '\(String.init(describing: launchOptions))'", Type: .info)
        
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        if let shortcutItem = options.shortcutItem, shortcutItem.type == "debugMenu" {
            //AppState.shared.appPhase = .devinchi
        }
        
        let sceneConfiguration = UISceneConfiguration(name: "Custom Configuration", sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = SceneDelegate.self
             
        return sceneConfiguration
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return [.portrait]
    }
    
}

//MARK: - NetworkEventMonitorDelegate

extension AppDelegate: AlamofireNetworkEventMonitorDelegate {
    
    func didFinishServingRequest(WithRequest request: URLRequest?, Response response: HTTPURLResponse?, ServerData serverData: Data?, SerializedResponse serializedResponse: String) {
        
        //Normally, my custom debug menu solution can show network calls but at the moment, I did not include this dev menu in this test exercise
        
        //DevInchi.shared.registerNetworkEvent(WithEvent: .init(date: Date(), request: request, response: response, serverData: serverData, serializedResponse: serializedResponse))
    }
    
}
