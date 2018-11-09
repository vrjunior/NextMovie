//
//  MovieDetailsViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 09/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var categoriesCollectionView: CategoriesCollectionView!
    @IBOutlet weak var sinopseLabel: UILabel!
    
    
    // MARK: - Properties
    public var movie: Movie!
    public var movieIndex: Int!
    public weak var movieEditDelegate: MovieEditDelegate?
    
    private let addEditMovieSegue = "addEditMovie"
    
    
    // MARK: - Super Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie = movie else {
            return
        }
        
        self.prepare(with: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addEditMovieViewController = segue.destination as? AddMovieViewController {
            addEditMovieViewController.movieToEdit = self.movie
            addEditMovieViewController.movieIndex = self.movieIndex
            addEditMovieViewController.editorType = .edit
            addEditMovieViewController.movieEditDelegate = self
        }
    }
    
    // MARK: - Methods
    func prepare(with movie: Movie) {
        
        self.coverImageView.image = movie.image
        self.titleLabel.text = movie.title
        self.durationLabel.text = movie.duration
        self.sinopseLabel.text = movie.sinopse
        
        if let rating = movie.rating {
            self.ratingLabel.text = String(rating)
        }
        
        if let categories = movie.categories {
            self.categoriesCollectionView.categories = categories
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func editButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: self.addEditMovieSegue, sender: nil)
    }
}


// MARK: - MovieEditDelegate
extension MovieDetailsViewController: MovieEditDelegate {
    
    func replace(at index: Int, newMovie: Movie) {
        self.prepare(with: newMovie)
        self.movieEditDelegate?.replace(at: index, newMovie: newMovie)
    }
    
}
