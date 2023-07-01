//
//  UIView.Ext.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 30.06.2023.
//

import UIKit

extension UIView {
    static func getContainer() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }
}
