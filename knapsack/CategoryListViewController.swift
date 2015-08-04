//
//  CategoryListViewController.swift
//  knapsack
//
//  Created by manatee on 8/2/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var realm = Realm()
  var passedCategory = "clothing"
  var passedList = ItemList()
  var masterList = MasterItemList().itemList
  
  @IBOutlet weak var itemTable: UITableView!
  
  override func viewDidLoad() {
      super.viewDidLoad()
    self.title = passedCategory.capitalizedString
  }
  
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return masterList[passedCategory]!.count
  }
  
  
  // show cell
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var masterItemCount = 0
    let cell = tableView.dequeueReusableCellWithIdentifier("categoryItemCell", forIndexPath: indexPath) as! UITableViewCell
    
    // get current saved items from the passed list
    var passedListItems = passedList.items
    println(passedListItems.count)
    
    // get master category list from swift file
    var category = CategoryList(category: passedCategory, items: masterList[passedCategory]! )
    var item = category.items[indexPath.row]
   
    
    
    // set cell labels
    var itemLabel = cell.contentView.viewWithTag(1) as! UILabel
    var itemCountLabel = cell.contentView.viewWithTag(5) as! UILabel
    var increaseButton:UIButton = cell.contentView.viewWithTag(10) as! UIButton
    var decreaseButton:UIButton = cell.contentView.viewWithTag(11) as! UIButton
    if itemCountLabel.text == "0" {
      decreaseButton.hidden = true
    }
    increaseButton.addTarget(self, action: "changeItemCount:", forControlEvents: .TouchUpInside)
    decreaseButton.addTarget(self, action: "changeItemCount:", forControlEvents: .TouchUpInside)
    
    
    itemLabel.text = item
    itemCountLabel.text = "0"
    
    
    return cell
  }
  
  
//  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    println(indexPath.row)
//    let cell = tableView.cellForRowAtIndexPath(indexPath)!
//    println(cell.textLabel?.text)
//    
//    var category = CategoryList(category: passedCategory, items: masterList[passedCategory]! )
//    var selectedItem = category.items[indexPath.row]
//    var newItem = Item()
//    newItem.id = NSUUID().UUIDString
//    newItem.itemName = selectedItem
//    newItem.itemCount = 1
//    realm.write {
//      self.passedList.items.append(newItem)
//    }
//    
//  }
  
  func changeItemCount(sender : UIButton!) {
    var cell = sender.superview!.superview! as! UITableViewCell
    var itemLabel = cell.viewWithTag(1) as! UILabel
    var countLabel = cell.viewWithTag(5) as! UILabel
    var currentCount = countLabel.text?.toInt()
    if sender.tag == 10 {
      var updatedCount = currentCount! + 1
      countLabel.text = "\(updatedCount)"
    } else {
      var updatedCount = currentCount! - 1
      if updatedCount < 0 {
        countLabel.text = "0"
      } else {
        countLabel.text = "\(updatedCount)"
      }
    }
    
//    var category = CategoryList(category: passedCategory, items: masterList[passedCategory]! )
//    var selectedItem = category.items[indexPath.row]
    var newItem = Item()
    newItem.id = NSUUID().UUIDString
    newItem.itemName = itemLabel.text!
    newItem.itemCount = countLabel.text!.toInt()!
    realm.write {
      self.passedList.items.append(newItem)
    }
    
    
    println(countLabel.text!)
  }


}
