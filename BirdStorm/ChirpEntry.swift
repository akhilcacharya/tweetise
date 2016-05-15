//
//  ChirpEntry.swift
//  BirdStorm
//
//  Created by Akhil Acharya  on 5/14/16.
//  Copyright © 2016 akhilcacharya.me. All rights reserved.
//

import Foundation
import CoreData


class ChirpEntry: NSManagedObject {

    // Insert code here to add functionality to your managed object subclass
    func getFormattedDate() -> String {
        let format: NSDateFormatter = NSDateFormatter()
        format.setLocalizedDateFormatFromTemplate("MM/dd/yy")
        return format.stringFromDate(self.date!)
    }
    
    
    class func newInstance(title: String, context: NSManagedObjectContext) -> ChirpEntry {
        let chirp = NSEntityDescription.insertNewObjectForEntityForName("ChirpEntry", inManagedObjectContext: context) as! ChirpEntry
        
        chirp.date = NSDate()
        chirp.title = title
        chirp.text = ""
        
        return chirp
    }
    
    class func newInstance(context: NSManagedObjectContext) -> ChirpEntry {
        let chirp = NSEntityDescription.insertNewObjectForEntityForName("ChirpEntry", inManagedObjectContext: context) as! ChirpEntry
        chirp.date = NSDate()
        chirp.title = chirp.getFormattedDate()
        chirp.text = ""
        return chirp
    }
    
}
