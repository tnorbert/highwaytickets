//
//  SceneDelegate.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
   
  func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
      handleShortcutItem(shortcutItem)
  }
   
  private func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem) { }
    
}
