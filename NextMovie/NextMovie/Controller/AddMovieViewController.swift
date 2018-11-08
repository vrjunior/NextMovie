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
    
    
    // MARK: - Super Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    
    // MARK: - IBActions
    @IBAction func addCoverButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
    }
}
