//
//  TodoItemViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 22.06.2023.
//

import UIKit

final class TodoItemViewController: UIViewController {
    
    let taskTitle = "Дело"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
        
        prepareNavigationBar()
    }
    
    private func prepareNavigationBar() {
        if let navigationController = self.navigationController {
            title = taskTitle
            navigationController.navigationBar.barStyle = .default
            
            
        }
    }
}
