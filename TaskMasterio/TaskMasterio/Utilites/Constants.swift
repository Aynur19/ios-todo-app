//
//  Constants.swift
//  TaskMasterio
//
//  Created by Aynur Nasybullin on 22.06.2023.
//

import Foundation
import UIKit

enum Values {
    static let taskDescriptionPlacholder = "Что надо сделать?"
    
    static let priorityLow = "arrow.down"
    static let priorityMedium = "нет"
    static let priorityHigh = "exclamationmark.2"
    
    static let deadlineDateFormat = "d MMMM yyyy"
}

enum Titles {
    static let task = "Дело"
    static let cancel = "Отменить"
    static let save = "Сохранить"
    static let delete = "Удалить"
    static let priority = "Важность"
    static let deadline = "Сделать до"
   
    static let todoList = "Мои дела"
    static let todoListCellId = "TodoListTableViewCell"
    static let todoListCellLastId = "TodoListTableViewCellLast"
}

enum Margins {
    static let mg0: CGFloat = 0
    static let mg8: CGFloat = 8
    static let mg10: CGFloat = 10
    static let mg12: CGFloat = 12
    static let mg16: CGFloat = 16
    static let mg32: CGFloat = 32
}

enum Sizes {
    static let buttonH: CGFloat = 56
    static let separatorH: CGFloat = 1
    
    static let descriptionMinHeight: CGFloat = 120
    static let textViewFontSize: CGFloat = 17
    static let cornerRadius: CGFloat = 16
    
    static let deleteButtonHeight: CGFloat = 56
    
    static let prioritySegmentedControlH: CGFloat = 36
    static let prioritySegmentedControlW: CGFloat = 150
}

enum AccentColors {
    static let backElevated = "Back Elevated"
    static let backPrimary = "Back Primary"
    static let backSecondary = "Back Secondary"
    static let colorBlue = "Color Blue"
    static let colorGrey = "Color Grey"
    static let colorRed = "Color Red"
    static let labelPrimary = "Label Primary"
    static let labelTertiary = "Label Tertiary"
    static let supportOverlay = "Support Overlay"
    static let supportSeparator = "Support Separator"
    
}

enum Fonts {
    static let largeTitle   = UIFont.systemFont(ofSize: 38, weight: .bold)
    static let title        = UIFont.systemFont(ofSize: 20, weight: .semibold)
    static let headline     = UIFont(name: "SFProText-Semibold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let body         = UIFont(name: "SFProText-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .regular)
    static let bodyBold     = UIFont(name: "SFProText-Bold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .bold)
    static let subhead      = UIFont(name: "SFProText-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .regular)
    static let subheadBold  = UIFont(name: "SFProText-Bold", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .bold)
    static let footnote     = UIFont(name: "SFProText-Semibold", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .semibold)
}

struct DatetimeFormats {
    static let yyyyMMddTHHmmss = "yyyy-MM-dd HH:mm:ss"
}
