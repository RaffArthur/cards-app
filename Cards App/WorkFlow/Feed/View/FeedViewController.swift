//
//  FeedViewController.swift
//  Cards App
//
//  Created by Arthur Raff on 21.07.2021.
//

import UIKit

final class FeedViewController: UIViewController {
    private lazy var feedView: FeedView = {
        let fv = FeedView()
        fv.delegate = self
        
        return fv
    }()
    
    private lazy var addNewCardButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.image = UIImage(systemName: "plus")
        bbi.style = .done
        
        return bbi
    }()
    
    private lazy var removeAllCardsButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Удалить все"
        
        return bbi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedView.reloadTableViewData()
        
        setupStateForRemoveAllCardsButton()
        
        setupScreen()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        feedView.reloadTableViewData()
        
        setupStateForRemoveAllCardsButton()
    }
}

private extension FeedViewController {
    func setupScreen() {
        setupContent()
        setupLayout()
    }
    
    func setupLayout() {
        view.add(subview: feedView)
        
        feedView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func setupContent() {
        view.backgroundColor = UIColor.appColor(.accentBackgroundColor)
        
        navigationItem.title = "Мои карточки"
        navigationItem.leftBarButtonItem = removeAllCardsButton
        navigationItem.rightBarButtonItem = addNewCardButton
                
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
    }
}

private extension FeedViewController {
    @objc func addNewCardButtonHasBeenTapped() {
        let cardVC = CardViewController()
                
        navigationController?.pushViewController(cardVC, animated: true)
    }
    
    @objc func removeAllCardsButtonHasBeenTapped() {
        let alertTitle = "Предупреждение"
        let alertMessage = "Вы собираетесь удалить все карточки, вы действительно этого хотите?"
        let actionApproveTitle = "Удалить"
        let actiontDenyTitle = "Отказаться"

        let alert = UIAlertController(title: alertTitle,
                                      message: alertMessage,
                                      preferredStyle: .alert)
        let approveAction = UIAlertAction(title: actionApproveTitle,
                                          style: .destructive) { [self] _ in
            CardsStore.shared.cards.removeAll()
            
            feedView.reloadTableViewData()
            
            setupStateForRemoveAllCardsButton()
        }
        
        let denyAction = UIAlertAction(title: actiontDenyTitle,
                                       style: .cancel,
                                       handler: nil)
        
        alert.addAction(approveAction)
        alert.addAction(denyAction)
        
        present(alert, animated: true, completion: nil)
    }
}


private extension FeedViewController {
    func setupActions() {
        addNewCardButton.target = self
        addNewCardButton.action = #selector(addNewCardButtonHasBeenTapped)

        removeAllCardsButton.target = self
        removeAllCardsButton.action = #selector(removeAllCardsButtonHasBeenTapped)
    }
    
    func setupStateForRemoveAllCardsButton() {
        if CardsStore.shared.cards.isEmpty {
            removeAllCardsButton.tintColor = UIColor.appColor(.secondFontColor)
            removeAllCardsButton.isEnabled = false
            removeAllCardsButton.style = .plain
        } else {
            removeAllCardsButton.tintColor = UIColor.appColor(.AccentColor)
            removeAllCardsButton.isEnabled = true
            removeAllCardsButton.style = .done
        }
    }
}

extension FeedViewController: FeedViewDelegate {
    func removeCardBy(index: Int) {
        CardsStore.shared.cards.remove(at: index)
        
        setupStateForRemoveAllCardsButton()
    }
    
    func showFullCardDetailsScreenBy(index: Int) {
        let cardDetailsVC = CardDetailsViewController()
        cardDetailsVC.card = CardsStore.shared.cards[index]

        navigationController?.pushViewController(cardDetailsVC, animated: true)
    }
}
