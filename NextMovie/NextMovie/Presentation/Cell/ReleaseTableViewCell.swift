//
//  ReleaseTableViewCell.swift
//  NextMovie
//
//  Created by Valmir Junior on 09/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class ReleaseTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: ReleaseCollectionView!
    @IBOutlet weak var releaseFixedTitleLabel: UILabel!
    
    
    // MARK: - Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Methods
    func prepare(with items: [Movie]) {
        self.collectionView.recomendations = items
    }
}
