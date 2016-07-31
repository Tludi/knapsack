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

  let realm = try! Realm()
  
  var chosenList = ItemList()
  var chosenCategory = String()
  let checkedButtonImage = UIImage(named: "squareCheck.png")
  let uncheckedButtonImage = UIImage(named: "squareCount.png")
  var filterCat :String = ""
  
  @IBOutlet weak var listName: UILabel!
  @IBOutlet weak var listItemTable: UITableView!
  @IBOutlet weak var addItemBox: UIView!
  @IBAction func addItemBoxButton(sender: UIButton) {
  }



  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    // Set the background image of the listItem table
    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    listItemTable.backgroundView = UIImageView(image: bgImage)

    if chosenCategory == "All Items" {
      filterCat = "itemCount > 0"
      print(filterCat)
    } else {
      filterCat = "itemCount > 0 AND itemCategory == '\(chosenCategory.lowercaseString)'"
      print(filterCat)
    }
    print(chosenList.items.count)
    print(chosenList.items.filter("itemCount > 0").count)
    print(chosenList.items.filter(filterCat).count)
  }
  
  
  override func viewWillAppear(animated: Bool) {
    listName.text = chosenCategory
    addItemBox.layer.cornerRadius = 20
    if chosenList.items.filter("itemCount > 0").count > 0 {
      addItemBox.hidden = true
    } else {
      addItemBox.hidden = false
    }
    
    listItemTable.reloadData()
    
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let itemsWithCount = chosenList.items.filter(filterCat)
    return itemsWithCount.count
 

  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    print("\(filterCat) from the cell for row at index path")
    
    let itemsWithCount = chosenList.items.filter(filterCat)
    let sortedItemsWithCount = itemsWithCount.sorted("itemName")
    let item = sortedItemsWithCount[indexPath.row]

    let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) 
    // List Name
    let listNameLabel = cell.contentView.viewWithTag(1) as! UILabel
    let categoryNameLabel = cell.contentView.viewWithTag(2) as! UILabel

    // box around item count that toggles when item is packed
    let checkBox:UIImageView = cell.contentView.viewWithTag(11) as!UIImageView
    // item count
    let itemCountLabel = cell.contentView.viewWithTag(20) as! UILabel
    // overlay to show when items are packed
    let itemOverlay = cell.contentView.viewWithTag(15)
    
    
    listNameLabel.text = item.itemName
    categoryNameLabel.text = item.itemCategory.capitalizedString
    itemCountLabel.text = "\(item.itemCount)"
    
    // set checked image based on being packed
    if itemsWithCount[indexPath.row].packed == true {
      checkBox.image = checkedButtonImage
      itemOverlay?.hidden = false
    } else {
      checkBox.image = uncheckedButtonImage
      itemOverlay?.hidden = true
    }

    return cell
    
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    let itemsWithCount = chosenList.items.filter(filterCat)
    let item = itemsWithCount[indexPath.row]
    
    let checkBox:UIImageView = cell?.contentView.viewWithTag(11) as! UIImageView
    if checkBox.hidden == false {
      toggleCheckButton(item)
    }
  }
  
  //*** disabled deleting items from list due to it not actually removing items, just the cell ***//
  
//  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//    return true
//  }
//  
//  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//  }
  
  
  
  
//  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
//    
//    // Delete trip functions
//    let deleteCellAction = UITableViewRowAction(style: .Normal, title: "    ") { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
//      print("delete action")
//      let deleteAlert = UIAlertController(title: "Confirm Removal", message: "Selected Item Will Be Removed From List!", preferredStyle: .Alert)
//      deleteAlert.addAction(UIAlertAction(title: "Remove", style: .Default, handler: { (action: UIAlertAction) in
//        
//        let itemsWithCount = self.chosenList.items.filter(self.filterCat)
//
//        try! self.realm.write {
//          let selectedItem = itemsWithCount[indexPath.row]
//          selectedItem.itemCount = 0
//          if self.chosenList.items.count < 1 {
//            self.addItemBox.hidden = false
//          }
//        }
//        
//        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//      }))
//      deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction) in
//        return
//      }))
//      self.presentViewController(deleteAlert, animated: true, completion: nil)
//    }
//    
//    let deleteImage = UIImage(named: "deleteBoxSM.png")!
//    deleteCellAction.backgroundColor = UIColor(patternImage: deleteImage)
//    
//    return [deleteCellAction]
//  }
  
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showAddItem" {
      if let destinationController = segue.destinationViewController as? CategoriesViewController {
          print("clicked add item")
          destinationController.passedList = chosenList
      }
    } else if segue.identifier == "addItemBox" {
      if let destinationController = segue.destinationViewController as? CategoriesViewController {
        print("clicked add item")
        destinationController.passedList = chosenList
      }
    }
  }

  
  func toggleCheckButton(selectedItem: Item) {
    try! realm.write {
      if selectedItem.packed == false {
        selectedItem.packed = true
      } else {
        selectedItem.packed = false
      }
    }
    listItemTable.reloadData()
  }

}
