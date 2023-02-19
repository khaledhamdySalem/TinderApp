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

final class CardViewModel {
    public let imageNames: [String]
    public let attributeText: NSAttributedString?
    public let textAlignment: NSTextAlignment
    
    init(
        imageNames: [String],
        attributeText: NSAttributedString?,
        textAlignment: NSTextAlignment
    ) {
        self.imageNames = imageNames
        self.attributeText = attributeText
        self.textAlignment = textAlignment
    }
    
    public var photoIndexObserver: ((Int) -> Void)?
    
    private var imageIndex = 0 {
        didSet {
            photoIndexObserver?(imageIndex)
        }
    }
    
    func goToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
    func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}
