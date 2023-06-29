//
//  TodoList.TableViewCell.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 29.06.2023.
//

import UIKit

final class TodoListTableViewCell: UITableViewCell {

    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        
        titleLabel = UILabel()
        subtitleLabel = UILabel()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Trying to initialize Todo List Table View Cell...")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: 10, y: 10, width: contentView.bounds.width - 20, height: 20)
        subtitleLabel.frame = CGRect(x: 10, y: 30, width: contentView.bounds.width - 20, height: 20)
    }
    
    // MARK: - Setup Functions
    private func setup() {
    }
}
