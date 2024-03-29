//
//  TodoItem.ViewController.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 27.06.2023.
//

import UIKit
import Combine

final class TodoItemViewController: UIViewController {
    
    private var viewModel: TodoItemViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: TodoItemViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: .none)
    }
    
    override required init?(coder: NSCoder) {
        fatalError("Trying init TodoItemViewController...")
    }
    
    // MARK: - Lifesycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavBar()
        setupContentScrollView()
        
        setupTapGestureRecognizer()
        
        bindViewModel()
    }
    
    // MARK: - Setup Functions
    private func setupView() {
        title = Titles.task
        view.backgroundColor = UIColor(named: AccentColors.backPrimary)
    }
    
    private func setupNavBar() {
        if let navigationController = self.navigationController {
            navigationController.navigationBar.barStyle = .default
            
            navigationItem.leftBarButtonItem = cancelButton
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    private func setupContentScrollView() {
        view.addSubview(contentScrollView)
        
        NSLayoutConstraint.activate([
            contentScrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            contentScrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            contentScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -Margins.mg16),
        ])
        contentScrollView.contentSize = view.bounds.size
    }
    
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onViewTapped))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func bindViewModel() {
        viewModel.taskIsChanged
            .assign(to: \.isEnabled, on: saveButton)
            .store(in: &cancellables)
        
        viewModel.$taskState
            .sink { [weak self] taskState in
                if taskState == .close {
                    self?.viewModel.taskState = .none
                    self?.exit()
                } else if taskState == .remove {
                    self?.viewModel.remove()
                    self?.viewModel.taskState = .none
                    self?.exit()
                }
                
            }
            .store(in: &cancellables)
    }
    
    // MARK: - UI Elements
    private lazy var contentScrollView = TodoItemScrollView(with: viewModel)
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Titles.cancel, style: .plain, target: self, action: #selector(onCancelButtonTapped))
        return button
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Titles.save, style: .plain, target: self, action: #selector(onSaveButtonTapped))
        button.setTitleTextAttributes([NSAttributedString.Key.font: Fonts.bodyBold], for: .normal)
        button.setTitleTextAttributes([NSAttributedString.Key.font: Fonts.bodyBold], for: .disabled)
        button.isEnabled = false
        
        return button
    }()
    
    // MARK: - Handlers
    @objc private func onCancelButtonTapped() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func onSaveButtonTapped() {
        viewModel.save()
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    func exit() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func onViewTapped() {
        view.endEditing(true)
    }
}
