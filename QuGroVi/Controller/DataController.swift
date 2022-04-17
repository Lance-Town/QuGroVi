//
//  DataController.swift
//  QuGroVi
//
//  Created by Lance Townsend on 4/3/22.
//

import CoreData
import UIKit

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "QuGroVi")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
