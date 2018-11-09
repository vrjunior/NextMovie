//
//  ViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 06/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

protocol MovieDelegate: class {
    func add(_ movie: Movie)
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
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addMovieViewController = segue.destination as? AddMovieViewController {
            addMovieViewController.movieDelegate = self
            return
        }
        
        if let movieDetailsViewController = segue.destination as? MovieDetailsViewController {
            
            guard let selectedMovie = sender as? Movie else { return }
            movieDetailsViewController.movie = selectedMovie
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
extension MoviesListViewController: MovieDelegate {
    
    func add(_ movie: Movie) {
        self.movies.append(movie)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let movieCell = cell as? MovieTableViewCell else {
            return cell
        }
        
        let currentMovie = self.movies[indexPath.row]
        movieCell.prepare(with: currentMovie)
        
        return movieCell
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
        }
    }
}

// MARK: - TableViewDelegate
extension MoviesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedMovie = self.movies[indexPath.row]
        self.performSegue(withIdentifier: self.movieDetailsSegue, sender: selectedMovie)
    }
}
