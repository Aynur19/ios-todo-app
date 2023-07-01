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
        var task: TodoItem?
        do {
            try fileCache.load(name: "Tasks", from: nil, as: .json)

            task = fileCache.tasks.first
        } catch {
            print(error)
        }
        
        print("loaded task: \(task)")
        todoItemController.viewModel = TodoItemViewModel(task, with: fileCache)
        present(todoItemNavigationController, animated: true, completion: nil)
    }
}

