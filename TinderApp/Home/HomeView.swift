//
//  HomeView().swift
//  TinderApp
//
//  Created by KH on 18/02/2023.
//

import UIKit

class HomeView: UIView {
    
    let topStackView = HomeTopStackView()
    var cardsDickView = UIView()
    let bottomStackView = HomeBottomStackView()
    
    var cardViewModels: [CardViewModel] = {
        let producer: [ProducesCardViewModel] =
        [
            User(name: "Ahmed", profession: "IOS", imageNames: ["jane1", "jane2", "jane3"], age: 19),
            User(name: "Ahmed", profession: "IOS", imageNames: ["kelly1", "kelly2", "kelly3"], age: 19),
            Advertiser(title: "Morad", brandName: "Hello to my fsculty", posterPhotoName: "slide_out_menu_poster"),
        ]
        
        let models = producer.map({$0.toCardViewModel()})
        return models
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addConstraints()
        setCardView()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addConstraints() {
        let overAllStackView = UIStackView(
            arrangedSubviews: [topStackView, cardsDickView, bottomStackView])
        overAllStackView.bringSubviewToFront(cardsDickView)
        overAllStackView.axis = .vertical
        overAllStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(overAllStackView)
        
        NSLayoutConstraint.activate([
            overAllStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            overAllStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            overAllStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            overAllStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Setup CardView
    private func setCardView() {
        cardViewModels.forEach { cardVM in
            let cardView = CardView(frame: .zero)
            cardsDickView.addSubview(cardView)
            cardView.cardViewModel = cardVM
            addCardViewConstraints(cardView)
        }
    }
    
    private func addCardViewConstraints(_ cardView: CardView) {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: cardsDickView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: cardsDickView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: cardsDickView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: cardsDickView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
