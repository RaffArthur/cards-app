//
//  ColorSet.swift
//  FINCH Test
//
//  Created by Arthur Raff on 29.07.2021.
//

import UIKit

enum ColorSet: String {
    case accentBackgroundColor, accentFontColor, secondBackgroundColor, secondFontColor
}

extension UIColor {
    static func appColor(_ name: ColorSet) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}
