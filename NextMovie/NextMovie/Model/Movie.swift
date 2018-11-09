//
//  Model.swift
//  NextMovie
//
//  Created by Valmir Junior on 07/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation
import UIKit.UIImage

enum ItemType: String, Codable {
    case movie
    case list
}

struct Movie {
    var image: UIImage?
    var title: String?
    var duration: String?
    var sinopse: String?
    var rating: Double?
    var categories: [String]?
    var itemType: ItemType?
    var items: [Movie]?
    
    init() {
        
    }
}

extension Movie: Codable {
    
    enum CodingKeys: String, CodingKey {
        case image
        case title
        case duration
        case sinopse = "description"
        case rating
        case categories
        case itemType
        case items
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let imagePath = try values.decodeIfPresent(String.self, forKey: .image) {
            self.image = UIImage(named: imagePath)
        }
        
        self.title = try values.decodeIfPresent(String.self, forKey: .title)
        self.duration = try values.decodeIfPresent(String.self, forKey: .duration)
        self.sinopse = try values.decodeIfPresent(String.self, forKey: .sinopse)
        self.rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        self.categories = try values.decodeIfPresent([String].self, forKey: .categories)
        self.itemType = try values.decodeIfPresent(ItemType.self, forKey: .itemType)
        self.items = try values.decodeIfPresent([Movie].self, forKey: .items)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.duration, forKey: .duration)
        try container.encodeIfPresent(self.rating, forKey: .rating)
        try container.encodeIfPresent(self.sinopse, forKey: .sinopse)
        try container.encodeIfPresent(self.categories, forKey: .categories)
        try container.encodeIfPresent(self.itemType, forKey: .itemType)
        try container.encodeIfPresent(self.items, forKey: .items)
    }
}
