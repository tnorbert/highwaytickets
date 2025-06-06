//
//  LoderScreen.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import SwiftUI

//MARK: - Routing

protocol LoaderScreenRouting: AnyObject {
    func onLoaderScreenRoutingAction(action: LoaderScreenRoutingAction)
}

enum LoaderScreenRoutingAction {
    case authentication
    case content
}

//MARK: - Parameters

struct LoaderScreenParameters { }

//MARK: - View

struct LoaderScreen: View {
    
    let parameters: LoaderScreenParameters
    let routing: LoaderScreenRouting
    let getAppStoreVersionUseCase: GetAppstoreVersionUseCaseProtocol
    let getVersionUseCase: GetVersionUseCaseProtocol

    @State var circleOpacity: Double = 0
    @State var imageOpacity: Double = 0
    @State var imageOffsetX: Double = 30
    
    @State var isLoadingVersion: Bool = false
    
    //Alerts
    @State private var showNewVersionAlert = false
    @State private var showNewCriticalVersionAlert = false

    var body: some View {
        ZStack {
            Color.neon700.ignoresSafeArea()
                
                ZStack {
                    Circle()
                        .fill(
                            .white
                        )
                        .padding([.leading, .trailing],18)
                        .padding([.top],40)
                        .opacity(circleOpacity)

                    Image("runningMan")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(1.0, contentMode: .fit)
                        .opacity(imageOpacity)
                        .offset(x: imageOffsetX, y: 0)
                }
                .aspectRatio(1.0, contentMode: .fit)
                .clipShape(Circle())
                .padding(40)
            
            if isLoadingVersion {
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.darkBlue700)
                        .scaleEffect(2)
                    Spacer()
                }
            }
        }
        .onAppear() {
            animateIn()
        }
    }
    
    private func checkVersion() async {
        isLoadingVersion = true
        
        //Check currently avaiable appstore version
        var appstoreVersion: String = "0.0.0"

        let appstoreVersionResult = await getAppStoreVersionUseCase.execute()
        
        switch appstoreVersionResult {
        case .success(let version):
            Log.log(WithCategory: "LoaderScreen", Message: "Current appstore version: '\(version)'", Type: .debug)
            
            appstoreVersion = version
        case .failure(let failure):
            Log.log(WithCategory: "LoaderScreen", Message: "Error while trying to get current app version from itunes. Error: \(failure.localizedDescription)", Type: .error)
        }
        
        //Get version informations from our server
        let versionResult = await getVersionUseCase.execute()
        
        switch versionResult {
        case .success((let isNewer, let isCritical)):
            isLoadingVersion = false
            
            if isCritical && (appstoreVersion != "0.0.0" ? (appstoreVersion > ApplicationConfiguration.shared.formattedAppVersion) : true) {
                Log.log(WithCategory: "LoaderViewModel", Message: "There is a new critical update!", Type: .debug)
                
                showNewCriticalVersionAlert = true
            } else if isNewer && (appstoreVersion != "0.0.0" ? (appstoreVersion > ApplicationConfiguration.shared.formattedAppVersion) : true) {
                Log.log(WithCategory: "LoaderViewModel", Message: "There is a newer yet not critical update!", Type: .debug)
                
                showNewVersionAlert = true
            } else {
                Log.log(WithCategory: "LoaderViewModel", Message: "There is no new update!", Type: .debug)
                
                animateOut()
            }
        case .failure(let failure):
            Log.log(WithCategory: "LoaderViewModel", Message: "Error while trying to get version: \(failure.localizedDescription)", Type: .error)
            
            isLoadingVersion = false
            
            animateOut()
        }
    }
    
    private func checkUser() {
        //Usually, at this point, the user login status is checked and the routing is based on this status
        
        //Content
        routing.onLoaderScreenRoutingAction(action: .content)
    }
    
    private func animateIn() {
        withAnimation(.easeOut(duration: 0.8)) {
            circleOpacity = 1
        }
        
        withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
            imageOpacity = 1
            imageOffsetX = 0
        } completion: {
            Task {
               await checkVersion()
            }
        }
    }
    
    private func animateOut() {
        withAnimation(.easeOut(duration: 0.8)) {
            imageOpacity = 0
            imageOffsetX = 30
        }
        
        withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
            circleOpacity = 0
        } completion: {
            checkUser()
        }
    }
    
}
