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

    lazy var managedContext: NSManagedObjectContext = {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = app.managedObjectContext
        return managedContext
    }()
        
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let chipRequest = NSFetchRequest(entityName: "ChirpEntry")
        let dateSort = NSSortDescriptor(key: "date", ascending: true)
        chipRequest.sortDescriptors = [dateSort]
        let controller = NSFetchedResultsController(fetchRequest: chipRequest, managedObjectContext: self.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set the navigation bar tint
        
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.tintColor = secondaryColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]

        
        
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
    }
    
    override func viewWillAppear(animated: Bool) {
        doFetch()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch(type){
            case NSFetchedResultsChangeType.Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
                break;
            default: break;
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .Destructive, title: "Delete", handler: deleteListElement)
        
        return [delete]
    }
    
    func deleteListElement(action: UITableViewRowAction, index: NSIndexPath){
        let chirp = fetchedResultsController.objectAtIndexPath(index) as! ChirpEntry
        managedContext.deleteObject(chirp)
        do {
            try managedContext.save()
        }catch {
            print("Error saving")
        }
        doFetch()
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
        //No pop, only push. Come at me review board. 
    }
    
    
    func isForceTouchAvailable() -> Bool {
        var isAvailable = false
        if(self.traitCollection.respondsToSelector(Selector("forceTouchCapability"))){
            isAvailable = self.traitCollection.forceTouchCapability == UIForceTouchCapability.Available
        }
        return isAvailable
    }
}

