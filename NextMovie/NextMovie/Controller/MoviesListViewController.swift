//
//  ViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 06/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addMovieBarButton: UIBarButtonItem!
    @IBOutlet weak var moviesNotFoundView: MoviesNotFoundView!
    
    
    // MARK: - Properties
    private var movies: [Movie] = []
    private let addMovieSegue = "addMovie"
    private let movieDetailsSegue = "movieDetails"
    private var isDarkModeEnabled: Bool! {
        didSet {
            if oldValue != self.isDarkModeEnabled {
                self.tableView.reloadData()
            }
        }
    }
    private var refreshControl: UIRefreshControl!
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isDarkModeEnabled = UserDefaultsManager.isDarkModeEnabled
        self.setupViewMode(darkMode: self.isDarkModeEnabled)
        
        self.retrieveMovies()
    }
    
    override func setupViewMode(darkMode: Bool) {
        super.setupViewMode(darkMode: darkMode)
        
        self.view.backgroundColor = darkMode ? .black : .white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let movieDetailsViewController = segue.destination as? MovieDetailsViewController {
            
            guard let tuple = sender as? (movie: Movie, index: Int) else { return }
            movieDetailsViewController.movie = tuple.movie
            movieDetailsViewController.movieIndex = tuple.index
            return
        }
    }
    
    // MARK: - Methods
    @objc private func refresh(_ sender: UIRefreshControl) {
        self.refreshControl.endRefreshing()
        
        self.retrieveMovies()
    }
    
    private func retrieveMovies() {
        
        if let movies = MovieLocalServices.list() {
            self.movies = movies
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func addMovieBarButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: self.addMovieSegue, sender: nil)
    }
}


// MARK: - TableViewDataSource
extension MoviesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let moviesCount = self.movies.count
        self.tableView.backgroundView = moviesCount <= 0 ? self.moviesNotFoundView : nil
        
        return moviesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentMovie = self.movies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let movieCell = cell as? MovieTableViewCell else { return cell }
        
        
        movieCell.prepare(with: currentMovie)
        
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let movieCell = cell as? MovieTableViewCell {
            movieCell.titleLabel.textColor = self.isDarkModeEnabled ? .white : .black
            movieCell.durationLabel.textColor = self.isDarkModeEnabled ? .lightGray : .darkGray
            movieCell.ratingLabel.textColor = self.isDarkModeEnabled ? .lightGray : .darkGray
            
            return
        }
        
        if let releaseCell = cell as? ReleaseTableViewCell {
            releaseCell.releaseFixedTitleLabel.textColor = self.isDarkModeEnabled ? .white : .black
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let movie = self.movies.remove(at: indexPath.row)
            MovieLocalServices.delete(movie: movie)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            return
        }
    }
}

// MARK: - TableViewDelegate
extension MoviesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedMovie = self.movies[indexPath.row]
        self.performSegue(withIdentifier: self.movieDetailsSegue, sender: (movie: selectedMovie,
                                                                           index: indexPath.row))
    }
}
