//
//  FeedTableViewCell.swift
//  FINCH Test
//
//  Created by Arthur Raff on 21.07.2021.
//

import UIKit
import SnapKit

@available(iOS 13.0, *)
class FeedTableViewCell: UITableViewCell {
    private lazy var cardImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemIndigo
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        
        return iv
    }()
    private lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.text = "Моя карточка"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 2
        
        return label
    }()
    private lazy var cardDescription: UILabel = {
        let label = UILabel()
        label.text = "Pellentesque metus urna, molestie id lobortis nec, venenatis eget est. Vivamus consectetur neque sapien. Nullam erat risus, varius at rutrum at, dapibus ac lacus. Sed quis arcu eros, ac aliquam purus. Vivamus sed diam nibh"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 3
        
        return label
    }()
    
    private func setupLayout() {
        contentView.addSubview(cardImage)
        contentView.addSubview(cardTitle)
        contentView.addSubview(cardDescription)
        
        cardImage.snp.makeConstraints { make in
            make.width.equalTo(contentView.snp.height).offset(-32)
            make.height.equalTo(contentView.snp.height).offset(-32)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        cardTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.leading.equalTo(cardImage.snp.trailing).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
        
        cardDescription.snp.makeConstraints { make in
            make.top.equalTo(cardTitle.snp.bottom).offset(8)
            make.leading.equalTo(cardImage.snp.trailing).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
