//
//  CardViewKeybordObserverDelegate.swift
//  FINCH Test
//
//  Created by Arthur Raff on 29.07.2021.
//

import UIKit

@available(iOS 13.0, *)
public protocol KeyboardObserverDelegate: AnyObject {
    func addKeyboardObserver()
    func removeKeyboardObserver()
}

@available(iOS 13.0, *)
extension CardViewController: KeyboardObserverDelegate {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardSize = keyboardRect.cgRectValue
        
        scrollView.contentInset.bottom = keyboardSize.height
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = 0
    }
}
