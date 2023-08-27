//
//  CardDetailsView.swift
//  Cards App
//
//  Created by Arthur Raff on 23.08.2023.
//

import UIKit

final class CardDetailsView: UIView {
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
        iv.isUserInteractionEnabled = false
        iv.backgroundColor = .systemGray
        iv.tintColor = .white
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
    private lazy var cardTitle: UITextField = {
        let tf = UITextField()
        tf.isUserInteractionEnabled = false
        tf.textColor = UIColor.appColor(.accentFontColor)
        tf.font = .systemFont(ofSize: 24, weight: .bold)
        tf.textAlignment = .center
        
        return tf
    }()
    
    private lazy var cardDescription: UITextView = {
        let tv = UITextView()
        tv.isUserInteractionEnabled = true
        tv.isEditable = false
        tv.isScrollEnabled = true
        tv.font = .systemFont(ofSize: 16, weight: .semibold)
        tv.textColor = UIColor.appColor(.accentFontColor)
        tv.backgroundColor = UIColor.appColor(.secondBackgroundColor)
        tv.layer.cornerRadius = 8
        
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
        
        setupScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CardDetailsView {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        
    }
    
    func setupLayout() {
        add(subview: scrollView)
        
        scrollView.add(subview: contentView)
        
        contentView.add(subviews: [cardPreview,
                                   cardTitle,
                                   cardDescription])
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
            make.height.equalTo(200)
            make.width.equalTo(cardPreview.snp.height)
            make.top.equalTo(contentView.snp.top).offset(16)
        }
        
        cardTitle.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(cardPreview.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)

        }
        
        cardDescription.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(2)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(cardTitle.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
}

extension CardDetailsView {
    func prepareCard(card: Card) {
        cardTitle.text = card.title
        cardDescription.text = card.description
        cardPreview.image = UIImage(data: card.preview)
    }
}
