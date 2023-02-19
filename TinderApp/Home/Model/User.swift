//
//  User.swift
//  TinderApp
//
//  Created by KH on 19/02/2023.
//

import UIKit

struct User: ProducesCardViewModel {
   
    let name, profession: String
    let imageNames: [String]
    let age: Int
    
}

extension User {
    func toCardViewModel() -> CardViewModel{
        return CardViewModel(
            imageNames: imageNames,
            attributeText: getAttribute(),
            textAlignment: .left
        )
    }
    
    func getAttribute() -> NSAttributedString? {
        let attributeText = NSMutableAttributedString(
            string: "\(name)",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        attributeText.append(NSMutableAttributedString(
            string: " \(age)",
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
