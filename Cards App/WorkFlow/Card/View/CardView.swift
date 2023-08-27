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
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.edges.equalTo(scrollView)
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
        
        cardDescriptionName.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(cardTitle.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        cardDescription.snp.makeConstraints { make in
            make.height.equalToSuperview().dividedBy(2)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(cardDescriptionName.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
}

private extension CardView {
    @objc func imageChangePreviewTapped() {
        delegate?.imageChangePreviewTapped()
    }
}
