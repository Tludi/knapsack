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
    
    // set cell labels
    var itemLabel = cell.contentView.viewWithTag(1) as! UILabel
    var itemCountLabel = cell.contentView.viewWithTag(5) as! UILabel
    
    var increaseButton:UIButton = cell.contentView.viewWithTag(10) as! UIButton
    var decreaseButton:UIButton = cell.contentView.viewWithTag(11) as! UIButton
    
    itemLabel.text = item.itemName
    itemCountLabel.text = "\(item.itemCount)"
    
    if itemCountLabel.text! == "0" {
      decreaseButton.hidden = true
    }
    
    increaseButton.addTarget(self, action: "changeItemCount:", forControlEvents: .TouchUpInside)
    decreaseButton.addTarget(self, action: "changeItemCount:", forControlEvents: .TouchUpInside)
    
    

    
    return cell
  }
  
  
  
  
  func changeItemCount(sender : UIButton!) {
    var cell = sender.superview!.superview! as! UITableViewCell
    var itemLabel = cell.viewWithTag(1) as! UILabel
    var itemCountLabel = cell.viewWithTag(5) as! UILabel
    var decreaseButton:UIButton = cell.viewWithTag(11) as! UIButton
    var currentCount = itemCountLabel.text?.toInt()
    
    
    // this is an array of items
    var existingListItem = passedList.items.filter("itemName = '\(itemLabel.text!)'").first!
    
    // if sender is increase button
    if sender.tag == 10 {
      var updatedCount = currentCount! + 1
      itemCountLabel.text = "\(updatedCount)"
      decreaseButton.hidden = false
      realm.write{
        existingListItem.itemCount = updatedCount
      }
    } else {
      // if sender is decrease button
      var updatedCount = currentCount! - 1
      if updatedCount < 0 {
        itemCountLabel.text = "0"
      } else {
        if updatedCount == 0 {
          decreaseButton.hidden = true
        }
        itemCountLabel.text = "\(updatedCount)"
        realm.write{
          existingListItem.itemCount = updatedCount
        }
      }
    }

  }
  
 


}
