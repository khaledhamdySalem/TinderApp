//
//  RegistrationViewViewModel.swift
//  TinderApp
//
//  Created by KH on 19/02/2023.
//

import Foundation

final class RegistrationViewViewModel {
    
    // MARK: -
    var isFormValidObserver: ((Bool) -> Void)?
    
    // MARK: -
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    var email: String? {
        didSet {
            checkFormValidity()
        }
    }
    var password: String? {
        didSet {
            checkFormValidity()
        }
    }
    
    // MARK: - Check For Validity
    private func checkFormValidity() {
        let isValidForm = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isValidForm)
    }
}
