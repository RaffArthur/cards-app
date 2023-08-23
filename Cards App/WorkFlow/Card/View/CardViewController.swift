//
//  CardViewController.swift
//  Cards App
//
//  Created by Arthur Raff on 24.07.2021.
//

import UIKit
import Photos

class CardViewController: UIViewController {
    private lazy var cardView: CardView = {
        let cv = CardView()
        
        return cv
    }()
    
    private lazy var saveCardBarButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Добавить"
        bbi.style = .done
        bbi.tintColor = .systemGreen
        bbi.target = self
        bbi.action = #selector(saveCardButtonTapped)
        
        return bbi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.delegate = self
        
        setupScreen()
    }
}

extension CardViewController {
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
        view.add(subview: cardView)
        
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CardViewController {
    private func showEmptyFieldsAlert() {
        let alert = UIAlertController(title: navigationItem.title,
                                      message: "Заполните все поля",
                                      preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "ОК",
                                       style: .cancel,
                                       handler: nil)
        
        alert.add(action: doneAction)
        
        present(alert,
                animated: true,
                completion: nil)
    }
    
    @objc private func saveCardButtonTapped() {
        guard let image = cardView.userImage?.image,
              let title = cardView.userTitle,
              let description = cardView.userDescription,
              let preview = image.jpegData(compressionQuality: 1)
        else {
            return
        }

        let newCard = Card(title: title,
                           description: description,
                           preview: preview)

        if title.isEmpty || description.isEmpty {
            showEmptyFieldsAlert()
        } else {
            CardsStore.shared.cards.insert(newCard, at: 0)
            
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension CardViewController: CardViewDelegate {
    func imageChangePreviewTapped() {
        UIView.animateKeyframes(withDuration: 0.1, delay: 0, options: [.autoreverse]) { [self] in
            cardView.userImage?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { [self] _ in
            cardView.userImage?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }

        DispatchQueue.main.async(qos: .userInitiated) { [self] in
            showImagePickerControllerActionSheet()
        }
    }
}

extension CardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        imagePickerController.modalPresentationStyle = .popover
        
        present(imagePickerController,
                animated: true,
                completion: nil)
    }
    
    func showImagePickerControllerActionSheet() {
        let photoLibraryAction = UIAlertAction(title: "Открыть фотогалерею",
                                               style: .default) { [weak self] _ in
            DispatchQueue.main.async(qos: .userInitiated) {
                self?.showImagePickerController(sourceType: .photoLibrary)
            }
        }
        
        let cameraAction = UIAlertAction(title: "Сделать снимок",
                                         style: .default) { [weak self] _ in
            DispatchQueue.main.async(qos: .userInitiated) {
                self?.showImagePickerController(sourceType: .camera)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Отменить",
                                         style: .cancel)
        
        let alertController = UIAlertController(title: "Выберите изображение",
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        alertController.add(actions: [photoLibraryAction,
                                      cameraAction,
                                      cancelAction])
        
        present(alertController,
                animated: true,
                completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        cardView.userImage?.image = editedImage
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
