//
//  TodoList.TableViewCell.Last.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 01.07.2023.
//

import UIKit


final class TodoListTableViewCellLast: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Trying to initialize Todo List Table View Cell...")
    }
    
    // MARK: - Setup Functions
    private func setup() {
        contentView.addSubview(titleLable)
        NSLayoutConstraint.activate([
            titleLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 68),
            titleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
        ])
    }
    
    // MARK: - UI Elements
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.text = "Новое"
        label.font = Fonts.getFont(named: .body)
        label.textColor = UIColor(named: AccentColors.labelTertiary)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
}

