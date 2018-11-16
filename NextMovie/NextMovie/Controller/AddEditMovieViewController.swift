//
//  AddMovieViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 07/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation
import UIKit


protocol CategoryDelegate: class {
    func select(categories: [Category])
}

class AddEditMovieViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
    @IBOutlet weak var sinopseTextView: CustomTextView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var categoriesCollectionView: CategoriesCollectionView!
    @IBOutlet weak var selectCategoriesButton: UIButton!
    
    
    // MARK: - Properties
    public var movieToEdit: Movie?
    
    private var coverImage: UIImage?
    private var imagePicker = UIImagePickerController()
    private let timePicker = UIDatePicker()
    private let selectCategoriesSegue = "selectCategories"
    private var isDarkModeEnabled: Bool!
    
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleTextField.delegate = self
        self.durationTextField.delegate = self
        self.ratingTextField.delegate = self
        
        self.imagePicker.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.setupDurationPicker()
        
        if let movieToEdit = self.movieToEdit {
            self.navigationItem.title = "Editar filme"
            self.addButton.setTitle("Salvar", for: .normal)
            self.prepare(with: movieToEdit)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.isDarkModeEnabled = UserDefaultsManager.isDarkModeEnabled
        self.setupViewMode(darkMode: self.isDarkModeEnabled)
    }
    
    override func setupViewMode(darkMode: Bool) {
        super.setupViewMode(darkMode: darkMode)
        
        self.view.backgroundColor = darkMode ? .black : .white  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let categoriesViewController = segue.destination as? CategoriesSelectionViewController {
            categoriesViewController.categoryDelegate = self
            
            if let selectedCategories = self.movieToEdit?.allCategories {
                categoriesViewController.selectedCategories = selectedCategories
            }
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
        
        guard let ratingString = self.ratingTextField.text, let rating = Double(ratingString) else {
            self.ratingTextField.shake()
            return
        }
        
        guard let sinopse = self.sinopseTextView.text, !sinopse.trimmingCharacters(in: .whitespaces).isEmpty else {
            self.sinopseTextView.shake()
            return
        }
        
        var newMovie: Movie
        
        if movieToEdit != nil {
            newMovie = self.movieToEdit!
        } else {
            newMovie = Movie()
        }
        
        if let resizedImage = self.coverImage?.resize(to: 400) {
            let imageRepresentation = resizedImage.jpegData(compressionQuality: 0.7)
            newMovie.image = imageRepresentation
        }
        
        newMovie.title = title
        newMovie.duration = duration
        newMovie.rating = rating
        newMovie.sinopse = sinopse
        
        if let categories = self.categoriesCollectionView?.categories {
            
            if let oldCategories = newMovie.categories {
                newMovie.removeFromCategories(oldCategories)
            }
            
            newMovie.addToCategories(NSSet(array: categories))
        }
        
        if movieToEdit == nil {
            MovieServices.save(movie: newMovie)
        } else {
            MovieServices.update()
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    private func prepare(with movie: Movie) {
        self.coverImage = movie.uiImage
        self.coverImageView.image = movie.uiImage
        self.titleTextField.text = movie.title
        self.durationTextField.text = movie.duration
        self.sinopseTextView.text = movie.sinopse
        
        if let categories = movie.allCategories {
            self.categoriesCollectionView.categories = categories
        }
        
        self.ratingTextField.text = String(movie.rating)
    }
    
    private func setupDurationPicker() {
        self.timePicker.datePickerMode = .countDownTimer
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Ok", style: .done, target: self, action: #selector(durationPickerDone(_:)))
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(durationPickerCancel(_:)))
        let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [cancelButton, flexibleButton, doneButton]
        
        self.durationTextField.inputView = self.timePicker
        self.durationTextField.inputAccessoryView = toolbar
    }
    
    
    @IBAction func selectCategories(_ sender: Any) {
        self.performSegue(withIdentifier: self.selectCategoriesSegue, sender: nil)
    }
    
    
    @objc func durationPickerDone(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH'h' mm'min'"
        self.durationTextField.text = formatter.string(from: self.timePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func durationPickerCancel(_ sender: Any) {
        self.view.endEditing(true)
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
extension AddEditMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
extension AddEditMovieViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case self.titleTextField:
            self.durationTextField.becomeFirstResponder()
        case self.durationTextField:
            self.ratingTextField.becomeFirstResponder()
        case self.ratingTextField:
            self.sinopseTextView.becomeFirstResponder()
        default:
            self.tryCreateEditMovie()
        }
        
        return true
    }
}

// MARK: - CategoriesDelegate
extension AddEditMovieViewController: CategoryDelegate {
    
    func select(categories: [Category]) {
        self.categoriesCollectionView.categories = categories
    }
}

