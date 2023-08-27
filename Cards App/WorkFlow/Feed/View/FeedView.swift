//
//  FeedView.swift
//  Cards App
//
//  Created by Arthur Raff on 19.08.2023.
//

import UIKit

final class FeedView: UIView {
    weak var delegate: FeedViewDelegate?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedView: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath,
                              animated: true)
        
        delegate?.showFullCardDetailsScreenBy(index: indexPath.item)
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

        let card = CardsStore.shared.cards[indexPath.item]
        
        guard let cell = cell else {
            return UITableViewCell()
        }
        
        cell.configure(card: card)

        return cell
    }
}

extension FeedView: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let trashAction = UIContextualAction(style: .destructive,
                                             title: "Удалить") { [self] action, view, success in
            
            delegate?.removeCardBy(index: indexPath.item)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadRows(at: [indexPath], with: .fade)
            
            success(true)
        }
        
        return UISwipeActionsConfiguration(actions: [trashAction])
    }
}

private extension FeedView {
    func setupScreen() {
        setupLayout()
    }
    
    func setupLayout() {
        add(subviews: [contentView,
                       tableView])
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}

extension FeedView {
    func reloadTableViewData() {
        tableView.reloadData()
    }
}
