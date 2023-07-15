//
//  SceneDelegate.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var dataManager: DataManager?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        dataManager = DataManager(unitOfWork: SqliteUnitOfWork(todoListContext: TodoListContext.shared,
                                                               todoItemContext: TodoItemContext.shared))
        let networkClient = NetworkClientImp(urlSession: URLSession.shared)
        let networkService = NetworkServiceImp(with: networkClient)
        
        let todoListViewModel = TodoListViewModel(with: dataManager, networkService: networkService)
        let startController = TodoListViewController()
        startController.viewModel = todoListViewModel
        let todoListNavigationController = UINavigationController(rootViewController: startController)
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = todoListNavigationController
        window?.makeKeyAndVisible()
        
        NotificationCenter.default.post(name: NSNotification.Name("DataManagerSetup"), object: nil)
    }
}
