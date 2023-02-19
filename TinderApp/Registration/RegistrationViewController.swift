//
//  RegistrationViewController.swift
//  TinderApp
//
//  Created by KH on 19/02/2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private let registerView = RegistrationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
    }
    
    private func configureView() {
        view.addSubview(registerView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            registerView.topAnchor.constraint(equalTo: view.topAnchor),
            registerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
