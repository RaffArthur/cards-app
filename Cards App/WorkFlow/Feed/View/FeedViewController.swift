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
        feedView.setupTableView(dataSource: self,
                                delegate: self)
        
        setupStateForRemoveAllCardsButton()
        
        setupScreen()
        setupActions()
    }
    
    override func loadView() {
        view = feedView
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
                
        navigationController?.pushViewController(cardVC,
                                                 animated: true)
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
                                          style: .destructive) { [weak self] _ in
            CardsStore.shared.cards.removeAll()
            
            self?.feedView.reloadTableViewData()
            
            self?.setupStateForRemoveAllCardsButton()
        }
        
        let denyAction = UIAlertAction(title: actiontDenyTitle,
                                       style: .cancel,
                                       handler: nil)
        
        alert.addAction(approveAction)
        alert.addAction(denyAction)
        
        present(alert,
                animated: true,
                completion: nil)
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

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath,
                              animated: true)
        
        let cardDetailsVC = CardDetailsViewController()
        let currentCard = CardsStore.shared.cards[indexPath.item]
        
        cardDetailsVC.setupCard(card: currentCard)
        
        navigationController?.pushViewController(cardDetailsVC,
                                                 animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return CardsStore.shared.cards.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: FeedTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier,
                                                 for: indexPath) as? FeedTableViewCell
        
        guard
            let cell = cell
        else {
            return UITableViewCell()
        }
        
        cell.configure(card: CardsStore.shared.cards[indexPath.item])

        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trashAction = UIContextualAction(style: .destructive,
                                             title: "Удалить") { [weak self] action, view, success in

            CardsStore.shared.cards.remove(at: indexPath.item)
            
            self?.setupStateForRemoveAllCardsButton()
            
            tableView.deleteRows(at: [indexPath],
                                 with: .fade)
            
            success(true)
        }
        
        return UISwipeActionsConfiguration(actions: [trashAction])
    }
}
