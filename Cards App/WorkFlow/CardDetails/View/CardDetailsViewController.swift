//
//  CardDetailsViewController.swift
//  Cards App
//
//  Created by Arthur Raff on 29.07.2021.
//

import UIKit

final class CardDetailsViewController: UIViewController {
    private lazy var cardDetailsView: CardDetailsView = {
        let cdv = CardDetailsView()

        return cdv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupScreen()
    }
    
    override func loadView() {
        view = cardDetailsView
    }
}

private extension CardDetailsViewController {
    func setupScreen() {
        setupContent()
    }
    
    func setupContent() {
        view.backgroundColor = UIColor.appColor(.accentBackgroundColor)
    }
}

extension CardDetailsViewController {
    func setupCard(card: Card) {
        cardDetailsView.prepareCard(card: card)
    }
}
