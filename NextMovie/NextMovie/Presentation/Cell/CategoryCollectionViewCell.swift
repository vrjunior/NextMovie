//
//  CategoryCollectionViewCell.swift
//  NextMovie
//
//  Created by Valmir Junior on 09/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    // MARK: - Super Method
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLayout()
    }
    
    // MARK: - Methods
    
    func setupLayout() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    }
    
    func prepare(with category: Category) {
        self.categoryLabel.text = category.name
    }
}
