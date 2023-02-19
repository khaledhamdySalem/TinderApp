//
//  RegistrationView.swift
//  TinderApp
//
//  Created by KH on 19/02/2023.
//

import UIKit

final class RegistrationView: UIView {
    
    // MARK: - Views
    private let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select Photo", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 250).isActive = true
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy private var fullNameTextFiled = CustomTextField.createTextFiled(placeHolder: "Enter Your Full Name")
    lazy private var emailTextFiled = CustomTextField.createTextFiled(placeHolder: "Enter Your Email Address")
    lazy private var passwordTextFiled = CustomTextField.createTextFiled(placeHolder: "Enter Your Password")
    
    private let registrButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        button.backgroundColor = .red
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 20
        return button
    }()
    
    // MARK: - Config
    private let gradiant = CAGradientLayer()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addConstraints()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        setupGradiant()
        configureTextFiled()
       
    }
    
    private func configureTextFiled() {
        fullNameTextFiled.keyboardType = .namePhonePad
        emailTextFiled.keyboardType = .emailAddress
        passwordTextFiled.isSecureTextEntry = true
    }
    
    private func addConstraints() {
        let stackView = UIStackView(arrangedSubviews: [
            selectPhotoButton,
            fullNameTextFiled,
            emailTextFiled,
            passwordTextFiled,
            registrButton
        ])
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
        
    private func setupGradiant() {
        let topColor = #colorLiteral(red: 0.983106792, green: 0.3619638085, blue: 0.3708369732, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8944732547, green: 0.1293645203, blue: 0.4480132461, alpha: 1)
        gradiant.colors = [bottomColor.cgColor, topColor.cgColor]
        gradiant.locations = [0.5, 1]
        layer.addSublayer(gradiant)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradiant.frame = bounds
    }
    
    // MARK: - Configure From View Model
    public func configure(with viewModel: RegistrationViewViewModel) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
