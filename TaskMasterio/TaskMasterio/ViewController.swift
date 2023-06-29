//
//  ViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.06.2023.
//

import UIKit

class ViewController: UIViewController {
    private var fileCache: FileCache!
    private var task: TodoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fileCache = FileCache()
        view.backgroundColor = .systemBackground
        addTestButton()
    }

    private func addTestButton() {
        
        
        let button = UIButton(type: .system)
        button.setTitle("Show Task View", for: .normal)
        button.addTarget(self, action: #selector(testButtonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.widthAnchor.constraint(equalToConstant: 300),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func testButtonTapped() {
        let todoItemController = TodoItemViewController2()
        let todoItemNavigationController = UINavigationController(rootViewController: todoItemController)
        
        do {
            try fileCache.load(name: "Test data", from: nil, as: .json)

            todoItemController.viewModel = TodoItemViewModel(currentTask: fileCache.tasks.first ?? TodoItem(text: "Task #1", priority: .low))
        } catch {
            todoItemController.viewModel = TodoItemViewModel(currentTask: TodoItem(text: "Task #1", priority: .low))
            print(error)
        }

        present(todoItemNavigationController, animated: true, completion: nil)
    }
}

