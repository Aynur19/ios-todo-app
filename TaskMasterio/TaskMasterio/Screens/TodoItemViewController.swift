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
            
            let cancelButton = UIBarButtonItem(title: Titles.cancelButton, style: .plain, target: self,
                                             action: #selector(cancelButtonTapped))
            
            let saveButton = UIBarButtonItem(title: Titles.saveButton, style: .plain, target: self,
                                              action: #selector(saveButtonTapped))
            
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    @objc func cancelButtonTapped() { }
    
    @objc func saveButtonTapped() { }
}

