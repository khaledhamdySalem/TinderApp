//
//  UITextField+Extension.swift
//  TinderApp
//
//  Created by KH on 19/02/2023.
//

import UIKit

final class CustomTextField: UITextField {
    
    let padding: CGFloat
    let height: CGFloat
    
    init(padding: CGFloat, height: CGFloat) {
        self.padding = padding
        self.height = height
        super.init(frame: .zero)
        layer.cornerRadius = height / 2
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func createTextFiled(placeHolder: String) -> CustomTextField {
        let textFiled = CustomTextField(padding: 16, height: 16)
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        textFiled.placeholder = placeHolder
        textFiled.layer.cornerRadius = 20
        textFiled.backgroundColor = .white
        textFiled.heightAnchor.constraint(equalToConstant: 45).isActive = true
        return textFiled
    }

}

