//
//  CardView.swift
//  FINCH Test
//
//  Created by Arthur Raff on 24.07.2021.
//

import UIKit

@available(iOS 13.0, *)
class CardView: UIView {
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isUserInteractionEnabled = true
        sv.showsVerticalScrollIndicator = false
        sv.bounces = true
        
        return sv
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    private lazy var cardPreview: UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .systemGray
        iv.image = UIImage(systemName: "photo")
        iv.tintColor = .white
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        
        return iv
    }()
    private lazy var cardTitle: UITextField = {
        let tf = UITextField()
        tf.isUserInteractionEnabled = true
        tf.placeholder = "Введите заголовок..."
        tf.font = .systemFont(ofSize: 18, weight: .bold)
        tf.textAlignment = .center
        tf.clearButtonMode = .whileEditing
        
        return tf
    }()
    private lazy var cardDescriptionName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .heavy)
        label.textColor = .lightGray.withAlphaComponent(0.7)
        label.text = "Введите описание:".uppercased()
        
        return label
    }()
    private lazy var cardDescription: UITextView = {
        let tv = UITextView()
        tv.isUserInteractionEnabled = true
        tv.font = .systemFont(ofSize: 14, weight: .semibold)
        tv.layer.cornerRadius = 8
        tv.layer.borderWidth = 2
        tv.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        
        return tv
    }()
    
    override func layoutSubviews() {
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(cardPreview)
        contentView.addSubview(cardTitle)
        contentView.addSubview(cardDescriptionName)
        contentView.addSubview(cardDescription)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
        cardPreview.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.size.equalTo(CGSize(width: 180, height: 180))
            make.top.equalTo(contentView.snp.top).offset(16)
        }
        
        cardTitle.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(cardPreview.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)

        }
        
        cardDescriptionName.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(cardTitle.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        cardDescription.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(cardDescriptionName.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
}
