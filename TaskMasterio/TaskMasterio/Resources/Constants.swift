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

enum Margins {
    static let _0: CGFloat = 0
    static let _10: CGFloat = 10
    static let _12: CGFloat = 12
    static let _16: CGFloat = 16
    static let _2x16: CGFloat = 2 * _16
}

enum Sizes {
    static let sero: CGFloat = 0
    static let margin_10: CGFloat = 10
    static let margin_12: CGFloat = 12
    static let margin_16: CGFloat = 16
    static let margin_2x16: CGFloat = 2 * margin_16

    static let buttonH: CGFloat = 56
    
    static let zero: CGFloat = 0
    static let marginV: CGFloat = 12        // margin vertically
    static let marginV_10: CGFloat = 10     // margin vertically
    static let marginH: CGFloat = 16        // margin horizontally
    static let marginTxB: CGFloat = 16      // margin between top and bottom
    static let margin2xH = 2 * marginH      // margin of 2 horizontally
    static let spacingV: CGFloat = 16
    static let spacingH: CGFloat = 16
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
    case largeTitle
    case title
    case headline
    case body
    case bodyBold
    case subhead
    case footnote
    
    static func getFont(named: Fonts) -> UIFont {
        var font: UIFont
        switch named {
        case .largeTitle:
            font = UIFont.systemFont(ofSize: 38, weight: .bold)
        case .title:
            font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        case .headline:
            font = UIFont(name: "SFProText-Semibold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .semibold)
        case .body:
            font = UIFont(name: "SFProText-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .regular)
        case .bodyBold:
            font = UIFont(name: "SFProText-Bold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .bold)
        case .subhead:
            font = UIFont(name: "SFProText-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .regular)
        case .footnote:
            font = UIFont(name: "SFProText-Semibold", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .semibold)
        }

        return font
    }
    
    static let sfPro_13 = UIFont(name: "SF Pro", size: 13) ?? UIFont.systemFont(ofSize: 13)
    static let sfPro_15 = UIFont(name: "SF Pro", size: 15) ?? UIFont.systemFont(ofSize: 15)
    static let sfPro_17 = UIFont(name: "SF Pro", size: 17) ?? UIFont.systemFont(ofSize: 17)
    
}
