//
//  CategoriesCollectionView.swift
//  NextMovie
//
//  Created by Valmir Junior on 09/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class CategoriesCollectionView: UICollectionView {
    
    var categories: [String] = [] {
        didSet{
            self.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
    }
}

extension CategoriesCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        guard let categoryCell = cell as? CategoryCollectionViewCell else {
            return cell
        }
        
        let currentCategory = self.categories[indexPath.row]
        categoryCell.prepare(with: currentCategory)
        
        return categoryCell
    }
    
}
