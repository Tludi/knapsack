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
  let checkedButtonImage = UIImage(named: "filledCheck.png")
  let uncheckedButtonImage = UIImage(named: "emptyCheck.png")
  
  
  @IBOutlet weak var listName: UILabel!
  @IBOutlet weak var listItemTable: UITableView!



  override func viewDidLoad() {
    super.viewDidLoad()
    
    listName.text = chosenList.listName
    // Set the background image of the listItem table
    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    listItemTable.backgroundView = UIImageView(image: bgImage)
    
    println(chosenList.items.count)
    
  }
  
  
  override func viewWillAppear(animated: Bool) {
    
    listItemTable.reloadData()
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
//    return chosenList.items.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if chosenList.items.count == 0 {
      let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! UITableViewCell
      // no items cell
      var listNameLabel = cell.contentView.viewWithTag(1) as! UILabel
      var noItemLabel = cell.contentView.viewWithTag(100) as! UILabel
      var itemCircle = cell.contentView.viewWithTag(50)
      var checkButton:UIButton = cell.contentView.viewWithTag(10) as! UIButton
      noItemLabel.text = "No Items Yet"
      itemCircle!.hidden = true
      checkButton.hidden = true
      return cell
    } else {
      let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! UITableViewCell
      // List Name
      var listNameLabel = cell.contentView.viewWithTag(1) as! UILabel
      var noItemLabel = cell.contentView.viewWithTag(100) as! UILabel
      var itemCircle = cell.contentView.viewWithTag(50)
      var checkButton:UIButton = cell.contentView.viewWithTag(10) as! UIButton
      checkButton.addTarget(self, action: "clicked", forControlEvents: .TouchUpInside)
      
      if chosenList.items[indexPath.row].packed == true {
        checkButton.setImage(checkedButtonImage, forState: .Normal)
      } else {
        checkButton.setImage(uncheckedButtonImage, forState: .Normal)
      }
      listNameLabel.text = "\(chosenList.items[indexPath.row].itemName)"
//      if chosenList.items.count == 0 {
//          println(chosenList.items.count)
//          noItemLabel.text = "No Items Yet"
//          itemCircle!.hidden = true
//      } else {
//        listNameLabel.text = "\(chosenList.items[indexPath.row].itemName)"
//      }

      return cell
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    var cell = tableView.cellForRowAtIndexPath(indexPath)
    var checkButton:UIButton = cell?.contentView.viewWithTag(10) as! UIButton
    if checkButton.hidden == false {
      var selectedItem = chosenList.items[indexPath.row]
      toggleCheckButton(selectedItem)
    }
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
  
  func clicked() {
    println("clicked check button")
  }



}
