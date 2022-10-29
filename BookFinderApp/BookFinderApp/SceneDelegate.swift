//
//  SceneDelegate.swift
//  BookFinderApp
//
//  Created by 김윤석 on 2022/10/28.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: MainViewController(viewModel: MainViewModel()))
        window?.makeKeyAndVisible()
    }
}

