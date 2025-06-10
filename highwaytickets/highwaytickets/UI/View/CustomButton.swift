//
//  CustomButton.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import SwiftUI

enum CustomButtonStyle {
    case full
    case hollow
    case iconOnly
}

enum CustomButtonIconType {
    case system(String)
    case custom(String)
}

struct CustomButton: View {
    
    @EnvironmentObject var haptics: HapticManager

    var style: CustomButtonStyle
    var title: LocalizedStringKey = ""
    var iconType: CustomButtonIconType? = nil
    var isFullWidth: Bool = false
    var action: () -> Void

    @GestureState private var isPressed = false
    
    var body: some View {
        return HStack(spacing: 6) {
            
            if isFullWidth {
                Spacer()
            }
            
            if let iconType {
                switch iconType {
                case .system(let systemName):
                    Image(systemName: systemName)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .opacity(isPressed ? 0.6 : 1.0)
                case .custom(let iconName):
                    Image(iconName)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .opacity(isPressed ? 0.6 : 1.0)
                }
            }

            if style != .iconOnly {
                Text(title)
                    .foregroundStyle(textColor)
                    .font(fontStyle)
            }
            
            if isFullWidth {
                Spacer()
            }
        }
        .frame(height: 48)
        .padding(.horizontal)
        .background(backgroundView)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(borderColor, lineWidth: style == .hollow || style == .iconOnly ? 2 : 0)
        )
        .contentShape(Rectangle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .updating($isPressed) { _, state, _ in
                    state = true
                }
                .onEnded { _ in
                    haptics.buttonPressed()
                    action()
                }
        )
        .animation(.easeInOut(duration: 0.15), value: isPressed)
    }

    private var backgroundView: some View {
        switch style {
        case .full:
            isPressed ? Color.darkBlue700.opacity(0.6) : Color.darkBlue700
        case .hollow, .iconOnly:
            isPressed ? Color.darkBlue700.opacity(0.6) : Color.clear
        }
    }

    private var borderColor: Color {
        switch style {
        case .hollow, .iconOnly:
            return isPressed ? Color.black.opacity(0.6) : .black
        default:
            return .clear
        }
    }
    
    private var fontStyle: Font {
        switch style {
        case .full:
            return Font.Montserrat.variable(size: .medium, weight: .bold)
        case .hollow:
            return Font.Montserrat.variable(size: .medium, weight: .bold)
        case .iconOnly:
            return Font.body
        }
    }
    
    private var textColor: Color {
        switch style {
        case .full:
            return .white
        case .hollow, .iconOnly:
            return isPressed ? .darkBlue700.opacity(0.6) : .darkBlue700
        }
    }
    
}
