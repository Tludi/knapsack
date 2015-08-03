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
    let cell = tableView.dequeueReusableCellWithIdentifier("categoryItemCell", forIndexPath: indexPath) as! UITableViewCell
    
    // get current saved items from the passed list
    var passedListItems = passedList.items
    println(passedListItems.count)
    
    // get master category list from swift file
    var category = CategoryList(category: passedCategory, items: masterList[passedCategory]! )
    var item = category.items[indexPath.row]
   
    
    
    // set cell labels
    var itemLabel = cell.contentView.viewWithTag(1) as! UILabel
    var itemStepper = cell.contentView.viewWithTag(6) as! UIStepper
    var itemCountLabel = cell.contentView.viewWithTag(5) as! UILabel
    itemLabel.text = item
    var itemCount = 0
    itemCountLabel.text = "\(itemCount)"
    if itemCount == 0 {
      itemStepper.hidden = true
    }

    
    
    
//    cell.textLabel?.text = category.items[indexPath.row]
    return cell
  }

  
  
  
  
  
  
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    println(indexPath.row)
    let cell = tableView.cellForRowAtIndexPath(indexPath)!
    println(cell.textLabel?.text)
    
    var category = CategoryList(category: passedCategory, items: masterList[passedCategory]! )
    var selectedItem = category.items[indexPath.row]
    var newItem = Item()
    newItem.id = NSUUID().UUIDString
    newItem.itemName = selectedItem
    newItem.itemCount = 1
    realm.write {
      self.passedList.items.append(newItem)
    }
    
  }


}
