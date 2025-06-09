//
//  CustomCheckBox.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import SwiftUI

struct CustomCheckBox: View {
        
    @EnvironmentObject var haptics: HapticManager

    @Binding var isOn: Bool
    
    @GestureState private var isPressed = false
    
    var body: some View {
        return HStack(spacing: 0) {
         
            Image(systemName: "checkmark")
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(.darkBlue700)
                .scaledToFit()
                .padding(10)
                .opacity(isOn ? 1.0 : 0.0)
        }
        .frame(width: 32, height: 32)
        
        .background(backgroundView)
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(borderColor, lineWidth: 1)
        )
        .contentShape(Rectangle()) // Makes the entire area tappable
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .updating($isPressed) { _, state, _ in
                    state = true
                }
                .onEnded { _ in
                    haptics.buttonPressed()
                    isOn.toggle()
                }
        )
        .animation(.easeInOut(duration: 0.15), value: isPressed)
    }

    private var backgroundView: some View {
        if isOn {
            isPressed ? Color.darkBlue700 : Color.white
        } else {
            isPressed ? Color.darkBlue700.opacity(0.6) : Color.white
        }
    }

    private var foregroundColor: Color {
        isOn ? .white : (isPressed ? Color.black.opacity(0.6) : .black)
    }

    private var borderColor: Color {
        isOn ? .lightBlue700 : (isPressed ? Color.black.opacity(0.6) : .lightBlue700)
    }
    
    private var fontStyle: Font {
        Font.Montserrat.variable(size: .medium, weight: .bold)
    }
    
}
