//
//  CardViewImagePickerControllerDelegate.swift
//  Cards App
//
//  Created by Arthur Raff on 28.07.2021.
//

import UIKit
import Photos

@available(iOS 13.0, *)
extension CardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func checkPermissions() {
            if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
                PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in ()
                })
            }

            if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            } else {
                PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
            }
        }
    
    private func requestAuthorizationHandler(status: PHAuthorizationStatus) {
            if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
                print("Доступ предоставлен для использования библиотеки фотографий")
            } else {
                print("Разрешение от юзера не получено")
            }
        }
    
    func showImagePickerControllerActionSheet() {
        let photoLibraryAction = UIAlertAction(title: "Открыть фотогалерею", style: .default) { [weak self] _ in
            DispatchQueue.main.async(qos: .userInitiated) {
                guard let self = self else { return }
                
                self.showImagePickerController(sourceType: .photoLibrary)
            }
        }
        let cameraAction = UIAlertAction(title: "Сделать снимок", style: .default) { [weak self] _ in
            DispatchQueue.main.async(qos: .userInitiated) {
                guard let self = self else { return }

                self.showImagePickerController(sourceType: .camera)
            }
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
        
        let alertController = UIAlertController(title: "Выберите изображение", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        imagePickerController.modalPresentationStyle = .fullScreen
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            cardPreview.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            cardPreview.image = originalImage
        }
        
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }

            self.cardTitle.becomeFirstResponder()
            self.addKeyboardObserver()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }

            self.cardTitle.becomeFirstResponder()
            self.addKeyboardObserver()
        }
    }
}
