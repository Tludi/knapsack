//
//  ListItemsViewController.swift
//  knapsack
//
//  Created by manatee on 7/30/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class ListItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var chosenList = ItemList()
  
  @IBOutlet weak var listName: UILabel!
  @IBOutlet weak var listItemTable: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    listName.text = chosenList.listName
    // Set the background image of the listItem table
    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    listItemTable.backgroundView = UIImageView(image: bgImage)
    
    // Do any additional setup after loading the view.
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if chosenList.items.count == 0 {
      return 1
    } else {
      return chosenList.items.count
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//    if chosenList.items == [] {
//      let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! UITableViewCell
//      // List Name
//      var listNameLabel = cell.contentView.viewWithTag(1) as! UILabel
//      listNameLabel.text = "NO Items Yet"
//      return cell
//    } else {
    let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! UITableViewCell
    // List Name
    var listNameLabel = cell.contentView.viewWithTag(1) as! UILabel
    var noItemLabel = cell.contentView.viewWithTag(100) as! UILabel
    if chosenList.items.count == 0 {
        println(chosenList.items.count)
        noItemLabel.text = "No Items Yet"
    } else {
      listNameLabel.text = "\(chosenList.items[indexPath.row].itemName)"
    }
    return cell
  }
  
//  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    if segue.identifier == "showListItems"
//      if let destinationController = segue.destinationViewController as? TripListViewController {
//        if let tripIndex = itemTable.indexPathForSelectedRow() {
//          println("clicked show list")
//          let trip = allTrips[tripIndex.row]
//          destinationController.chosenTrip = trip
//        }
//      }
//    }




}
