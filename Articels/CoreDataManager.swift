//
//  CoreDataManager.swift
//  Articels
//
//  Created by Abdullah Alnutayfi on 25/11/2021.
//

import Foundation
import CoreData
class CoreDataManager {
    let persistentContainer : NSPersistentContainer
    static let shared : CoreDataManager = CoreDataManager()
    
    init(){
        persistentContainer = NSPersistentContainer(name: "ArticlesDataModel")
        persistentContainer.loadPersistentStores { discription, error in
            if let error = error {
                fatalError("Unable to load data\(error.localizedDescription)")
            }
        }
    }
}

