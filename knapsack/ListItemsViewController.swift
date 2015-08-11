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

  let realm = Realm()
  
  var chosenList = ItemList()
  let checkedButtonImage = UIImage(named: "squareCheck.png")
  let uncheckedButtonImage = UIImage(named: "squareCount.png")
  
  
  @IBOutlet weak var listName: UILabel!
  @IBOutlet weak var listItemTable: UITableView!



  override func viewDidLoad() {
    super.viewDidLoad()
    
    listName.text = chosenList.listName
    // Set the background image of the listItem table
    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    listItemTable.backgroundView = UIImageView(image: bgImage)
    
    println(chosenList.items.count)
    println(chosenList.items.filter("itemCount > 0").count)
    
  }
  
  
  override func viewWillAppear(animated: Bool) {
    
    listItemTable.reloadData()
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var itemsWithCount = chosenList.items.filter("itemCount > 0")
//    var itemsWithCount = chosenList.items
    return itemsWithCount.count
 

  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var itemsWithCount = chosenList.items.filter("itemCount > 0")
//    var itemsWithCount = chosenList.items
    var item = itemsWithCount[indexPath.row]

    let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! UITableViewCell
    // List Name
    var listNameLabel = cell.contentView.viewWithTag(1) as! UILabel
    var categoryNameLabel = cell.contentView.viewWithTag(2) as! UILabel
    var noItemLabel = cell.contentView.viewWithTag(100) as! UILabel
    var itemCircle = cell.contentView.viewWithTag(50)
    var checkButton:UIButton = cell.contentView.viewWithTag(10) as! UIButton
    var testLabel = cell.contentView.viewWithTag(20) as! UILabel
    var itemOverlay = cell.contentView.viewWithTag(15)
    
    listNameLabel.text = item.itemName
    categoryNameLabel.text = item.itemCategory.capitalizedString
    testLabel.text = "\(item.itemCount)"
    
//    checkButton.addTarget(self, action: "clicked:", forControlEvents: .TouchUpInside)
//    
    // set checked image based on being packed
    if itemsWithCount[indexPath.row].packed == true {
      checkButton.setImage(checkedButtonImage, forState: .Normal)
      itemOverlay?.hidden = false
    } else {
      checkButton.setImage(uncheckedButtonImage, forState: .Normal)
      itemOverlay?.hidden = true
    }

    return cell
    
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    var cell = tableView.cellForRowAtIndexPath(indexPath)
    var itemsWithCount = chosenList.items.filter("itemCount > 0")
    var item = itemsWithCount[indexPath.row]
    
    var checkButton:UIButton = cell?.contentView.viewWithTag(10) as! UIButton
    if checkButton.hidden == false {
      toggleCheckButton(item)
    }
  }
  
  
  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  }
  
  
  
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
    
    // Delete trip functions
    var deleteCellAction = UITableViewRowAction(style: .Normal, title: "    ") { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
      println("delete action")
      var deleteAlert = UIAlertController(title: "Confirm Removal", message: "Selected Item Will Be Removed From List!", preferredStyle: .Alert)
      deleteAlert.addAction(UIAlertAction(title: "Remove", style: .Default, handler: { (action: UIAlertAction!) in
        
        var itemsWithCount = self.chosenList.items.filter("itemCount > 0")
        //    var itemsWithCount = chosenList.items
        var item = itemsWithCount[indexPath.row]
        self.realm.write {
          let selectedItem = itemsWithCount[indexPath.row]
          selectedItem.itemCount = 0
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
    
    return [deleteCellAction]
  }
  
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showAddItem" {
      if let destinationController = segue.destinationViewController as? CategoriesViewController {
          println("clicked add item")
          destinationController.passedList = chosenList
      }
    }
  }

  
  func toggleCheckButton(selectedItem: Item) {
    realm.write {
      if selectedItem.packed == false {
        selectedItem.packed = true
      } else {
        selectedItem.packed = false
      }
    }
    listItemTable.reloadData()
  }
  
//    func clicked(sender : UIButton!) {
//      var cell = sender.superview!.superview!
//      var testLabel = cell.viewWithTag(20)! as! UILabel
//      var currentCount = testLabel.text?.toInt()
//      var updatedCount = currentCount! + 1
//      testLabel.text = "\(updatedCount)"
//      println(testLabel.text!)
//    }



}
