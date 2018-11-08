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
    
    
    // MARK: - Properties
    private var movies: [Movie] = []
    private let addMovieSegue = "addMovie"
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return self.movies.count
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
}
