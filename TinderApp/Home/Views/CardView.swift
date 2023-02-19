//
//  CardView.swift
//  TinderApp
//
//  Created by KH on 18/02/2023.
//

import UIKit

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
          
            self.imageView.image = UIImage(named: cardViewModel.imageNames.first ?? "")
            self.informationLabel.attributedText = cardViewModel.attributeText
            self.informationLabel.textAlignment = cardViewModel.textAlignment
          
            for _ in 0..<cardViewModel.imageNames.count {
                let barView = UIView()
                barView.backgroundColor = barDeselectedColor
                barStackView.addArrangedSubview(barView)
            }
            barStackView.arrangedSubviews.first?.backgroundColor = .white
            
            setupImageIndexObserver()
        }
    }
    
    // MARK: - Configuration
    private let threshold: CGFloat = 100
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Views
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private let barStackView = UIStackView()
    
    var imageIndex: Int = 0
    let barDeselectedColor = UIColor.init(white: 0, alpha: 0.1)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configurePanGesture()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        setBarStackView()
        setGriadiantLayer()
        addSubview(informationLabel)
        addConstraints()
       
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
     
    // MARK: - Setup Image Index Observer
    private func setupImageIndexObserver() {
        self.cardViewModel.photoIndexObserver = { [weak self] imageIndex in
            self?.imageView.image = UIImage(named: self?.cardViewModel?.imageNames[imageIndex] ?? "")
            self?.barStackView.arrangedSubviews.forEach({return $0.backgroundColor = self?.barDeselectedColor})
            self?.barStackView.arrangedSubviews[imageIndex].backgroundColor = .white
        }
    }
    
    // MARK: - Set Bar Stack View
    private func setBarStackView() {
        addSubview(barStackView)
        barStackView.spacing = 2
        barStackView.distribution = .fillEqually
        barStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            barStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            barStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            barStackView.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    private func configurePanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:  )))
        addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapNextOrPreviousPhoto(gesture: )))
        addGestureRecognizer(tapGesture)
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
    
    private func handleEnded(_ gesture: UIPanGestureRecognizer) {
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
    
    @objc private func handleTapNextOrPreviousPhoto(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: nil).x
        let shouldAdvanceNextPhoto = location > (frame.width / 2) ? true: false
        
        if shouldAdvanceNextPhoto {
            cardViewModel.goToNextPhoto()
        } else {
            cardViewModel.goToPreviousPhoto()
        }
    }
    
    private func setGriadiantLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1]
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

