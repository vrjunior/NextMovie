//
//  Movie+CoreDataProperties.swift
//  NextMovie
//
//  Created by Valmir Junior on 15/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var duration: String?
    @NSManaged public var sinopse: String?
    @NSManaged public var rating: Double
    @NSManaged public var itemType: String?
    @NSManaged public var image: NSData?
    @NSManaged public var categories: NSSet?
    @NSManaged public var items: NSSet?

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

// MARK: Generated accessors for items
extension Movie {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Movie)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Movie)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
