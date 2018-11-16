//
//  MovieDAO.swift
//  NextMovie
//
//  Created by Valmir Junior on 15/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation
import CoreData

class CategoryCoreDataDAO {
    
    // MARK: - Properties
    let entityName = "Category"
    
    // MARK: - Methods
    func list() throws -> [Category] {
        
        let fetchRequest = NSFetchRequest<Category>(entityName: self.entityName)
        let sortDescriptor = NSSortDescriptor(keyPath: \Category.name, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let categories = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
            return categories
        } catch {
            throw Errors.coreDataError
        }
    }
    
    func save(category: Category) throws {
        
        do {
            CoreDataManager.shared.persistentContainer.viewContext.insert(category)
            try CoreDataManager.shared.persistentContainer.viewContext.save()
        } catch {
            throw Errors.coreDataError
        }
    }
    
    func update() throws {
        
        do {
            try CoreDataManager.shared.persistentContainer.viewContext.save()
        } catch {
            throw Errors.coreDataError
        }
    }
    
    func delete(category: Category) throws {
        do {
            CoreDataManager.shared.persistentContainer.viewContext.delete(category)
            try CoreDataManager.shared.persistentContainer.viewContext.save()
        } catch {
            throw Errors.coreDataError
        }
    }
}
