//
//  FeedViewController.swift
//  Cards App
//
//  Created by Arthur Raff on 21.07.2021.
//

import UIKit

@available(iOS 13.0, *)
class FeedViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.backgroundColor = UIColor.appColor(.accentBackgroundColor)
        tv.separatorStyle = .singleLine
        tv.separatorColor = UIColor.systemIndigo.withAlphaComponent(0.4)
        tv.separatorInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        tv.showsVerticalScrollIndicator = true
        tv.register(FeedTableViewCell.self, forCellReuseIdentifier: String(describing: FeedTableViewCell.self))
        tv.dataSource = self
        tv.delegate = self
                
        return tv
    }()    
    private lazy var addNewCard: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.image = UIImage(systemName: "plus")
        bbi.style = .done
        bbi.target = self
        bbi.action = #selector(toAddNewCardScreen)
        
        return bbi
    }()
    private lazy var removeAllCards: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Очистить"
        bbi.target = self
        bbi.action = #selector(showRemovingAllCardsAlert)

        return bbi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ButtonsStateSetup.stateSetupFor(button: removeAllCards)
        reloadTableViewData()
    }
}

@available(iOS 13.0, *)
extension FeedViewController: ScreenSetup {
    private func setupScreen() {
        setupContent()
        setupLayout()
    }
    
    private func setupContent() {
        view.backgroundColor = UIColor.appColor(.accentBackgroundColor)
        
        navigationItem.title = "Мои карточки"
        navigationItem.leftBarButtonItem = removeAllCards
        navigationItem.rightBarButtonItem = addNewCard
        
        guard let navigationController = navigationController else { return }
        
        navigationController.navigationBar.prefersLargeTitles = true
        
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

@available(iOS 13.0, *)
extension FeedViewController: FuncionalitySetup {
    private func reloadTableViewData() {
        DispatchQueue.main.async(qos: .userInteractive) { [weak self] in
            guard let self = self else { return }
            
            self.tableView.reloadData()
        }
    }
        
    @objc private func toAddNewCardScreen() {
        let cardVC = CardViewController()
        
        guard let navigationController = navigationController else { return }
        
        navigationController.pushViewController(cardVC, animated: true)
        
        reloadTableViewData()
    }
    
    @objc private func showRemovingAllCardsAlert() {
        let alertTitle = "Предупреждение"
        let alertMessage = "Вы собираетесь удалить все карточки, вы действительно этого хотите?"
        let actionApproveTitle = "Удалить"
        let actiontDenyTitle = "Отказаться"

        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let approveAction = UIAlertAction(title: actionApproveTitle, style: .destructive) { [self] _ in
            CardsStore.shared.cards.removeAll()
            
            ButtonsStateSetup.stateSetupFor(button: removeAllCards)

            reloadTableViewData()
        }
        
        let denyAction = UIAlertAction(title: actiontDenyTitle, style: .cancel, handler: nil)
        
        alert.addAction(approveAction)
        alert.addAction(denyAction)
        
        present(alert, animated: true, completion: nil)
    }
}

@available(iOS 13.0, *)
extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cardDetailsVC = CardDetailsViewController()
        cardDetailsVC.card = CardsStore.shared.cards[indexPath.item]
        
        guard let navigationController = navigationController else { return }
        navigationController.pushViewController(cardDetailsVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CardsStore.shared.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedTableViewCell.self), for: indexPath) as! FeedTableViewCell
        
        cell.card = CardsStore.shared.cards[indexPath.item]
        
        return cell
    }
}

@available(iOS 13.0, *)
extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let trashAction = UIContextualAction(style: .destructive, title: "Удалить", handler: { [self] (action: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            
            CardsStore.shared.cards.remove(at: indexPath.item)
            
            ButtonsStateSetup.stateSetupFor(button: removeAllCards)

            tableView.deleteRows(at: [indexPath], with: .fade)

            success(true)
        })
        
        return UISwipeActionsConfiguration(actions: [trashAction])
    }
}

