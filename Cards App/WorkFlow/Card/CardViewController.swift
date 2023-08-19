//
//  CardViewController.swift
//  Cards App
//
//  Created by Arthur Raff on 24.07.2021.
//

import UIKit
import Photos

@available(iOS 13.0, *)
class CardViewController: UIViewController {
    private lazy var saveCardBarButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Добавить"
        bbi.style = .done
        bbi.tintColor = .systemGreen
        bbi.target = self
        bbi.action = #selector(saveCardButtonTapped)
        
        return bbi
    }()
    lazy var scrollView: UIScrollView = {
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
    lazy var cardPreview: UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "preview_image")
        iv.backgroundColor = UIColor.appColor(.secondBackgroundColor)
        iv.largeContentImageInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        iv.tintColor = .white
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        
        return iv
    }()
    lazy var cardTitle: UITextField = {
        let tf = UITextField()
        tf.isUserInteractionEnabled = true
        tf.textColor = UIColor.appColor(.accentFontColor)
        tf.placeholder = "Введите заголовок..."
        tf.font = .systemFont(ofSize: 24, weight: .bold)
        tf.textAlignment = .center
        tf.delegate = self
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        addKeyboardObserver()
        checkPermissions()
        addGestureRecogniserToImageView(handler: cardPreview)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeKeyboardObserver()
    }
}

@available(iOS 13.0, *)
extension CardViewController: ScreenSetup {
    private func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    private func setupContent() {        
        view.backgroundColor = UIColor.appColor(.accentBackgroundColor)
        
        navigationItem.title = "Новая карточка"
        navigationItem.rightBarButtonItem = saveCardBarButton
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(cardPreview)
        contentView.addSubview(cardTitle)
        contentView.addSubview(cardDescriptionName)
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

@available(iOS 13.0, *)
extension CardViewController: FuncionalitySetup {
    private func showEmptyFieldsAlert() {
        let alert = UIAlertController(title: navigationItem.title, message: "Заполните все поля", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func addGestureRecogniserToImageView(handler: UIImageView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(previewImageTapped))
        handler.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func saveCardButtonTapped() {
        guard let image = cardPreview.image else { return }
        guard let title = cardTitle.text else { return }
        guard let description = cardDescription.text else { return }
        guard let preview = image.jpegData(compressionQuality: 1) else { return }

        let newCard = Card(title: title, description: description, preview: preview)
                
        if title.isEmpty || description.isEmpty {
            showEmptyFieldsAlert()
        } else {
            CardsStore.shared.cards.insert(newCard, at: 0)

            guard let navigationController = navigationController else { return }
            navigationController.popToRootViewController(animated: true)
        }
    }
        
    @objc private func previewImageTapped() {
        UIView.animateKeyframes(withDuration: 0.1, delay: 0, options: [.autoreverse]) { [self] in
            cardPreview.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { [self] _ in
            cardPreview.transform = CGAffineTransform(scaleX: 1, y: 1)
        }

        DispatchQueue.main.async(qos: .userInitiated) { [self] in
            showImagePickerControllerActionSheet()
        }
    }
}
