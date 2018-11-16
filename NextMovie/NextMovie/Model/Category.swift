//
//  Category.swift
//  NextMovie
//
//  Created by Valmir Junior on 15/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation
import CoreData

class Category: NSManagedObject {
    @NSManaged public var name: String?
    
    convenience init() {
        // get context
        let managedObjectContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        
        // create entity description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Category", in: managedObjectContext)
        
        // call super
        self.init(entity: entityDescription!, insertInto: nil)
    }
}
