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
        tv.backgroundColor = .white
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
        bbi.image = UIImage(systemName: "trash")
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
        
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
        }
    }
    
    private func setupScreen() {
        setupContent()
        setupLayout()
    }
    
    private func setupContent() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "Список"
        navigationItem.leftBarButtonItem = removeAllCards
        navigationItem.rightBarButtonItem = addNewCard
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-8)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func toAddNewCardScreen() {
        let cardVC = CardViewController()
        
        navigationController?.pushViewController(cardVC, animated: true)
        
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
        }
    }
    
    @objc private func allCardsRemoved() {
//        let habitsStore = HabitsStore.shared
//        habitsStore.habits.removeAll()
//
//        collectionView.reloadData()
    }
}
