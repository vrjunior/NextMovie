//
//  ReleaseCollectionViewCell.swift
//  NextMovie
//
//  Created by Valmir Junior on 09/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class ReleaseCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func prepare(with movie: Movie) {
       // self.coverImageView.image = movie.uiImage
        self.titleLabel.text = movie.title
    }
    
}
