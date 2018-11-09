//
//  AddMovieViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 07/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation
import UIKit

enum MovieEditorType {
    case edit
    case create
}

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
    public weak var movieDelegate: MovieCreateDelegate?
    
    public weak var movieEditDelegate: MovieEditDelegate?
    public var editorType: MovieEditorType = .create
    public var movieToEdit: Movie?
    public var movieIndex: Int?
    
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
        self.hideKeyboardWhenTappedAround()
        
        if self.editorType == .edit {
            guard let movieToEdit = self.movieToEdit else { return }
            self.navigationItem.title = "Editar filme"
            self.addButton.setTitle("Salvar", for: .normal)
            self.prepare(with: movieToEdit)
        }
    }
    
    // MARK: - Methods
    private func tryCreateEditMovie() {
        
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
        
        var newMovie = Movie()
        newMovie.image = self.coverImage
        newMovie.title = title
        newMovie.duration = duration
        newMovie.categories = categories.split(separator: ",").map { String($0) }
        newMovie.rating = rating
        newMovie.sinopse = sinopse
        
        if self.editorType == .create {
            self.movieDelegate?.add(newMovie)
        } else if self.editorType == .edit {
            
            guard let movieIndex = self.movieIndex else { return }
            self.movieEditDelegate?.replace(at: movieIndex, newMovie: newMovie)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func prepare(with movie: Movie) {
        self.coverImage = movie.image
        self.coverImageView.image = movie.image
        self.titleTextField.text = movie.title
        self.durationTextField.text = movie.duration
        self.sinopseTextView.text = movie.sinopse
        
        if var categories = movie.categories {
            let firstCategory = categories.removeFirst()
            self.categoriesTextField.text = categories.reduce(firstCategory, { $0 + ", " + $1  })
        }
        
        if let rating = movie.rating {
            self.ratingTextField.text = String(rating)
        }
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
        self.tryCreateEditMovie()
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
            self.tryCreateEditMovie()
        }
        
        return true
    }
}


