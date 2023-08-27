//
//  AddActions+UIAllertController.swift
//  Cards App
//
//  Created by Arthur Raff on 22.08.2023.
//

import UIKit

extension UIAlertController {
    func add(action: UIAlertAction) {
        self.addAction(action)
    }
    
    func add(actions: [UIAlertAction]) {
        actions.forEach { self.add(action: $0) }
    }
}
