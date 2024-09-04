//
//  SceneDelegate.swift
//  VIPTest
//
//  Created by Zuka Papuashvili on 03.09.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        let vc = MainConfigurator.configure()
        let navigationController = UINavigationController(rootViewController: vc)
        
        window.rootViewController = navigationController
        
        window.makeKeyAndVisible()
    }

}

