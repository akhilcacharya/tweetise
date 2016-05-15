//
//  Chirp+CoreDataProperties.swift
//  
//
//  Created by Akhil Acharya  on 5/14/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Chirp {

    @NSManaged var date: NSDate?
    @NSManaged var text: String?
    @NSManaged var title: String?

}
