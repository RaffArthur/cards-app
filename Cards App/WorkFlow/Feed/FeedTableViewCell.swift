//
//  FeedTableViewCell.swift
//  Cards App
//
//  Created by Arthur Raff on 21.07.2021.
//

import UIKit
import SnapKit

@available(iOS 13.0, *)
class FeedTableViewCell: UITableViewCell {
    public var card: Card? {
        didSet {
            guard let card = card  else { return }
            
            configure(card)
        }
    }
    private lazy var cardPreview: UIImageView = {
        let iv = UIImageView()
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        
        return iv
    }()
    private lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.appColor(.accentFontColor)
        label.textAlignment = .left
        label.sizeToFit()
        label.numberOfLines = 1
        
        return label
    }()
    private lazy var cardDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.appColor(.secondFontColor)
        label.textAlignment = .left
        label.sizeToFit()
        label.numberOfLines = 3
        
        return label
    }()
    
    private func configure(_ card: Card) {
        cardTitle.text = card.title
        cardDescription.text = card.description
        cardPreview.image = UIImage(data: card.preview)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

@available(iOS 13.0, *)
extension FeedTableViewCell: SetupScreen {
    private func setupCell() {
        setupLayout()
        setupContent()
    }
    
    private func setupLayout() {
        contentView.addSubview(cardPreview)
        contentView.addSubview(cardTitle)
        contentView.addSubview(cardDescription)
        
        cardPreview.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(cardPreview.snp.height)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        cardTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(cardPreview.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        cardDescription.snp.makeConstraints { make in
            make.top.equalTo(cardTitle.snp.bottom).offset(8)
            make.leading.equalTo(cardPreview.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func setupContent() {
        backgroundColor = UIColor.appColor(.accentBackgroundColor)
    }
}
