//
//  ViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 06/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

protocol MovieCreateDelegate: class {
    func add(_ movie: Movie)
}

protocol MovieEditDelegate: class {
    func replace(at index: Int, newMovie: Movie)
}

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
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        if let movies = MovieServices.list() {
            self.movies = movies
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isDarkModeEnabled = UserDefaultsManager.isDarkModeEnabled
        self.setupViewMode(darkMode: self.isDarkModeEnabled)
    }
    
    override func setupViewMode(darkMode: Bool) {
        super.setupViewMode(darkMode: darkMode)
        
        self.view.backgroundColor = darkMode ? .black : .white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addMovieViewController = segue.destination as? AddMovieViewController {
            addMovieViewController.movieDelegate = self
            return
        }
        
        if let movieDetailsViewController = segue.destination as? MovieDetailsViewController {
            
            guard let tuple = sender as? (movie: Movie, index: Int) else { return }
            movieDetailsViewController.movie = tuple.movie
            movieDetailsViewController.movieIndex = tuple.index
            movieDetailsViewController.movieEditDelegate = self
            return
        }
    }
    
    // MARK: - Methods
    
    
    
    // MARK: - IBActions
    @IBAction func addMovieBarButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: self.addMovieSegue, sender: nil)
    }
}

// MARK: - MovieDelegate
extension MoviesListViewController: MovieCreateDelegate {
    
    func add(_ movie: Movie) {
        self.movies.append(movie)
        self.tableView.reloadData()
    }
}

// MARK: - MovieEditDelegate
extension MoviesListViewController: MovieEditDelegate {
    func replace(at index: Int, newMovie: Movie) {
        self.movies[index] = newMovie
        self.tableView.reloadData()
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
        
        if currentMovie.itemType == .list {
            let cell = tableView.dequeueReusableCell(withIdentifier: "releaseCell", for: indexPath)
            
            guard let releaseCell = cell as? ReleaseTableViewCell else { return cell }
            guard let items = currentMovie.items else { return cell }
            
            releaseCell.prepare(with: items)
            
            return releaseCell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            guard let movieCell = cell as? MovieTableViewCell else { return cell }
            
            
            movieCell.prepare(with: currentMovie)
            
            return movieCell
        }
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
            self.movies.remove(at: indexPath.row)
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
