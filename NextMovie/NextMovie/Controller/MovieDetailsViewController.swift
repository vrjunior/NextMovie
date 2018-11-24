//
//  MovieDetailsViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 09/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit
import AVKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var categoriesCollectionView: CategoriesCollectionView!
    @IBOutlet weak var sinopseLabel: UILabel!
    @IBOutlet weak var sinopseFixedTitleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    
    // MARK: - Properties
    public var movie: Movie!
    public var movieIndex: Int!
    
    private let addEditMovieSegue = "addEditMovie"
    private let addReminderSegue = "addReminder"
    private var isDarkModeEnabled: Bool!
    private var trailerPlayer: AVPlayer?
    
    
    // MARK: - Super Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie = movie else {
            return
        }
        
        self.prepare(with: movie)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.isDarkModeEnabled = UserDefaultsManager.isDarkModeEnabled
        self.setupViewMode(darkMode: self.isDarkModeEnabled)
        
        if UserDefaultsManager.isAutoPlayEnabled {
            self.playTrailer()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.trailerPlayer?.pause()
    }
    
    override func setupViewMode(darkMode: Bool) {
        super.setupViewMode(darkMode: darkMode)
        
        self.view.backgroundColor = darkMode ? .black : .white
        self.titleLabel.textColor = darkMode ? .white : .black
        self.durationLabel.textColor = darkMode ? .lightGray : .darkGray
        self.ratingLabel.textColor = darkMode ? .lightGray : .darkGray
        self.sinopseLabel.textColor = darkMode ? .lightGray : .darkGray
        self.sinopseFixedTitleLabel.textColor = darkMode ? .white : .black
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addEditMovieViewController = segue.destination as? AddEditMovieViewController {
            addEditMovieViewController.movieToEdit = self.movie
            return
        }
        
        if let addReminderViewController = segue.destination as? AddReminderViewController {
            addReminderViewController.movie = self.movie
        }
    }
    
    // MARK: - Methods
    func prepare(with movie: Movie) {
        
        self.coverImageView.image = movie.uiImage
        self.titleLabel.text = movie.title
        self.durationLabel.text = movie.duration
        self.sinopseLabel.text = movie.sinopse
        self.ratingLabel.text = String(movie.rating)
        
        self.playButton.isHidden = movie.trailerUrlPath?.isEmpty ?? true
    
        
        if let categories = movie.allCategories {
            self.categoriesCollectionView.categories = categories
        }
    }
    
    func playTrailer() {
        guard let videoUrlPath = self.movie.trailerUrlPath else { return }
        let videoURL = URL(string: videoUrlPath)
        
        if trailerPlayer == nil {
            self.trailerPlayer = AVPlayer(url: videoURL! as URL)
            let playerController = AVPlayerViewController()
            playerController.player = trailerPlayer
            self.addChild(playerController)
            
            // Add your view Frame
            playerController.view.frame = self.coverImageView.frame
            
            // Add sub view in your view
            self.view.addSubview(playerController.view)
        }
        
        trailerPlayer?.play()
    }
    
    // MARK: - IBActions
    @IBAction func editButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: self.addEditMovieSegue, sender: nil)
    }
    
    @IBAction func createReminderButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: self.addReminderSegue, sender: nil)
    }
    
    @IBAction func playTraillerButtonPressed(_ sender: Any) {
        self.playTrailer()
    }
}
