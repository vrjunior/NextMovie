//
//  AddMovieViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 07/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation
import UIKit

class AddMovieViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var categoriesTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var sinopseTextView: UITextView!
    @IBOutlet weak var addButton: UIButton!
    
    
    // MARK: - Properties
    public weak var movieDelegate: MovieDelegate?
    private var coverImage: UIImage?
    private var imagePicker = UIImagePickerController()
    
    
    // MARK: - Super Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleTextField.delegate = self
        self.durationTextField.delegate = self
        self.categoriesTextField.delegate = self
        self.categoriesTextField.delegate = self
        self.ratingTextField.delegate = self
        
        self.imagePicker.delegate = self
    }
    
    // MARK: - Methods
    private func tryCreateMovie() {
        
        guard let title = self.titleTextField.text, !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.titleTextField.shake()
            return
        }
        
        guard let duration = self.durationTextField.text, !duration.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.durationTextField.shake()
            return
        }
        
        guard let categories = self.categoriesTextField.text, !categories.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.categoriesTextField.shake()
            return
        }
        
        guard let ratingString = self.ratingTextField.text, let rating = Double(ratingString) else {
            self.ratingTextField.shake()
            return
        }
        
        guard let sinopse = self.sinopseTextView.text, !sinopse.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.sinopseTextView.shake()
            return
        }
        
        let newMovie = Movie(image: self.coverImage, title: title, duration: duration, sinopse: sinopse, rating: rating)
        
        self.movieDelegate?.add(newMovie)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - IBActions
    @IBAction func addCoverButtonPressed(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        actionSheet.addAction(UIAlertAction(title: "Escolher da galeria",
                                            style: .default,
                                            handler: chooseAProfilePhoto))
        
        actionSheet.addAction(UIAlertAction(title: "Cancelar",
                                            style: .cancel,
                                            handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        self.tryCreateMovie()
    }
}

// MARK: -
extension AddMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            self.coverImage = pickedImage
            self.coverImageView.image = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func chooseAProfilePhoto(alert: UIAlertAction!) {
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - TextFieldDelegate
extension AddMovieViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case self.titleTextField:
            self.durationTextField.becomeFirstResponder()
        case self.durationTextField:
            self.categoriesTextField.becomeFirstResponder()
        case self.categoriesTextField:
            self.ratingTextField.becomeFirstResponder()
        case self.ratingTextField:
            self.sinopseTextView.becomeFirstResponder()
        default:
            self.tryCreateMovie()
        }
        
        return true
    }
}
