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
}

enum Sizes {
    static let zero: CGFloat = 0
    static let marginV: CGFloat = 12        // margin vertically
    static let marginV_10: CGFloat = 10     // margin vertically
    static let marginH: CGFloat = 16        // margin horizontally
    static let marginTxB: CGFloat = 16      // margin between top and bottom
    static let margin2xH = 2 * marginH      // margin of 2 horizontally
    static let spacingV: CGFloat = 16
    static let spacingH: CGFloat = 16
    static let separatorW: CGFloat = 1
    
    static let textViewMinHeight: CGFloat = 120
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
    static let sfPro_13 = UIFont(name: "SF Pro", size: 13) ?? UIFont.systemFont(ofSize: 13)
    static let sfPro_15 = UIFont(name: "SF Pro", size: 15) ?? UIFont.systemFont(ofSize: 15)
    static let sfPro_17 = UIFont(name: "SF Pro", size: 17) ?? UIFont.systemFont(ofSize: 17)
}
