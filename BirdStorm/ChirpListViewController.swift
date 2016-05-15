//
//  ViewController.swift
//  BirdStorm
//
//  Created by Akhil Acharya  on 5/13/16.
//  Copyright © 2016 akhilcacharya.me. All rights reserved.
//

import CoreData
import UIKit

class ChirpListViewController: UITableViewController, NSFetchedResultsControllerDelegate, UIViewControllerPreviewingDelegate {
    
    
    
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let chipRequest = NSFetchRequest(entityName: "ChirpEntry")
        let dateSort = NSSortDescriptor(key: "date", ascending: true)
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = app.managedObjectContext
        chipRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: chipRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        doFetch()
        if(isForceTouchAvailable()){
            registerForPreviewingWithDelegate(self, sourceView: tableView)
        }
    }

    func doFetch(){
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error loading")
        }
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        doFetch()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Segue to the VC
        self.performSegueWithIdentifier("toEditorWithChirp", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toEditorWithChirp"){
            let path = self.tableView.indexPathForSelectedRow
            let selectedChirp = fetchedResultsController.objectAtIndexPath(path!) as! ChirpEntry
            let destVC = segue.destinationViewController as! EditViewController
            destVC.currentChirp = selectedChirp
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section]
            return currentSection.numberOfObjects
        }
        return 0
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func deleteListElement(action: UITableViewRowAction, index: NSIndexPath){
        print("Delete button tapped")
        
        let chirp = fetchedResultsController.objectAtIndexPath(index) as! ChirpEntry
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = app.managedObjectContext
        managedContext.deleteObject(chirp)
       

        do {
            try managedContext.save()
        }catch {
            print("Error saving")
        }
        
        doFetch()        
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch(type){
         
        case NSFetchedResultsChangeType.Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            break;
        default: break;
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let favorite = UITableViewRowAction(style: .Normal, title: "Share") { action, index in
            print("Share button tapped")
        }
        
        favorite.backgroundColor = UIColor.blueColor()
        
        let delete = UITableViewRowAction(style: .Destructive, title: "Delete", handler: deleteListElement)
        
        return [delete, favorite]
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        var cell = tableView.dequeueReusableCellWithIdentifier("chirpCell") as? ChirpCell
        
        if cell == nil {
            cell = ChirpCell()
        }
        
        let chirp = fetchedResultsController.objectAtIndexPath(indexPath) as! ChirpEntry
        
        cell!.setViews(chirp)
    

        return cell!
    }
    

    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath = tableView.indexPathForRowAtPoint(location){
            let chirp = fetchedResultsController.objectAtIndexPath(indexPath) as! ChirpEntry
            let previewController = storyboard?.instantiateViewControllerWithIdentifier("PreviewViewController") as! PreviewViewController
            previewController.chirp = chirp
            return previewController
        }
        return nil
    }
    
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
     //   navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
    
    
    func isForceTouchAvailable() -> Bool {
        var isAvailable = false
        
        if(self.traitCollection.respondsToSelector(Selector("forceTouchCapability"))){
            isAvailable = self.traitCollection.forceTouchCapability == UIForceTouchCapability.Available
        }

        return isAvailable
    }
    
    
    
}

