//
//  FeedTableViewCell.swift
//  Cards App
//
//  Created by Arthur Raff on 21.07.2021.
//

import UIKit

final class FeedTableViewCell: UITableViewCell {
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
        
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension FeedTableViewCell {
    func setupCell() {
        setupLayout()
        setupContent()
    }
    
    func setupLayout() {
        contentView.add(subviews: [cardPreview,
                                   cardTitle,
                                   cardDescription])
        
        cardPreview.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.width.equalTo(cardPreview.snp.height)
            $0.centerY.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        cardTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(cardPreview.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        cardDescription.snp.makeConstraints {
            $0.top.equalTo(cardTitle.snp.bottom).offset(8)
            $0.leading.equalTo(cardPreview.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func setupContent() {
        backgroundColor = UIColor.appColor(.accentBackgroundColor)
    }
}

extension FeedTableViewCell {
    func configure(card: Card) {
        cardTitle.text = card.title
        cardDescription.text = card.description
        cardPreview.image = UIImage(data: card.preview)
    }
}
