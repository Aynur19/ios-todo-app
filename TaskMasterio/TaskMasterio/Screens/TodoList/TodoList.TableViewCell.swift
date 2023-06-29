//
//  TodoList.TableViewCell.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 29.06.2023.
//

import UIKit

final class TodoListTableViewCell: UITableViewCell {
    // Add any necessary UI elements as properties of the cell
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    // Custom initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Configure and add UI elements to the cell's contentView
        titleLabel = UILabel()
        subtitleLabel = UILabel()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Trying to initialize Todo List Table View Cell...")
    }
    
    // Override layoutSubviews() to adjust the layout of your custom cell's subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Perform any custom layout here
        titleLabel.frame = CGRect(x: 10, y: 10, width: contentView.bounds.width - 20, height: 20)
        subtitleLabel.frame = CGRect(x: 10, y: 30, width: contentView.bounds.width - 20, height: 20)
    }
}
