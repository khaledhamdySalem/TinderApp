//
//  CardViewModel.swift
//  TinderApp
//
//  Created by KH on 19/02/2023.
//


protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

import UIKit

struct CardViewModel {
    let imageName: String
    let attributeText: NSAttributedString?
    let textAlignment: NSTextAlignment
    
}
