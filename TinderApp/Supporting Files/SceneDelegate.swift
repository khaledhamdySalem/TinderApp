//
//  SceneDelegate.swift
//  TinderApp
//
//  Created by KH on 18/02/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: sceneWindow)
        
        window.makeKeyAndVisible()
        window.rootViewController = RegistrationViewController()
        self.window = window
        
    }
    
}
