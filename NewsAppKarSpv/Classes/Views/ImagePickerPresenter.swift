//
//  ImagePickerPresenter.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-06-01.
//

import UIKit

protocol ImagePickerPresenterInterface {
    func presentSourceOptions()
}

protocol ImagePickerPresenterDelegate: AnyObject {
    func imagePickerPresenterDidSelect(image: UIImage?)
}

class ImagePickerPresenter: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImagePickerPresenterInterface {
    
    // MARK: - Declarations
    private let imagePickerController: UIImagePickerController = UIImagePickerController()
    private var presentingController: UIViewController?
    private weak var delegate: ImagePickerPresenterDelegate?
    
    // MARK: - Methods
    init(presentingController: UIViewController, delegate: ImagePickerPresenterDelegate) {
        super.init()
        
        self.presentingController = presentingController
        self.delegate = delegate
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
    }
    
    func presentSourceOptions() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            guard let action: UIAlertAction = action(for: .photoLibrary, title: R.string.localizable.photoLibrary()) else {
                return
            }
            alertController.addAction(action)
            
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            guard let action: UIAlertAction = action(for: .camera, title: R.string.localizable.takePhoto()) else {
                return
            }
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .cancel, handler: nil))
        presentingController?.present(alertController, animated: true)
    }
    
    // MARK: - Helpers
    func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        return UIAlertAction(title: title, style: .default, handler: { [weak self] (_: UIAlertAction) in
            guard let self = self else { return }
            self.imagePickerController.sourceType = type
            self.presentingController?.present(self.imagePickerController, animated: true)
        })
    }
    
    // MARK: - ImagePickerPresenterDelegate
    func imagePickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        delegate?.imagePickerPresenterDidSelect(image: image)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController(picker, didSelect: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        return imagePickerController(picker, didSelect: info[.editedImage] as? UIImage)
    }
}
