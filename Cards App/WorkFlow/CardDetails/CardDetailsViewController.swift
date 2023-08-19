//
//  CardDetailsViewController.swift
//  Cards App
//
//  Created by Arthur Raff on 29.07.2021.
//

import UIKit

class CardDetailsViewController: UIViewController {
    public var card: Card? {
        didSet {
            guard let card = card  else { return }
            
            configure(card)
        }
    }
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    private func configure(_ card: Card) {
        cardTitle.text = card.title
        cardDescription.text = card.description
        cardPreview.image = UIImage(data: card.preview)
        title = card.title
    }
}

extension CardDetailsViewController: ScreenSetup {
    private func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    private func setupContent() {
        view.backgroundColor = UIColor.appColor(.accentBackgroundColor)
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(cardPreview)
        contentView.addSubview(cardTitle)
        contentView.addSubview(cardDescription)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
