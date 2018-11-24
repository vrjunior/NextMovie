//
//  SelectTrailerViewController.swift
//  NextMovie
//
//  Created by Valmir Junior on 24/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

// swiftlint:disable multiple_closures_with_trailing_closure
import UIKit
import AVKit

protocol Playable: class {
    func playVideo(with url: URL)
}

class SelectTrailerViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    public var movieTitle: String?
    public weak var delegate: TrailerDelegate?
    private let searchController = UISearchController(searchResultsController: nil)
    private var movies: [ItunesMovie] = []
    
    private var currentCountry: Country {
        let currentLocale = NSLocale.current as NSLocale
        let countryCode = currentLocale.object(forKey: NSLocale.Key.countryCode) as? String
        if let countryCode = countryCode, let country = Country(rawValue: countryCode) {
            return country
        }
        
        return .usa
    }
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        self.searchController.searchBar.delegate = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search for trailers"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        self.searchController.hidesNavigationBarDuringPresentation = true
        self.hideKeyboardWhenTappedAround()
        
        // Setup TableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        if let movieTitle = self.movieTitle, !movieTitle.isEmpty {
            self.searchController.searchBar.text = movieTitle
            self.searchBarSearchButtonClicked(self.searchController.searchBar)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchController.searchBar.becomeFirstResponder()
    }
    
}

// MARK: - Playable Protocol Implementation
extension SelectTrailerViewController: Playable {
    
    func playVideo(with url: URL) {
        
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
}

// MARK: - UISearchResultsUpdating Protocol Implementation
extension SelectTrailerViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) { }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else { return }
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        MovieItunesServices.getMovieInfo(term: searchTerm, country: self.currentCountry,
                                         onSuccess: { [weak self] (movies) in
            self?.activityIndicator.stopAnimating()
            self?.movies = movies
            self?.tableView.reloadData()
        }) { [weak self] (error) in
            self?.activityIndicator.stopAnimating()
            print(error)
        }
    }
}

// MARK: - UITableViewDataSource Protocol Implementation
extension SelectTrailerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let moviesCount = self.movies.count
        
        return moviesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let trailerCell = cell as? TrailerTableViewCell else { return cell }
        
        let currentMovie = self.movies[indexPath.row]
        trailerCell.prepare(with: currentMovie)
        trailerCell.playerDelegate = self
        
        return trailerCell
    }
}

extension SelectTrailerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentMovie = self.movies[indexPath.row]
        guard let trailerPath = currentMovie.previewUrl else { return }
        self.delegate?.select(trailerPath: trailerPath)
        self.navigationController?.popViewController(animated: true)
    }
}
