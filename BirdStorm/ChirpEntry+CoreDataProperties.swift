//
//  ChirpEntry+CoreDataProperties.swift
//  BirdStorm
//
//  Created by Akhil Acharya  on 5/14/16.
//  Copyright © 2016 akhilcacharya.me. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ChirpEntry {

    @NSManaged var date: NSDate?
    @NSManaged var text: String?
    @NSManaged var title: String?

}
