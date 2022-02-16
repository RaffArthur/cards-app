//
//  CardViewTextFieldDelegate.swift
//  Cards App
//
//  Created by Arthur Raff on 29.07.2021.
//

import UIKit

@available(iOS 13.0, *)
extension CardViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}
