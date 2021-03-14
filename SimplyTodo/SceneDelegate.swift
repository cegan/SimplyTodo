//
//  SceneDelegate.swift
//  SimplyToDo
//
//  Created by Casey Egan on 3/13/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
          
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UINavigationController(rootViewController: TodoTableViewController())
            window.makeKeyAndVisible()
            self.window = window
    }
}

