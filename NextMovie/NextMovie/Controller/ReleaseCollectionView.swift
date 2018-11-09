//
//  ReleaseCollectionView.swift
//  NextMovie
//
//  Created by Valmir Junior on 09/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import UIKit

class ReleaseCollectionView: UICollectionView, UICollectionViewDataSource {
    
    public var recomendations: [Movie] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recomendations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        guard let recomendationCell = cell as? ReleaseCollectionViewCell else {
            return cell
        }
        
        let currentMovie = self.recomendations[indexPath.row]
        recomendationCell.prepare(with: currentMovie)
        
        return recomendationCell
    }
    
}
