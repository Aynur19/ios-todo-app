//
//  SceneDelegate.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        let networkClient = NetworkClientImp(urlSession: URLSession.shared)
        let networkService = NetworkServiceImp(with: networkClient)
        
        let todoListViewModel = TodoListViewModel(with: FileCache(), networkService: networkService)
        let startController = TodoListViewController()
        startController.viewModel = todoListViewModel
        
        let todoListNavigationController = UINavigationController(rootViewController: startController)
//        let startController = ViewController()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = todoListNavigationController
        window?.makeKeyAndVisible()
    }
}

