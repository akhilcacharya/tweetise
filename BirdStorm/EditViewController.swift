//
//  EditViewController.swift
//  BirdStorm
//
//  Created by Akhil Acharya  on 5/13/16.
//  Copyright © 2016 akhilcacharya.me. All rights reserved.
//

import UIKit
import RichEditorView
import CoreData


class EditViewController: UIViewController {

    @IBOutlet weak var titleEditText: UITextField!
    @IBOutlet weak var editorView: RichEditorView!
    @IBOutlet weak var editorToolbar: RichEditorToolbar!

    var currentChirp: ChirpEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup editor
        //Use standard typeface and text color
        self.editorView.setFontSize(12)
        
        //Setup Toolbar
        self.editorToolbar.options =  getOptions()
    
        self.editorToolbar.editor = self.editorView
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = app.managedObjectContext
    
        
        if(self.currentChirp == nil){
            self.currentChirp = ChirpEntry.newInstance(managedContext)
            self.titleEditText.text = self.currentChirp.getFormattedDate()
        }else{
            self.editorView.setHTML(currentChirp.text!)
            self.titleEditText.text = currentChirp.title
        }
        
        //Set title
        self.title = "\(titleEditText.text!)"
        if self.title == "" {
            self.title = "(Add a Title)"
        }
    }

    override func viewWillDisappear(animated: Bool) {
        saveCurrentState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var shareAction: UIBarButtonItem!
    private func getOptions() -> [RichEditorOption]{
        return [
            RichEditorOptions.Redo,
            RichEditorOptions.Undo,
            RichEditorOptions.Bold,
            RichEditorOptions.Italic,
            RichEditorOptions.AlignLeft,
            RichEditorOptions.AlignRight,
            RichEditorOptions.UnorderedList,
            RichEditorOptions.OrderedList,
        ]
    }
    
    //Swap the ShareAction IBOutlet with the SaveAction IBOutlet
    @IBAction func shareAction(sender: AnyObject) {
        print("Share")
        
        saveCurrentState()
        
        titleEditText.endEditing(true)
        editorView.endEditing(true)
        
        ImageUtilities.getChirpImage(self.editorView.webView, chirp: self.currentChirp)
        print("Done")
    }

    @IBAction func onTitleChanged(sender: AnyObject) {
        self.title = "\(titleEditText.text!)"
        if self.title == "" {
            self.title = "(Add a Title)"
        }
        
        self.currentChirp.title = self.titleEditText.text
    }
    
    func saveCurrentState(){
        self.currentChirp.title = self.titleEditText.text!
        self.currentChirp.text = self.editorView.getHTML()
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = app.managedObjectContext
        
        do {
            try managedContext.save()
        } catch {
            print("Error saving")
        }
    }
}
