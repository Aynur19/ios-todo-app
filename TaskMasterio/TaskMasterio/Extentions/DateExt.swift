//
//  DateExt.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 16.06.2023.
//

import Foundation

extension Date {
    var datetime: Int { get { Int(timeIntervalSince1970) } }
    
    func toString(format: String = Values.deadlineDateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
