//
//  SuccessfulPurchaseScreen.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import SwiftUI

//MARK: - Routing

protocol SuccessfulPurchaseScreenRouting: AnyObject {
    func onSuccessfulPurchaseScreenRoutingAction(action: SuccessfulPurchaseScreenRoutingAction)
}

enum SuccessfulPurchaseScreenRoutingAction {
    case close
}

//MARK: - Parameters

struct SuccessfulPurchaseScreenParameters {
    
}

//MARK: - View

struct SuccessfulPurchaseScreen: View {
    
    let parameters: SuccessfulPurchaseScreenParameters
    let routing: SuccessfulPurchaseScreenRouting
        
    @State var confettiYOffset: Double = -300
    @State var confettiOpacity: Double = 1
    @State var textOpacity: Double = 0
    @State var circleOpacity: Double = 0
    @State var imageOpacity: Double = 0
    @State var imageOffsetX: Double = 30
    @State var okButtonOpacity: Double = 30

    var body: some View {
        ZStack {
            Color.neon700.ignoresSafeArea()
            
            VStack {
                Image("confetti")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(1.0, contentMode: .fit)
                    .offset(y: confettiYOffset)
                    .opacity(confettiOpacity)
                Spacer()
            }
            
            VStack {
                Spacer()
                Text("successfulPurchaseScreen.label.successfulPurchase")
                    .font(Font.Montserrat.variable(size: .h1, weight: .bold))
                    .foregroundStyle(.darkBlue700)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.5)
                    .opacity(textOpacity)
                
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
                
                CustomButton(style: .full, title: "successfulPurchaseScreen.button.next", isFullWidth: true) {
                    animateOut()
                }
                .opacity(okButtonOpacity)
                
                Spacer()
                    .frame(height: 50)
            }
            .padding([.leading, .trailing], 20)
        }
        .onAppear() {
            animateIn()
        }
    }
    
    private func animateIn() {
        withAnimation(.easeOut(duration: 0.8)) {
            circleOpacity = 1
            okButtonOpacity = 1
        }
        
        withAnimation(.easeOut(duration: 1.6)) {
            confettiYOffset = 0
        }
        
        withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
            imageOpacity = 1
            imageOffsetX = 0
            textOpacity = 1
        }
    }
    
    private func animateOut() {
        withAnimation(.easeOut(duration: 0.6)) {
            circleOpacity = 0
            imageOpacity = 0
            textOpacity = 0
            okButtonOpacity = 0
            confettiOpacity = 0
        } completion: {
            Task {
                routing.onSuccessfulPurchaseScreenRoutingAction(action: .close)
            }
        }
    }
    
}

#Preview {
    SuccessfulPurchaseScreen(parameters: .init(), routing: PreviewRouter())
}
