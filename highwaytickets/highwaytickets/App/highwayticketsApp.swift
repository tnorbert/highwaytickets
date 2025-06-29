//
//  highwayticketsApp.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import SwiftUI
import SwiftData

@main
struct highwayticketsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @ObservedObject var appState: AppState = AppState.shared
    
    @StateObject var loaderRouter: LoaderRouter = LoaderRouter()
    @StateObject var contentRouter: ContentRouter = ContentRouter()
    @StateObject var successfulPurchaseRouter: SuccessfulPurchaseRouter = SuccessfulPurchaseRouter()

    @State var windowID: String = UUID().uuidString

    var body: some Scene {
        WindowGroup {
            switch appState.appPhase {
            case .loader:
                NavigationStack(path: $loaderRouter.path) {
                    loaderRouter.initialView()
                }
                .versionWatermarked(tapHandler: {
                    //Open in-app debug menu here
                })
                .id(windowID)
            case .content:
                NavigationStack(path: $contentRouter.path) {
                    contentRouter.initialView()
                        .environmentObject(HapticManager.shared)
                }
                .versionWatermarked(tapHandler: {
                    //Open in-app debug menu here
                })
                .id(windowID)
            case .successfulPurchase:
                NavigationStack(path: $successfulPurchaseRouter.path) {
                    successfulPurchaseRouter.initialView()
                        .environmentObject(HapticManager.shared)
                }
                .versionWatermarked(tapHandler: {
                    //Open in-app debug menu here
                })
                .id(windowID)
            }
        }
        .onChange(of: appState.appPhase) { oldPhase, newPhase in
            Log.log(WithCategory: "highwayticketsApp", Message: "App phase did change to: \(newPhase)", Type: .info)
            
            loaderRouter.clearPath()
            contentRouter.clearPath()
            successfulPurchaseRouter.clearPath()
            
            windowID = UUID().uuidString
        }
    }
}
