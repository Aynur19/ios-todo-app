//
//  ViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 10.06.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        addTestButton()
    }

    private func addTestButton() {
        let button = UIButton(type: .system)
        button.setTitle("Show Task View", for: .normal)
        button.addTarget(self, action: #selector(testButtonTapped), for: .touchUpInside)
//        button.tintColor = UIColor(named: "Themes") // using AssentsColor
        
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
        let todoItemNavigationController = UINavigationController(rootViewController: TodoItemViewController())

        todoItemNavigationController.modalPresentationStyle = .automatic
        present(todoItemNavigationController, animated: true, completion: nil)
    }
}

