//
//  ViewController.swift
//  TinderApp
//
//  Created by KH on 18/02/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Views
    let homeView = HomeView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeView)
        tapOnSettingButton()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    private func tapOnSettingButton() {
        homeView.didTapOnSettingButton = { [weak self] in
            let vc = RegistrationViewController()
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
    }
}
