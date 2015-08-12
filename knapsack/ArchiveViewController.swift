//
//  ArchiveViewController.swift
//  knapsack
//
//  Created by manatee on 8/12/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class ArchiveViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var realm = Realm()
  var allTrips = Realm().objects(Trip)
  
  var archivedTrips = Realm().objects(Trip).filter("archived = true").sorted("startDate")
  var selectedTrip = Trip()
  var showActiveTrips = true
  
  
  @IBOutlet weak var archiveTable: UITableView!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set the background image of the trips table
    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    archiveTable.backgroundView = UIImageView(image: bgImage)

  }
  
  override func viewWillAppear(animated: Bool) {
    archiveTable.reloadData()
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return archivedTrips.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("archiveTripCell", forIndexPath: indexPath) as! UITableViewCell
    let trip = archivedTrips[indexPath.row]
    
    
    //**** hard coded --- FIX!
    // only counts the items in the default 'All Items List'
    // which is ok if ALl Items List includes items from other lists
    var allTripItems = trip.lists.first?.items.count
    
    
    var tripNameLabel = cell.contentView.viewWithTag(1) as! UILabel
    tripNameLabel.text = "\(trip.tripName)"
    // tripStartDate
    var dateLabel = cell.contentView.viewWithTag(3) as! UILabel
    dateLabel.text = "\(trip.startDate)"
    // tripItems Total
    var itemLabel = cell.contentView.viewWithTag(4) as! UILabel
    itemLabel.text = "\(allTripItems!) items"
    // toggle archive flag based on trip status
    var archiveFlag = cell.contentView.viewWithTag(5)
    
    return cell
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  }
  
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
    
    
    //****************** Copy trip functions
    //************* need to correct code for when there are more than one lists
    
    var copyCellAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "    "){ (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
      
      self.selectedTrip = self.archivedTrips[indexPath.row]
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
      self.archiveTable.reloadData()
    }
    
    var copyimage = UIImage(named: "copybox.png")!
    copyCellAction.backgroundColor = UIColor(patternImage: copyimage)
    
    
    // Delete trip functions
    var deleteCellAction = UITableViewRowAction(style: .Normal, title: "    ") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
      println("delete action")
      var deleteAlert = UIAlertController(title: "Confirm Delete", message: "Selected Trip Will be DELETED!", preferredStyle: .Alert)
      deleteAlert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { (action: UIAlertAction!) in
        self.realm.write {
          let selectedTrip = self.archivedTrips[indexPath.row]
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
    return [deleteCellAction, copyCellAction]
  }

}
