//
//  HapticManager.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import UIKit

class HapticManager: ObservableObject {
    
    static let shared = HapticManager()
    
    private let lightGenerator = UIImpactFeedbackGenerator(style: .light)
    private let mediumGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    func impact() {
        mediumGenerator.prepare()
        mediumGenerator.impactOccurred()
    }
    
    func buttonPressed() {
        lightGenerator.prepare()
        lightGenerator.impactOccurred()
    }
    
}
