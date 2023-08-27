//
//  AddSubviews+UIVew.swift
//  Cards App
//
//  Created by Arthur Raff on 19.08.2023.
//

import UIKit

extension UIView {
    func add(subview: UIView) {
        self.addSubview(subview)
    }
    
    func add(subviews: [UIView]) {
        subviews.forEach { self.add(subview: $0) }
    }
}
