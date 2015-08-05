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
    println("\(passedList.items.count) - passed list items ")
  }
  
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return masterList[passedCategory]!.count
    var categoryItemList = passedList.items.filter("itemCategory = '\(passedCategory)'")
    return categoryItemList.count
  }
  
  
  
  // show cell
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    

    
    var masterItemCount = 0
    let cell = tableView.dequeueReusableCellWithIdentifier("categoryItemCell", forIndexPath: indexPath) as! UITableViewCell
    
    // get current saved items from the passed list
    var passedListItems = passedList.items
    var categoryItemList = passedList.items.filter("itemCategory = '\(passedCategory)'")
    var item = categoryItemList[indexPath.row]
    
    // get master category list from swift file
//    var category = CategoryList(category: passedCategory, items: masterList[passedCategory]! )
//    var item = category.items[indexPath.row]
   
    
    // set cell labels
    var itemLabel = cell.contentView.viewWithTag(1) as! UILabel
    var itemCountLabel = cell.contentView.viewWithTag(5) as! UILabel
    var itemCountField = cell.contentView.viewWithTag(15) as! UITextField
    
    
    var increaseButton:UIButton = cell.contentView.viewWithTag(10) as! UIButton
    var decreaseButton:UIButton = cell.contentView.viewWithTag(11) as! UIButton
    
    if itemCountLabel.text == "0" {
      decreaseButton.hidden = true
    }
    increaseButton.addTarget(self, action: "changeItemCount:", forControlEvents: .TouchUpInside)
    decreaseButton.addTarget(self, action: "changeItemCount:", forControlEvents: .TouchUpInside)
    
    
    itemLabel.text = item.itemName
    itemCountLabel.text = "\(item.itemCount)"
    itemCountField.text = "\(item.itemCount)"
    
    itemCountField.addTarget(self, action: "itemCountChanged:", forControlEvents: .EditingDidEnd)
    
    
    return cell
  }
  
  func itemCountChanged(sender : UITextField!) {
    println("text field changed")
  }
  
  func changeItemCount(sender : UIButton!) {
    var cell = sender.superview!.superview! as! UITableViewCell
    var itemLabel = cell.viewWithTag(1) as! UILabel
    var countField = cell.viewWithTag(15) as! UITextField
    var currentCount = countField.text?.toInt()
    
    // this is an array of items
    var existingListItem = passedList.items.filter("itemName = '\(itemLabel.text!)'").first!
    
    println(existingListItem.itemName)
    
    
    if sender.tag == 10 {
      var updatedCount = currentCount! + 1
      countField.text = "\(updatedCount)"
      
      realm.write{
        existingListItem.itemCount = updatedCount
      }
    } else {
      var updatedCount = currentCount! - 1
      if updatedCount < 0 {
        countField.text = "0"
      } else {
        countField.text = "\(updatedCount)"
        realm.write{
          existingListItem.itemCount = updatedCount
        }
      }
    }
    
    
    println(countField.text!)
  }
  
 


}
