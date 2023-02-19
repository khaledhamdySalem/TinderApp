//
//  HomeBottomStackView.swift
//  TinderApp
//
//  Created by KH on 18/02/2023.
//

import UIKit

class HomeBottomStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createStackView()
    }
    
    private func createStackView() {
//        let bottomSubViews = [UIColor.red, .yellow, .purple, .green, .gray].map { color -> UIView in
//            let view = UIView()
//            view.backgroundColor = color
//            return view
//        }
        
        let bottomSubViews = [#imageLiteral(resourceName: "retry"), #imageLiteral(resourceName: "close"), #imageLiteral(resourceName: "star"), #imageLiteral(resourceName: "heart"), #imageLiteral(resourceName: "electric")].map { image -> UIButton in
            let button = UIButton()
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        
        distribution = .fillEqually
        axis = .horizontal
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        bottomSubViews.forEach { view in
            addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
