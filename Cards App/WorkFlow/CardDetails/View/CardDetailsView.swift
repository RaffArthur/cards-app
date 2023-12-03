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
        backgroundColor = .white
    }
    
    func setupLayout() {
        add(subview: scrollView)
        
        scrollView.add(subview: contentView)
        
        contentView.add(subviews: [cardPreview,
                                   cardTitle,
                                   cardDescription])
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView.snp.width)
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.equalTo(scrollView.snp.leading)
            $0.trailing.equalTo(scrollView.snp.trailing)
            $0.bottom.equalTo(scrollView.snp.bottom)
        }
        
        cardPreview.snp.makeConstraints {
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.height.equalTo(200)
            $0.width.equalTo(cardPreview.snp.height)
            $0.top.equalTo(contentView.snp.top).offset(16)
        }
        
        cardTitle.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.top.equalTo(cardPreview.snp.bottom).offset(8)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)

        }
        
        cardDescription.snp.makeConstraints {
            $0.height.equalToSuperview().dividedBy(2)
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.top.equalTo(cardTitle.snp.bottom).offset(8)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-16)
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
