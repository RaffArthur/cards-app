//
//  FeedView.swift
//  Cards App
//
//  Created by Arthur Raff on 19.08.2023.
//

import UIKit

final class FeedView: UIView {
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
        tv.register(FeedTableViewCell.self,
                    forCellReuseIdentifier: String(describing: FeedTableViewCell.self))
        
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

private extension FeedView {
    func setupScreen() {
        setupLayout()
    }
    
    func setupLayout() {
        add(subviews: [contentView,
                       tableView])
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview {
                $0.safeAreaLayoutGuide
            }
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
}

extension FeedView {
    func reloadTableViewData() {
        tableView.reloadData()
    }
    
    func setupTableView(dataSource: UITableViewDataSource,
                        delegate: UITableViewDelegate) {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
}
