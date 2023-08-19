//
//  ColorSet.swift
//  Cards App
//
//  Created by Arthur Raff on 29.07.2021.
//

import UIKit

public enum ColorSet: String {
    case accentBackgroundColor, accentFontColor, secondBackgroundColor, secondFontColor, AccentColor
}

extension UIColor {
    static func appColor(_ name: ColorSet) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}
