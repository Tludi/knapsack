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
  
  @IBOutlet weak var addButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // try to hide the addButton. Show for testing
    addButton.tintColor = UIColor.clearColor()
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

  // set two sections - One for "All Items" and one for Categories
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let tripLists = chosenTrip.lists
    let selectedItems = tripLists[0].items.filter("itemCount > 0")
    var selectedCategories = [String]()
    for i in 0..<selectedItems.count {
      if selectedCategories.contains(selectedItems[i].itemCategory) == false {
        selectedCategories.append(selectedItems[i].itemCategory)
      }
    }
    // Return the number of rows in the section.
    if section == 1 {
      print(selectedCategories.count)
      return selectedCategories.count
    } else {
      return 1
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) 
    let tripList = chosenTrip.lists[0]
    let selectedItems = tripList.items.filter("itemCount > 0")
//    print(selectedItems)
//
//    // create an array of selectedCategories that have been selected
    var selectedCategories = [String]()
    for i in 0..<selectedItems.count {
      if selectedCategories.contains(selectedItems[i].itemCategory) == false {
        selectedCategories.append(selectedItems[i].itemCategory)
      }
    }
//    print(selectedCategories)
//    
//    // Get items that have not been packed yet
    let unpackedItems = selectedItems.filter("packed = false")
    

//    print(tripList.listName)
//    listNameLabel.text = "\(tripList.listName)"
    
    
    if indexPath.section == 0 {
      // Show All Items cell in first section
      // List Name - has a tag of 1
      let listNameLabel = cell.contentView.viewWithTag(1) as! UILabel
      // get the default "All Items" List Name and assign to first section
      listNameLabel.text = "\(tripList.listName)"
      // Item Name
      let listItemNameLabel = cell.contentView.viewWithTag(2) as! UILabel
      listItemNameLabel.text = "\(selectedItems.count) items"
      // Items Left to pack
      let itemsLeft = cell.contentView.viewWithTag(3) as! UILabel
      itemsLeft.text = "\(unpackedItems.count) left"
      
      // Image for All Items
      let categoryImage = cell.contentView.viewWithTag(5) as! UIImageView
      categoryImage.image = UIImage(named: "knapsackIcon")
      

    } else if indexPath.section == 1 {
      // Show item categories if any items are added to list
      // List Name - has a tag of 1
        let sortedCategories = selectedCategories.sort()
        let listNameLabel = cell.contentView.viewWithTag(1) as! UILabel
        let currentCategory = sortedCategories[indexPath.row]
        listNameLabel.text = currentCategory.capitalizedString
      
      // Category List
        let listItemNameLabel = cell.contentView.viewWithTag(2) as! UILabel
//        print(selectedItems[1])
        let categoryItems = selectedItems.filter("itemCategory = '\(currentCategory)'")
//        print(categoryItems)
        listItemNameLabel.text = "\(categoryItems.count) items"
      
      // Items Left to pack
        let itemsLeft = cell.contentView.viewWithTag(3) as! UILabel
        let categoryItemsLeft = categoryItems.filter("packed = false")
        itemsLeft.text = "\(categoryItemsLeft.count) left"
      
      // Image for Category
      // Image Icon needs to be named 'category'Icon
        let categoryImage = cell.contentView.viewWithTag(5) as! UIImageView
        categoryImage.image = UIImage(named: "\(currentCategory)Icon")

    }
    
    return cell
  }
  
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showListItems" {
      if let destinationController = segue.destinationViewController as? ListItemsViewController {
        if let listPath = listTable.indexPathForSelectedRow {
          let cell = tableView(listTable, cellForRowAtIndexPath: listPath)
          let category = cell.contentView.viewWithTag(1) as! UILabel
          let list = chosenTrip.lists[0]
          destinationController.chosenList = list
          destinationController.chosenCategory = category.text!
        }
      }
    }
  }
  
  
}
