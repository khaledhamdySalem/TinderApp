//
//  RegistrationViewController.swift
//  TinderApp
//
//  Created by KH on 19/02/2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - Views
    private let registerView = RegistrationView()
    private let viewModel = RegistrationViewViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addConstraints()
        setActions()
        observerView()
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
    
    private func observerView() {
        viewModel.binableImage.bind { [weak self] image in
            self?.registerView.update(selectedPhoto: image)
        }
    }
}

// MARK: - Set Actions
extension RegistrationViewController {
    private func setActions() {
        registerView.didSelectPhoto = { [weak self] in
            self?.handleSelectedPhoto()
        }
    }
    
    private func handleSelectedPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
}

extension RegistrationViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        viewModel.binableImage.value = image
        dismiss(animated: true)
    }
}
