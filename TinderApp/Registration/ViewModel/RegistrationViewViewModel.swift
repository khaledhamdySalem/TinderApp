//
//  RegistrationViewViewModel.swift
//  TinderApp
//
//  Created by KH on 19/02/2023.
//

import UIKit
import Firebase

final class RegistrationViewViewModel {
    
    // MARK: - CallBack
    var isFormValidObserver = Bindable<Bool>()
    var binableImage = Bindable<UIImage>()
    var bindableIsRegitering = Bindable<Bool>()
    
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
    
    // MARK: - Check For Validity
    private func checkFormValidity() {
        let isValidForm = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver.value = isValidForm
    }
    
    func performRegistration(complition: @escaping(Error?) -> Void) {
        
        guard let email = email, let pass = password else { return }
        
        bindableIsRegitering.value = true
        
        Auth.auth().createUser(withEmail: email, password: pass) { [weak self] res, error in
    
            if let error = error {
                complition(error)
                print(error)
            }
            
            if let res = res {
                print(res.user.uid)
            }
            
            let fileName = UUID().uuidString
            let ref = Storage.storage().reference(withPath: "/images/\(fileName)")
            
            let imageData = self?.binableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
            
            ref.putData(imageData, metadata: nil) { _, err in
                if let err = err {
                    complition(err)
                    return
                }
                
                print("Finishing uploading image to the storage")
                
                ref.downloadURL { url, err in
                    if let err = err {
                        complition(err)
                        return
                    }
                    
                    self?.bindableIsRegitering.value = false
                    
                    print("Download url of our image is \(url?.absoluteString ?? "")")
                }
            }
        }
    }
}
