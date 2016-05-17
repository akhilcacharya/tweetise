//
//  PreviewViewController.swift
//  ChirpStorm
//
//  Created by Akhil Acharya  on 5/15/16.
//  Copyright © 2016 akhilcacharya.me. All rights reserved.
//

import UIKit
import RichEditorView

class PreviewViewController: UIViewController {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var dateView: UILabel!
    @IBOutlet weak var chirpView: RichEditorView!

    var chirp:ChirpEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.text = chirp.title!
        dateView.text = chirp.getFormattedDate()
        chirpView.setHTML(chirp.text!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
