//
//  CardDetailsViewController.swift
//  Cards App
//
//  Created by Arthur Raff on 29.07.2021.
//

import UIKit

class CardDetailsViewController: UIViewController {
    private lazy var cardDetailsView: CardDetailsView = {
        let cdv = CardDetailsView()
        
        return cdv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupScreen()
    }
}

private extension CardDetailsViewController {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        view.backgroundColor = UIColor.appColor(.accentBackgroundColor)
    }

    func setupLayout() {
        view.add(subview: cardDetailsView)
        
        cardDetailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CardDetailsViewController {
    func setupCard(card: Card) {
        cardDetailsView.prepareCard(card: card)
    }
}
