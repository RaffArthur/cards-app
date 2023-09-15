//
//  CardView.swift
//  Cards App
//
//  Created by Arthur Raff on 20.08.2023.
//

import UIKit

final class CardView: UIView {
    weak var delegate: CardViewDelegate?
    
    var userTitle: String? { return cardTitle.text }
    var userDescription: String? { return cardDescription.text}
    var userImage: UIImageView? { return cardPreview }
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isUserInteractionEnabled = true
        sv.showsVerticalScrollIndicator = false
        sv.bounces = true
        sv.backgroundColor = UIColor.appColor(.accentBackgroundColor)
        
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appColor(.accentBackgroundColor)
        
        return view
    }()
    
    private lazy var cardPreview: UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "preview_image")
        iv.backgroundColor = UIColor.appColor(.secondBackgroundColor)
        iv.largeContentImageInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        iv.tintColor = .white
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(imageChangePreviewTapped))
        iv.addGestureRecognizer(tapGestureRecognizer)
        
        return iv
    }()
    
    private lazy var cardTitle: UITextField = {
        let tf = UITextField()
        tf.isUserInteractionEnabled = true
        tf.textColor = UIColor.appColor(.accentFontColor)
        tf.placeholder = "Введите заголовок..."
        tf.font = .systemFont(ofSize: 24, weight: .bold)
        tf.textAlignment = .center
        tf.becomeFirstResponder()
        
        return tf
    }()
    
    private lazy var cardDescriptionName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .heavy)
        label.textColor = UIColor.appColor(.secondFontColor)
        label.text = "Введите описание:".uppercased()
        
        return label
    }()
    
    private lazy var cardDescription: UITextView = {
        let tv = UITextView()
        tv.isUserInteractionEnabled = true
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

private extension CardView {
    func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    func setupContent() {
        backgroundColor = UIColor.appColor(.accentBackgroundColor)
    }

    func setupLayout() {
        add(subview: scrollView)
        
        scrollView.add(subview: contentView)
        
        contentView.add(subviews: [cardPreview,
                                   cardTitle,
                                   cardDescriptionName,
                                   cardDescription])
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView.snp.width)
            $0.edges.equalTo(scrollView)
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
        
        cardDescriptionName.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(cardTitle.snp.bottom).offset(8)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        cardDescription.snp.makeConstraints {
            $0.height.equalToSuperview().dividedBy(2)
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.top.equalTo(cardDescriptionName.snp.bottom).offset(8)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
}

private extension CardView {
    @objc func imageChangePreviewTapped() {
        delegate?.imageChangePreviewTapped()
    }
}
