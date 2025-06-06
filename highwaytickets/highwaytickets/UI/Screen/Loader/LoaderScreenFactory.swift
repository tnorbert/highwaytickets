//
//  LoaderScreenFactory.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import SwiftUI

class LoaderScreenFactory {
    
    @ViewBuilder
    static func createView(parameters: LoaderScreenParameters, router: LoaderScreenRouting) -> some View {
        LoaderScreen(parameters: parameters,
                     routing: router,
                     getAppStoreVersionUseCase: GetAppstoreVersionUseCase(),
                     getVersionUseCase: GetVersionUseCase(remoteProvider: ProviderFactory.networkServiceProvider()))
    }
    
}
