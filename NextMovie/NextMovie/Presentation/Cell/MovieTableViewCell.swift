//
//  MovieTableViewCell.swift
//  NextMovie
//
//  Created by Valmir Junior on 08/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    // MARK: - Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        self.coverImageView.image = nil
        self.titleLabel.text = ""
        self.durationLabel.text = ""
        self.ratingLabel.text = ""
    }
    
    
    // MARK: - Methods
    func prepare(with movie: Movie) {
        
        self.coverImageView.image = movie.uiImage
        self.titleLabel.text = movie.title
        self.durationLabel.text = movie.duration
        
        self.ratingLabel.text = String(movie.rating)
    }
    
}
