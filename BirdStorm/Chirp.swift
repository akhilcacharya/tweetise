//
//  Chirp.swift
//  
//
//  Created by Akhil Acharya  on 5/14/16.
//
//

import Foundation
import CoreData

@objc(Chirp)
class Chirp: NSManagedObject {
    // Insert code here to add functionality to your managed object subclass
    func getFormattedDate() -> String {
        let format: NSDateFormatter = NSDateFormatter()
        format.setLocalizedDateFormatFromTemplate("MM/dd/yy")
        return format.stringFromDate(self.date)
    }
    
    
    class func newInstance(title: String, context: NSManagedObjectContext) -> Chirp {
        let chirp = NSEntityDescription.insertNewObjectForEntityForName("Chirp", inManagedObjectContext: context) as! Chirp
        
        chirp.date = NSDate()
        chirp.title = title
        chirp.text = ""
        
        return chirp
    }
    
    class func newInstance(context: NSManagedObjectContext) -> Chirp {
        let chirp = NSEntityDescription.insertNewObjectForEntityForName("ChirpItem", inManagedObjectContext: context) as! Chirp
        chirp.date = NSDate()
        chirp.title = chirp.getFormattedDate()
        chirp.text = ""
        return chirp
    }
}
