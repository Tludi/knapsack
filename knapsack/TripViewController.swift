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
  var selectedTrip = Trip()
  
  @IBOutlet weak var itemTable: UITableView!
  @IBOutlet weak var addButtonView: UIView!
  @IBAction func addButton(sender: UIButton) {
    println("pressed add button")
//    numbers.append("new number")
//    itemTable.reloadData()
  }
  @IBAction func clearTrips(sender: UIBarButtonItem) {
    clearDatabase()
  }
  
  @IBAction func cancelToNewTripViewController(segue:UIStoryboardSegue) {
    
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set the background image of the trips table
    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    itemTable.backgroundView = UIImageView(image: bgImage)
    
    addButtonView.layer.cornerRadius = 30
    addButtonView.layer.shadowOffset = CGSizeMake(2, 2)
    addButtonView.layer.shadowRadius = 2
    addButtonView.layer.shadowOpacity = 0.7
    
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewWillAppear(animated: Bool) {
    itemTable.reloadData()
  }

  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allTrips.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("tripCell", forIndexPath: indexPath) as! UITableViewCell
    let trip = allTrips[indexPath.row]
    var allTripItems = trip.lists.first?.items.count
    
    // tripName
    var tripNameLabel = cell.contentView.viewWithTag(1) as! UILabel
    tripNameLabel.text = "\(trip.tripName)"
    // tripStartDate
    var dateLabel = cell.contentView.viewWithTag(3) as! UILabel
    dateLabel.text = "\(trip.startDate)"
    // tripItems Total
    var itemLabel = cell.contentView.viewWithTag(4) as! UILabel
    itemLabel.text = "\(allTripItems!) items"
    
    return cell
  }
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  }
  
  
  
  //  add edit and delete buttons to cells
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
    
    var editCellAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "    ") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
      
      self.editing = false
      self.selectedTrip = self.allTrips[indexPath.row]
      
      self.performSegueWithIdentifier("editTripData", sender: self)

      println("edit cell data")
      
    }
    var editimage = UIImage(named: "editbox.png")!
    editCellAction.backgroundColor = UIColor(patternImage: editimage)

    // Delete trip functions
    var deleteCellAction = UITableViewRowAction(style: .Normal, title: "    ") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
      println("delete action")
      var deleteAlert = UIAlertController(title: "Confirm Delete", message: "Selected Trip Will be DELETED!", preferredStyle: .Alert)
      deleteAlert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { (action: UIAlertAction!) in
        self.realm.write {
          let selectedTrip = self.allTrips[indexPath.row]
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
    return [deleteCellAction, editCellAction]
  }
  
  
  
  func clearDatabase() {
    let realm = Realm()
    realm.write {
      realm.deleteAll()
    }
    self.itemTable.reloadData()
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showTripLists" {
      if let destinationController = segue.destinationViewController as? TripListViewController {
        if let tripIndex = itemTable.indexPathForSelectedRow() {
          let chosenTrip = allTrips[tripIndex.row]
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
