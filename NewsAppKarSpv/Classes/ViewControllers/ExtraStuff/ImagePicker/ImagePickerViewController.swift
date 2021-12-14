//
//  ImagePickerViewController.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-06-01.
//

import UIKit

class ImagePickerViewController: UIViewController, ImagePickerPresenterDelegate {
    
    // MARK: - Declarations
    @IBOutlet private weak var chooseImageButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    var imagePicker: ImagePickerPresenterInterface?
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = R.string.localizable.imagePicker()
        
        chooseImageButton.setupRoundCorners()
        imagePicker = ImagePickerPresenter(presentingController: self, delegate: self)
    }
    
    // MARK: - UI Actions
    @IBAction func didPressTakeImageButton(_ sender: UIButton) {
        imagePicker?.presentSourceOptions()
    }
    
    // MARK: - ImagePickerPresenterDelegate
    func imagePickerPresenterDidSelect(image: UIImage?) {
        imageView.image = image
    }
}
