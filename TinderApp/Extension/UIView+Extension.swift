//
//  UIView+Extension.swift
//  TinderApp
//
//  Created by KH on 19/02/2023.
//

import UIKit


extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
