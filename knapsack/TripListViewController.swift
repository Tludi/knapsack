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

  // Trip selected
  var chosenTrip = Trip()
  // why is this here?
  var allTrips = try! Realm().objects(Trip)

  @IBOutlet weak var listTable: UITableView!
  @IBOutlet weak var tripNameLabel: UILabel!
  
  override func viewDidLoad() {
      super.viewDidLoad()

    // set trip label to name of current trip
    tripNameLabel.text = chosenTrip.tripName
    // Set label of current page
    self.title = "Packing List"
    // Set the background image of the trips table
    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    listTable.backgroundView = UIImageView(image: bgImage)
  }
  
  override func viewWillAppear(animated: Bool) {
    listTable.reloadData()
  }

  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows in the section.
    if section == 1 {
      return 1
    } else {
      return 1
    }
    
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) 
    let tripLists = chosenTrip.lists
    let tripList = tripLists[indexPath.row]
    let selectedItems = tripList.items.filter("itemCount > 0")
//    print(selectedItems)
//    var selectedCategories = []
    
    // create an array of selectedCategories that have been selected
    var selectedCategories = [String]()
    for i in 0..<selectedItems.count {
      if selectedCategories.contains(selectedItems[i].itemCategory) == false {
        selectedCategories.append(selectedItems[i].itemCategory)
      }
    }
    print(selectedCategories)
    
    let unpackedItems = selectedItems.filter("packed = false")
    
    // List Name
    let listNameLabel = cell.contentView.viewWithTag(1) as! UILabel
//    print(tripList.listName)
//    listNameLabel.text = "\(tripList.listName)"
    
    
    if indexPath.section == 0 {
      listNameLabel.text = "\(tripList.listName)"
      // Item Name
      let listItemNameLabel = cell.contentView.viewWithTag(2) as! UILabel
      listItemNameLabel.text = "\(selectedItems.count) items"
      
      // Items Left to pack
      let itemsLeft = cell.contentView.viewWithTag(3) as! UILabel
      itemsLeft.text = "\(unpackedItems.count) left"

    } else {

      
      listNameLabel.text = "fix me"
      //listNameLabel.text = "\(selectedCategories[indexPath.row])"
      // Item Name
      let listItemNameLabel = cell.contentView.viewWithTag(2) as! UILabel
      listItemNameLabel.text = "\(selectedItems.count) items"
      
      // Items Left to pack
      let itemsLeft = cell.contentView.viewWithTag(3) as! UILabel
      itemsLeft.text = "\(unpackedItems.count) left"
      


    }
    
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showListItems" {
      if let destinationController = segue.destinationViewController as? ListItemsViewController {
        if let listIndex = listTable.indexPathForSelectedRow {
          print("clicked show list")
          
          let list = chosenTrip.lists[listIndex.row]
          destinationController.chosenList = list
        }
      }
    }
  }
  
  
}
