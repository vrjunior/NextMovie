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
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var sinopseLabel: UILabel!
    
    
    // MARK: - Properties
    var movie: Movie!
    
    
    // MARK: - Super Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie = movie else {
            return
        }
        
        self.prepare(with: movie)
    }
    
    // MARK: - Methods
    func prepare(with movie: Movie) {
        
        self.coverImageView.image = movie.image
        self.titleLabel.text = movie.title
        self.durationLabel.text = movie.duration
        self.ratingLabel.text = String(movie.rating)
        self.sinopseLabel.text = movie.sinopse
    }
    
    
    // MARK: - IBActions
}
