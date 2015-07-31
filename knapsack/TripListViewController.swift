//
//  TripListViewController.swift
//  knapsack
//
//  Created by manatee on 7/30/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class TripListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var chosenTrip = Trip()
  var allTrips = Realm().objects(Trip)

  @IBOutlet weak var listTable: UITableView!
  @IBOutlet weak var tripNameLabel: UILabel!
  
  override func viewDidLoad() {
      super.viewDidLoad()

    tripNameLabel.text = chosenTrip.tripName
    self.title = "Lists"
    // Set the background image of the trips table
    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    listTable.backgroundView = UIImageView(image: bgImage)
  }

  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return chosenTrip.lists.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! UITableViewCell
    let tripLists = chosenTrip.lists
    let tripList = tripLists[indexPath.row]
    
    // List Name
    var listNameLabel = cell.contentView.viewWithTag(1) as! UILabel
    println(tripList.listName)
//    listNameLabel.text = "\(tripList.listName)"
    listNameLabel.text = "\(tripList.listName)"
    
    // Item Name
    var listItemNameLabel = cell.contentView.viewWithTag(2) as! UILabel
    listItemNameLabel.text = "\(tripList.items.count) items"
    
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showListItems" {
      if let destinationController = segue.destinationViewController as? ListItemsViewController {
        if let listIndex = listTable.indexPathForSelectedRow() {
          println("clicked show list")
          
          let list = chosenTrip.lists[listIndex.row]
          destinationController.chosenList = list
        }
      }
    }
  }
  
  
}
