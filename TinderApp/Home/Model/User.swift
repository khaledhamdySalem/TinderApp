//
//  User.swift
//  TinderApp
//
//  Created by KH on 19/02/2023.
//

import UIKit

struct User: ProducesCardViewModel {
   
    let name, profession, imageName: String
    let age: Int
    
}

extension User {
    func toCardViewModel() -> CardViewModel{
        return CardViewModel(
            imageName: imageName,
            attributeText: getAttribute(),
            textAlignment: .left
        )
    }
    
    var model: CardViewModel {
        return CardViewModel(imageName: imageName,
                             attributeText: getAttribute(),
                             textAlignment: .left)
    }
    
    func getAttribute() -> NSAttributedString? {
        let attributeText = NSMutableAttributedString(
            string: "\(name)",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        attributeText.append(NSMutableAttributedString(
            string: "\(age)",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        
        attributeText.append(NSMutableAttributedString(
            string: "\n\(profession)",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return attributeText
    }
}
