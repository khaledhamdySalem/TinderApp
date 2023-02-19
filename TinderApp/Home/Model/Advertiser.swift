//
//  Advertiser.swift
//  TinderApp
//
//  Created by KH on 19/02/2023.
//

import UIKit

struct Advertiser: ProducesCardViewModel {
    let title: String
    let brandName: String
    let posterPhotoName: String
}

extension Advertiser {
    func toCardViewModel() -> CardViewModel{
        return CardViewModel(
            imageNames: [posterPhotoName],
            attributeText: getAttribute(),
            textAlignment: .center
        )
    }
    
    func getAttribute() -> NSAttributedString? {
        let attributeText = NSMutableAttributedString(
            string: "\(title)",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        
        attributeText.append(NSMutableAttributedString(
            string: "\n\(brandName)",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return attributeText
    }
}
