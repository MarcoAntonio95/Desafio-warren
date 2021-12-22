//
//  SceneDelegate.swift
//  App
//
//  Created by Txai Wieser on 20/02/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import UIKit
import SwiftUI
import App

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
       var window: UIWindow?
       var coordinator: AppCoordinator?
       let navigation = UINavigationController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
          guard let windowScene = scene as? UIWindowScene else { return }
          let navigationController = UINavigationController()
          coordinator = AppCoordinator.init(navigationController)
          coordinator?.start()
          window = UIWindow(frame: .zero)
          window?.makeKeyAndVisible()
          window?.rootViewController = navigationController
          window?.windowScene = windowScene
    }
}

