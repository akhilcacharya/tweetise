//
//  PreviewViewController.swift
//  ChirpStorm
//
//  Created by Akhil Acharya  on 5/15/16.
//  Copyright © 2016 akhilcacharya.me. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var dateView: UILabel!
    @IBOutlet weak var chirpView: UIWebView!
    
    
    var chirp:ChirpEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        titleView.text = chirp.title!
        dateView.text = chirp.getFormattedDate()
        chirpView.loadHTMLString(chirp.text!, baseURL: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
