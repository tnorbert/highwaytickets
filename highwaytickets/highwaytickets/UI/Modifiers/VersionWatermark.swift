//
//  VersionWatermark.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import SwiftUI

struct VersionWatermark: ViewModifier {
    
    var onVersionTapped: () -> Void
    
    func body(content: Content) -> some View {
        if ApplicationConfiguration.shared.environment == .production {
            ZStack {
                content
            }
        } else {
            ZStack {
                content
                if ApplicationConfiguration.shared.environment != .production {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("\(ApplicationConfiguration.shared.formattedAppVersion)")
                                .font(.footnote)
                                .bold()
                                .foregroundStyle(.black)
                                .padding([.leading], 0)
                                .padding([.top, .bottom], 5)
                                .padding([.trailing], 20)
                                .gesture(TapGesture(count: 2)
                                    .onEnded({
                                    onVersionTapped()
                                }))
                        }
                    }
                }
            }
        }
    }
    
}

extension View {
    
    func versionWatermarked(tapHandler: @escaping () -> Void) -> some View {
        modifier(VersionWatermark(onVersionTapped: tapHandler))
    }
    
}
