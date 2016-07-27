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

  var realm = try! Realm()
  var allTrips = try! Realm().objects(Trip)
  var presentedTrips = try! Realm().objects(Trip).filter("archived = false").sorted("startDate")
  var selectedTrip = Trip()
  var showActiveTrips = true
  let date = NSDate()
  

  @IBOutlet weak var addTripBox: UIView!
  
  @IBOutlet weak var itemTable: UITableView!
//  @IBOutlet weak var addButtonView: UIView!
  
  @IBAction func addButton(sender: UIButton) {
  }
  
  @IBOutlet weak var toggleTripType: UIBarButtonItem!
  @IBAction func toggleTripType(sender: UIBarButtonItem) {
    if showActiveTrips == true {
      showActiveTrips = false
      presentedTrips = try! Realm().objects(Trip).filter("archived = true")
      self.title = "Archives"

    } else {
      showActiveTrips = true
      presentedTrips = try! Realm().objects(Trip).filter("archived = false")
      self.title = "Active Trips"

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
    

    
  }
  
  override func viewWillAppear(animated: Bool) {
    // reload the table when coming back from another view
    addTripBox.layer.cornerRadius = 20
    
    if allTrips.count > 0 {
      addTripBox.hidden = true
    } else {
      addTripBox.hidden = false
    }
    
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
    let cell = tableView.dequeueReusableCellWithIdentifier("tripCell", forIndexPath: indexPath) 
    let trip = presentedTrips[indexPath.row]
    
    //**** hard coded --- FIX!
    // only counts the items in the default 'All Items List'
    // which is ok if ALl Items List includes items from other lists
    let allTripItems = trip.lists.first?.items.filter("itemCount > 0").count
    
    // tripName
    let tripNameLabel = cell.contentView.viewWithTag(1) as! UILabel
    tripNameLabel.adjustsFontSizeToFitWidth = true
    tripNameLabel.text = "\(trip.tripName)"
    // tripStartDate
    let dateLabel = cell.contentView.viewWithTag(3) as! UILabel
    dateLabel.text = "\(trip.startDate)"
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
    let convertedDate = dateFormatter.stringFromDate(date)
    
    
    print("Today's Date")
    print(convertedDate)
    print("trip date")
    print(trip.startDate)
    
    
    // tripItems Total
    let itemLabel = cell.contentView.viewWithTag(4) as! UILabel
    itemLabel.text = "\(allTripItems!) items"
    // toggle archive flag based on trip status
    let archiveFlag = cell.contentView.viewWithTag(5)
    if trip.archived == true {
      archiveFlag?.hidden = false
    } else {
      archiveFlag?.hidden = true
    }
    // daysToGo label
    let daysToGo = cell.contentView.viewWithTag(6) as! UILabel
    daysToGo.text = "55"
    
    return cell
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  }
  
  
  
  //  Trip table cell actions - Copy, Edit, Delete
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
   
    
    
    
    
    //****************** Copy trip functions
    //************* need to correct code for when there are more than one lists
    
    let copyCellAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "    "){ (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
      
      self.selectedTrip = self.presentedTrips[indexPath.row]
      // set new trip
      let copiedTrip = Trip()

      copiedTrip.id = NSUUID().UUIDString
      copiedTrip.tripName = "\(self.selectedTrip.tripName)Copy"
      copiedTrip.startDate = self.selectedTrip.startDate
      copiedTrip.numberOfDays = self.selectedTrip.numberOfDays
      try! self.realm.write {
        self.realm.add(copiedTrip, update: false)
      }
      
      
      for originalList in self.selectedTrip.lists {
        let newList = ItemList()
        newList.id = NSUUID().UUIDString
        newList.listName = originalList.listName
//        var originalItems = originalList.items

        try! self.realm.write {
          copiedTrip.lists.append(newList)
        }
      }
      
      // only copies the first list items
      for eachItem in self.selectedTrip.lists.first!.items {
        let newItem = Item()
        newItem.id = NSUUID().UUIDString
        newItem.itemName = eachItem.itemName
        newItem.itemCount = eachItem.itemCount
        newItem.itemCategory = eachItem.itemCategory
        try! self.realm.write {
          copiedTrip.lists.first!.items.append(newItem)
        }
      }

      print("copy trip")
      self.itemTable.reloadData()
    }
    
    let copyimage = UIImage(named: "copybox.png")!
    copyCellAction.backgroundColor = UIColor(patternImage: copyimage)
    
    
    
    
    
    
    // Archive trip functions
    let archiveCellAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "    ") { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
      
      self.editing = false
      self.selectedTrip = self.presentedTrips[indexPath.row]
      try! self.realm.write {
        self.selectedTrip.archived = true
      }
      self.itemTable.reloadData()
    }
    let archiveimage = UIImage(named: "archivebox.png")!
    archiveCellAction.backgroundColor = UIColor(patternImage: archiveimage)
    
    // Edit trip functions
    let editCellAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "    ") { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
      
      self.editing = false
      self.selectedTrip = self.presentedTrips[indexPath.row]
      self.performSegueWithIdentifier("editTripData", sender: self)
    }
    let editimage = UIImage(named: "editbox.png")!
    editCellAction.backgroundColor = UIColor(patternImage: editimage)

    
    // Delete trip functions
    let deleteCellAction = UITableViewRowAction(style: .Normal, title: "    ") { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
      print("delete action")
      let deleteAlert = UIAlertController(title: "Confirm Delete", message: "Selected Trip Will be DELETED!", preferredStyle: .Alert)
      deleteAlert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { (action: UIAlertAction) in
        try! self.realm.write {
          let selectedTrip = self.presentedTrips[indexPath.row]
          self.realm.delete(selectedTrip)
        }
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
      }))
      deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction) in
        return
      }))
      self.presentViewController(deleteAlert, animated: true, completion: nil)
    }
    
    let deleteImage = UIImage(named: "deleteBoxLG.png")!
    deleteCellAction.backgroundColor = UIColor(patternImage: deleteImage)
    
    // first item in array is far right in cell
    return [deleteCellAction, editCellAction, copyCellAction, archiveCellAction]
  }
  
  
  

  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showTripLists" {
      if let destinationController = segue.destinationViewController as? TripListViewController {
        if let tripIndex = itemTable.indexPathForSelectedRow {
          let chosenTrip = presentedTrips[tripIndex.row]
          destinationController.chosenTrip = chosenTrip
        }
      }
    }
    
    if segue.identifier == "editTripData" {
      if let destinationController = segue.destinationViewController as? NewTripViewController {
          print("clicked edit trip")
          destinationController.editedTrip = selectedTrip
          destinationController.editToggle = true
      }
    }
  } // end prepareforsegue



}
