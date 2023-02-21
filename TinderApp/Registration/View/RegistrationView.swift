//
//  RegistrationView.swift
//  TinderApp
//
//  Created by KH on 19/02/2023.
//

import UIKit
import Firebase
import JGProgressHUD

final class RegistrationView: UIView {
    
    // MARK: - Clousre
    var didSelectPhoto: (() -> ())?
    
    // MARK: - View Model
    var viewModel = RegistrationViewViewModel()
    
    // MARK: - Views
     lazy var selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select Photo", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 250).isActive = true
        button.layer.cornerRadius = 20
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelectedPhoto), for: .touchUpInside)
        return button
    }()
  
    lazy private var fullNameTextFiled = CustomTextField.createTextFiled(placeHolder: "Enter Your Full Name")
    
    lazy private var emailTextFiled = CustomTextField.createTextFiled(placeHolder: "Enter Your Email Address")
    
    lazy private var passwordTextFiled = CustomTextField.createTextFiled(placeHolder: "Enter Your Password")
    
    var stackView = UIStackView()
    
    private lazy var registrButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        button.backgroundColor = #colorLiteral(red: 0.6627451181, green: 0.6627451181, blue: 0.6627451181, alpha: 1)
        button.setTitleColor(.gray, for: .disabled)
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleRegisterAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Config
    private let gradiant = CAGradientLayer()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addConstraints()
        configureTextFiled()
        setupRegisterViewModelObserver()
    }
    
    private func setupRegisterViewModelObserver() {
        viewModel.isFormValidObserver.bind { [weak self] inValidForm in
            guard let inValidForm = inValidForm else { return }
            self?.registrButton.isEnabled = inValidForm
            if inValidForm {
                self?.registrButton.backgroundColor = #colorLiteral(red: 0.8226264119, green: 0.09301393479, blue: 0.3175445795, alpha: 1)
            } else {
                self?.registrButton.backgroundColor = #colorLiteral(red: 0.6627451181, green: 0.6627451181, blue: 0.6627451181, alpha: 1)
            }
        }
    }
    
    private func configureTextFiled() {
        fullNameTextFiled.keyboardType = .namePhonePad
        emailTextFiled.keyboardType = .emailAddress
        passwordTextFiled.isSecureTextEntry = true
        fullNameTextFiled.addTarget(self, action: #selector(handleChange), for: .editingChanged)
        emailTextFiled.addTarget(self, action: #selector(handleChange), for: .editingChanged)
        passwordTextFiled.addTarget(self, action: #selector(handleChange), for: .editingChanged)
    }
    
    @objc private func handleChange(textFiled: UITextField) {
        if textFiled == fullNameTextFiled {
            viewModel.fullName = textFiled.text
        } else if textFiled == emailTextFiled {
            viewModel.email = textFiled.text
        } else {
            viewModel.password = textFiled.text
        }
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        setupGradiant()
        configureTextFiled()
        setupNotificationObservar()
        addTapGesture()
    }
    
    private func setupNotificationObservar() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func handleKeyboard(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let bottomSpace = frame.height - stackView.frame.origin.y - stackView.frame.height
        let differance: CGFloat = keyboardFrame.height - bottomSpace
        self.transform = CGAffineTransform(translationX: 0, y: -differance - 8)
    }
    
    private func addTapGesture() {
        let tapGeustre = UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard(gesture:)))
        addGestureRecognizer(tapGeustre)
    }
    
    @objc private func handleDismissKeyboard(gesture: UITapGestureRecognizer) {
        endEditing(true)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1) {
            self.transform = .identity
        }
    }
    
    private func addConstraints() {
        stackView = UIStackView(arrangedSubviews: [
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
    
    private func showHUD(with error: Error) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed Registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self)
        hud.dismiss(afterDelay: 4)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Set Actions
extension RegistrationView {
    
    @objc private func handleRegisterAction() {
        endEditing(true)
        
        guard let email = emailTextFiled.text, let pass = passwordTextFiled.text else { return }
        Auth.auth().createUser(withEmail: email, password: pass) { [weak self] res, error in
            if let error = error {
                self?.showHUD(with: error)
                print(error)
            }
            
            if let res = res {
                print(res.user.uid)
            }
        }
    }
    
    @objc private func handleSelectedPhoto() {
        self.didSelectPhoto?()
    }
    
    func update(selectedPhoto: UIImage?) {
        self.selectPhotoButton.setImage(selectedPhoto?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
}
