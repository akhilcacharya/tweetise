//
//  ImageUtilities.swift
//  Tweetise
//
//  Created by Akhil Acharya  on 5/15/16.
//  Copyright © 2016 akhilcacharya.me. All rights reserved.
//

import UIKit
import Foundation
import CoreImage

class ImageUtilities {
    class func getChirpImage(webView: UIWebView, chirp: ChirpEntry) -> NSData {
        UIGraphicsBeginImageContext(webView.bounds.size)
                
        webView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result:UIImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        // Create path.
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let filePath = "\(paths[0])/\(chirp.title).png"
        
        // Save image.
        UIImagePNGRepresentation(result)?.writeToFile(filePath, atomically: true)
        
        return UIImagePNGRepresentation(result)!
    }
}
