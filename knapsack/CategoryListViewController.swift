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

  var realm = try! Realm()
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
    let categoryItemList = passedList.items.filter("itemCategory = '\(passedCategory)'")
    return categoryItemList.count
  }
  
  
  
  // show cell
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let masterItemCount = 0
    let cell = tableView.dequeueReusableCellWithIdentifier("categoryItemCell", forIndexPath: indexPath) 
    
    // get current saved items from the passed list
    let passedListItems = passedList.items
    let categoryItemList = passedList.items.filter("itemCategory = '\(passedCategory)'")
    let item = categoryItemList[indexPath.row]
    
    // set cell labels
    let itemLabel = cell.contentView.viewWithTag(1) as! UILabel
    let itemCountLabel = cell.contentView.viewWithTag(5) as! UILabel
    
    let increaseButton:UIButton = cell.contentView.viewWithTag(10) as! UIButton
    let decreaseButton:UIButton = cell.contentView.viewWithTag(11) as! UIButton
    let decreaseBackground = cell.viewWithTag(12)
    
    itemLabel.text = item.itemName
    itemCountLabel.text = "\(item.itemCount)"
    
    if itemCountLabel.text! == "0" {
      decreaseButton.hidden = true
      decreaseBackground!.hidden = true
    }
    
    // #selector was updated from swift 2
    increaseButton.addTarget(self, action: #selector(CategoryListViewController.changeItemCount(_:)), forControlEvents: .TouchUpInside)
    decreaseButton.addTarget(self, action: #selector(CategoryListViewController.changeItemCount(_:)), forControlEvents: .TouchUpInside)
    
    

    
    return cell
  }
  
  
  
  
  func changeItemCount(sender : UIButton!) {
    let cell = sender.superview!.superview! as! UITableViewCell
    let itemLabel = cell.viewWithTag(1) as! UILabel
    let itemCountLabel = cell.viewWithTag(5) as! UILabel
    let decreaseButton:UIButton = cell.viewWithTag(11) as! UIButton
    let decreaseBackground = cell.viewWithTag(12)
    let currentCount = Int((itemCountLabel.text)!)
    
    
    // this is an array of items
    let existingListItem = passedList.items.filter("itemName = '\(itemLabel.text!)'").first!
    
    // if sender is increase button
    if sender.tag == 10 {
      let updatedCount = currentCount! + 1
      itemCountLabel.text = "\(updatedCount)"
      decreaseButton.hidden = false
      decreaseBackground!.hidden = false
      try! realm.write{
        existingListItem.itemCount = updatedCount
      }
    } else {
      // if sender is decrease button
      let updatedCount = currentCount! - 1
      if updatedCount < 0 {
        itemCountLabel.text = "0"
      } else {
        if updatedCount == 0 {
          decreaseButton.hidden = true
          decreaseBackground?.hidden = true
        }
        itemCountLabel.text = "\(updatedCount)"
        try! realm.write{
          existingListItem.itemCount = updatedCount
        }
      }
    }

  }
  
 


}
