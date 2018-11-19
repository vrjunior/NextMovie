//
//  MovieServices.swift
//  NextMovie
//
//  Created by Valmir Junior on 09/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation

class CategoryServices {
    

    class func list() -> [Category]? {
        
        let categoryDAO = CategoryCoreDataDAO()
        do {
            let categories = try categoryDAO.list()
            return categories
            
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    class func save(category: Category) {
        
        let categoryDAO = CategoryCoreDataDAO()
        
        do {
            try categoryDAO.save(category: category)
        } catch {
            print(error)
        }
    }
    
    class func update() {
        
        let categoryDAO = CategoryCoreDataDAO()
        
        do {
            try categoryDAO.update()
        } catch {
            print(error)
        }
    }
    
    class func delete(category: Category) {
        let categoryDAO = CategoryCoreDataDAO()
        
        do {
            try categoryDAO.delete(category: category)
        } catch {
            print(error)
        }
    }
}
