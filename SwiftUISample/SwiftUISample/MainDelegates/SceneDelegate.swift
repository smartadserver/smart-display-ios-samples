//
//  SceneDelegate.swift
//  SwiftUISample
//
//  Created by Loïc GIRON DIT METAZ on 02/08/2019.
//  Copyright © 2019 Smart AdServer. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: MainContentView())
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
}

