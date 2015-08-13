//
//  TripViewController.swift
//  knapsack
//
//  Created by manatee on 7/30/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class TripViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var realm = Realm()
  var allTrips = Realm().objects(Trip)
  var presentedTrips = Realm().objects(Trip).filter("archived = false").sorted("startDate")
  var selectedTrip = Trip()
  var showActiveTrips = true
  

  
  @IBOutlet weak var itemTable: UITableView!
  @IBOutlet weak var addButtonView: UIView!
  
  @IBAction func addButton(sender: UIButton) {
  }
  
  @IBOutlet weak var toggleTripType: UIBarButtonItem!
  @IBAction func toggleTripType(sender: UIBarButtonItem) {
    if showActiveTrips == true {
      showActiveTrips = false
      presentedTrips = Realm().objects(Trip).filter("archived = true")
      self.title = "Archives"
      var archiveImage: UIImage = UIImage(named: "archiveFlag.png")!
//      toggleTripType.setBackgroundImage(archiveImage, forState: .Normal, barMetrics: .Default)
    } else {
      showActiveTrips = true
      presentedTrips = Realm().objects(Trip).filter("archived = false")
      self.title = "Active Trips"
      var archiveImage: UIImage = UIImage(named: "archiveFlag.png")!
//      toggleTripType.setBackgroundImage(archiveImage, forState: .Normal, barMetrics: .Default)
    }
    itemTable.reloadData()
  }
  
  

  @IBAction func cancelToNewTripViewController(segue:UIStoryboardSegue) {
    // this is set to unwind segues to the NewTripController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set the background image of the trips table
    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    itemTable.backgroundView = UIImageView(image: bgImage)
    
    // give the lower add button rounded corners and shadow
    addButtonView.layer.cornerRadius = 30
    addButtonView.layer.shadowOffset = CGSizeMake(2, 2)
    addButtonView.layer.shadowRadius = 2
    addButtonView.layer.shadowOpacity = 0.7
    
  }
  
  override func viewWillAppear(animated: Bool) {
    // reload the table when coming back from another view
    itemTable.reloadData()
  }

  // **** Formatting the tableView *****//
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presentedTrips.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("tripCell", forIndexPath: indexPath) as! UITableViewCell
    let trip = presentedTrips[indexPath.row]
    
    //**** hard coded --- FIX!
    // only counts the items in the default 'All Items List'
    // which is ok if ALl Items List includes items from other lists
    var allTripItems = trip.lists.first?.items.filter("itemCount > 0").count
    
    // tripName
    var tripNameLabel = cell.contentView.viewWithTag(1) as! UILabel
    tripNameLabel.adjustsFontSizeToFitWidth = true
    tripNameLabel.text = "\(trip.tripName)"
    // tripStartDate
    var dateLabel = cell.contentView.viewWithTag(3) as! UILabel
    dateLabel.text = "\(trip.startDate)"
    // tripItems Total
    var itemLabel = cell.contentView.viewWithTag(4) as! UILabel
    itemLabel.text = "\(allTripItems!) items"
    // toggle archive flag based on trip status
    var archiveFlag = cell.contentView.viewWithTag(5)
    if trip.archived == true {
      archiveFlag?.hidden = false
    } else {
      archiveFlag?.hidden = true
    }
    
    return cell
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  }
  
  
  
  //  Trip table cell actions - Copy, Edit, Delete
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
   
    
    
    
    
    //****************** Copy trip functions
    //************* need to correct code for when there are more than one lists
    
    var copyCellAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "    "){ (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
      
      self.selectedTrip = self.presentedTrips[indexPath.row]
      // set new trip
      let copiedTrip = Trip()

//      var originalList = ItemList()
//      var originalItem = Item()
      
//      var newList = ItemList()


      copiedTrip.id = NSUUID().UUIDString
      copiedTrip.tripName = "\(self.selectedTrip.tripName)Copy"
      copiedTrip.startDate = self.selectedTrip.startDate
      copiedTrip.numberOfDays = self.selectedTrip.numberOfDays
      self.realm.write {
        self.realm.add(copiedTrip, update: false)
      }
      
      
      for originalList in self.selectedTrip.lists {
        var newList = ItemList()
        newList.id = NSUUID().UUIDString
        newList.listName = originalList.listName
        var originalItems = originalList.items

        self.realm.write {
          copiedTrip.lists.append(newList)
        }
      }
      
      // only copies the first list items
      for eachItem in self.selectedTrip.lists.first!.items {
        var newItem = Item()
        newItem.id = NSUUID().UUIDString
        newItem.itemName = eachItem.itemName
        newItem.itemCount = eachItem.itemCount
        newItem.itemCategory = eachItem.itemCategory
        self.realm.write {
          copiedTrip.lists.first!.items.append(newItem)
        }
//        println(eachItem.itemName)
      }
      
      
      // print the names of lists in the copied list
//      for eachList in copiedTrip.lists {
//        println(eachList.listName)
//        
//      }
      

      println("copy trip")
      self.itemTable.reloadData()
    }
    
    var copyimage = UIImage(named: "copybox.png")!
    copyCellAction.backgroundColor = UIColor(patternImage: copyimage)
    
    
    
    
    
    
    // Archive trip functions
    var archiveCellAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "    ") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
      
      self.editing = false
      self.selectedTrip = self.presentedTrips[indexPath.row]
      self.realm.write {
        self.selectedTrip.archived = true
      }
      self.itemTable.reloadData()
    }
    var archiveimage = UIImage(named: "archivebox.png")!
    archiveCellAction.backgroundColor = UIColor(patternImage: archiveimage)
    
    // Edit trip functions
    var editCellAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "    ") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
      
      self.editing = false
      self.selectedTrip = self.presentedTrips[indexPath.row]
      self.performSegueWithIdentifier("editTripData", sender: self)
    }
    var editimage = UIImage(named: "editbox.png")!
    editCellAction.backgroundColor = UIColor(patternImage: editimage)

    
    // Delete trip functions
    var deleteCellAction = UITableViewRowAction(style: .Normal, title: "    ") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
      println("delete action")
      var deleteAlert = UIAlertController(title: "Confirm Delete", message: "Selected Trip Will be DELETED!", preferredStyle: .Alert)
      deleteAlert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { (action: UIAlertAction!) in
        self.realm.write {
          let selectedTrip = self.presentedTrips[indexPath.row]
          self.realm.delete(selectedTrip)
        }
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
      }))
      deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
        return
      }))
      self.presentViewController(deleteAlert, animated: true, completion: nil)
    }
    
    var deleteImage = UIImage(named: "deletebox.png")!
    deleteCellAction.backgroundColor = UIColor(patternImage: deleteImage)
    
    // first item in array is far right in cell
    return [deleteCellAction, editCellAction, copyCellAction, archiveCellAction]
  }
  
  
  

  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showTripLists" {
      if let destinationController = segue.destinationViewController as? TripListViewController {
        if let tripIndex = itemTable.indexPathForSelectedRow() {
          let chosenTrip = presentedTrips[tripIndex.row]
          destinationController.chosenTrip = chosenTrip
        }
      }
    }
    
    if segue.identifier == "editTripData" {
      if let destinationController = segue.destinationViewController as? NewTripViewController {
          println("clicked edit trip")
          destinationController.editedTrip = selectedTrip
          destinationController.editToggle = true
      }
    }
  } // end prepareforsegue



}
