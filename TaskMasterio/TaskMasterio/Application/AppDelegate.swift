//
//  AppDelegate.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var dataManager: DataManager?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(setupDataManager), name: NSNotification.Name("DataManagerSetup"), object: nil)
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        _ = dataManager?.save()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        _ = dataManager?.save()
    }
    
    @objc func setupDataManager() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            self.dataManager = sceneDelegate.dataManager
        }
    }
}
