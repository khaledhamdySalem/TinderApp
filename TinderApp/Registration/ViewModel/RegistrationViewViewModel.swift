//
//  RegistrationViewViewModel.swift
//  TinderApp
//
//  Created by KH on 19/02/2023.
//

import UIKit

final class RegistrationViewViewModel {
    
    // MARK: - CallBack
    var isFormValidObserver = Bindable<Bool>()
    
    // MARK: - Properties
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
    
    var binableImage = Bindable<UIImage>()
    
    // MARK: - Check For Validity
    private func checkFormValidity() {
        let isValidForm = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
//        isFormValidObserver?(isValidForm)
        isFormValidObserver.value = isValidForm
    }
}
