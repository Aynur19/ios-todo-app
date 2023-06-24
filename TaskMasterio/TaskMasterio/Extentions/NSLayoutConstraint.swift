//
//  NSLayoutConstraint.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 22.06.2023.
//

import UIKit

extension NSLayoutConstraint {
    func with(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
