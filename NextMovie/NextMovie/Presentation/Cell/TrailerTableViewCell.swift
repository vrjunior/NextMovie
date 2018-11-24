//
//  TrailerTableViewCell.swift
//  NextMovie
//
//  Created by Valmir Junior on 24/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit
import Kingfisher

class TrailerTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    public weak var playerDelegate: Playable?
    private var movie: ItunesMovie?
    
    // MARK: Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Methods
    func prepare(with movie: ItunesMovie) {
        
        self.movie = movie
        
        if let imagePath = movie.artworkUrl100, let url = URL(string: imagePath) {
            self.coverImageView.kf.setImage(with: url)
        }
        self.titleLabel.text = movie.trackName
    }
    
    @IBAction func playTrailer(_ sender: Any) {
        
        guard let trailerPath = self.movie?.previewUrl else { return }
        guard let trailerUrl = URL(string: trailerPath) else { return }
        self.playerDelegate?.playVideo(with: trailerUrl)
    }
}
