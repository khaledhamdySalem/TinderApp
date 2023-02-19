//
//  CardView.swift
//  TinderApp
//
//  Created by KH on 18/02/2023.
//

import UIKit

class CardView: UIView {
    
    var cardViewModel: CardViewModel? {
        didSet {
            guard let cardViewModel = cardViewModel else { return }
            self.imageView.image = UIImage(named: cardViewModel.imageName)
            self.informationLabel.attributedText = cardViewModel.attributeText
            self.informationLabel.textAlignment = cardViewModel.textAlignment
        }
    }
    
    // MARK: - Configuration
    private let threshold: CGFloat = 100
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Views
    public let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    public let informationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addConstraints()
        setGriadiantLayer()
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.numberOfLines = 2
        informationLabel.textColor = .white
        configureGesture()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(imageView, informationLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -0),
            
            informationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            informationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            informationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func configureGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:  )))
        addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .possible, .began, .cancelled, .failed:
            return
        case .changed:
            handleChanaged(gesture)
        case .ended:
            handleEnded(gesture)
        @unknown default:
            fatalError("UnSupported")
        }
    }
    
    private func handleChanaged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        self.transform = CGAffineTransform(translationX: translation.x,
                                           y: translation.y)
    }
    
    private func setGriadiantLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = frame
    }
    
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate (withDuration: 0.75, delay: 0,
                        usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1,
                        options: .curveEaseOut, animations: {
            
            if shouldDismissCard {
                let offScreenTransform = self.transform.translatedBy (x: 1000, y: 0)
                self.transform = offScreenTransform
            } else {
                self.transform = .identity
            }
            
        }) { (_) in
            self.transform = .identity
            self.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

