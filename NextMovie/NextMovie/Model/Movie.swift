//
//  Model.swift
//  NextMovie
//
//  Created by Valmir Junior on 07/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation
import UIKit.UIImage
import CoreData

enum ItemType: String /*, Codable */ {
    case movie
    case list
}

class Movie: NSManagedObject {
    
    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var duration: String?
    @NSManaged public var sinopse: String?
    @NSManaged public var rating: Double
    @NSManaged public var categories: NSSet?
    
    var allCategories: [Category]? {
        return self.categories?.allObjects as? [Category]
    }
    
    var uiImage: UIImage? {
        guard let imageData = self.image else { return nil }
        
        return UIImage(data: imageData as Data)
    }
    
    convenience init() {
        // get context
        let managedObjectContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        
        // create entity description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext)
        
        // call super
        self.init(entity: entityDescription!, insertInto: nil)
    }
    
        
    // MARK: - Codable Protocol
    
//    enum CodingKeys: String, CodingKey {
//        case image
//        case title
//        case duration
//        case sinopse = "description"
//        case rating
//        case categories
//        case itemType
//        case items
//    }
//
//    required convenience init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//
//        if let imagePath = try values.decodeIfPresent(String.self, forKey: .image) {
//            self.image = UIImage(named: imagePath)
//        }
//
//        self.title = try values.decodeIfPresent(String.self, forKey: .title)
//        self.duration = try values.decodeIfPresent(String.self, forKey: .duration)
//        self.sinopse = try values.decodeIfPresent(String.self, forKey: .sinopse)
//        self.rating = try values.decodeIfPresent(Double.self, forKey: .rating)
//        self.categories = try values.decodeIfPresent([String].self, forKey: .categories)
//        self.itemType = try values.decodeIfPresent(ItemType.self, forKey: .itemType)
//        self.items = try values.decodeIfPresent([Movie].self, forKey: .items)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encodeIfPresent(self.title, forKey: .title)
//        try container.encodeIfPresent(self.duration, forKey: .duration)
//        try container.encodeIfPresent(self.rating, forKey: .rating)
//        try container.encodeIfPresent(self.sinopse, forKey: .sinopse)
//        try container.encodeIfPresent(self.categories, forKey: .categories)
//        try container.encodeIfPresent(self.itemType, forKey: .itemType)
//        try container.encodeIfPresent(self.items, forKey: .items)
//    }
    
}

// MARK: Generated accessors for categories
extension Movie {
    
    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: Category)
    
    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: Category)
    
    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)
    
    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)
    
}
