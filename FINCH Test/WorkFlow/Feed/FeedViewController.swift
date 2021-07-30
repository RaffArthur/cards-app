//
//  FeedViewController.swift
//  FINCH Test
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
        bbi.style = .plain
        bbi.target = self
        bbi.action = #selector(allCardsRemoved)

        return bbi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async(qos: .background) { [self] in
            tableView.reloadData()
        }
    }
    
    private func showDeletingAllCardsAlert() {
        let alert = UIAlertController(title: "Предупреждение", message: "Вы собираетесь удалить все карточки, вы действительно этого хотите?", preferredStyle: .alert)
        let approveAction = UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            CardsStore.shared.cards.removeAll()
            
            DispatchQueue.main.async(qos: .background) { [self] in
                tableView.reloadData()
            }
        })
        let denyAction = UIAlertAction(title: "Отказаться", style: .cancel, handler: nil)

        alert.addAction(approveAction)
        alert.addAction(denyAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showEmptyCardsStoreAlert() {
        let alert = UIAlertController(title: "Нет карточек", message: "Карточки отсуствуют или еще не были созданы", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func toAddNewCardScreen() {
        let cardVC = CardViewController()
        
        guard let navigationController = navigationController else { return }
        
        navigationController.pushViewController(cardVC, animated: true)
        
        DispatchQueue.main.async(qos: .background) { [self] in
            tableView.reloadData()
        }
    }
    
    @objc private func allCardsRemoved() {
        if CardsStore.shared.cards.isEmpty {
            showEmptyCardsStoreAlert()
        } else {
            showDeletingAllCardsAlert()
        }
    }
}

@available(iOS 13.0, *)
extension FeedViewController: SetupScreen {
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
