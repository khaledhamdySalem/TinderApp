//
//  HomeTopStackView.swift
//  TinderApp
//
//  Created by KH on 18/02/2023.
//

import UIKit

class HomeTopStackView: UIStackView {
    
    private let fireButton = UIImageView(image: #imageLiteral(resourceName: "fire"))
    private let messageButton = UIButton(type: .system)
    
    private lazy var settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapOnSettinButton), for: .touchUpInside)
        return button
    }()
    
    var didTapOnSettingButtonClousre: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createStackView()
    }
    
    private func createStackView() {
        settingButton.setImage(#imageLiteral(resourceName: "person").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "message").withRenderingMode(.alwaysOriginal), for: .normal)
        
        fireButton.contentMode = .scaleAspectFit
        
        [settingButton, fireButton, messageButton].forEach { button in
            addArrangedSubview(button)
        }
       
        distribution = .equalCentering
        axis = .horizontal
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    @objc func didTapOnSettinButton() {
        didTapOnSettingButtonClousre?()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
