//
//  UIBarButtonStateSetup.swift
//  Cards App
//
//  Created by Arthur Raff on 21.09.2021.
//

import UIKit

extension UIBarButtonItem {
    func isDisabledState() {
        self.tintColor = UIColor.appColor(.secondFontColor)
        self.isEnabled = false
        self.style = .plain
    }
    
    func isEnabledState() {
        self.tintColor = UIColor.appColor(.AccentColor)
        self.isEnabled = true
        self.style = .done
    }
}


public struct ButtonsStateSetup {
    public static func stateSetupFor(button: UIBarButtonItem) {
        if CardsStore.shared.cards.isEmpty {
            button.isDisabledState()
        } else {
            button.isEnabledState()
        }
    }
}
