//
//  MasterItemViewController.swift
//  knapsack
//
//  Created by manatee on 7/30/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift



class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var realm = Realm()
  var trips = Realm().objects(Trip)
  
  var passedList = ItemList()
  
  var allItems = MasterItemList()
  var categories = MasterItemList().categories
  

  
  @IBOutlet weak var categoryTable: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = "Categories"
      // Do any additional setup after loading the view.
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allItems.categories.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! UITableViewCell
    let item = allItems.categories[indexPath.row]
    let categoryLabelName = cell.contentView.viewWithTag(1) as! UILabel
    
    categoryLabelName.text = item.capitalizedString
    return cell
    
  }

  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showCategoryItems" {
      if let destinationController = segue.destinationViewController as? CategoryListViewController {
        if let categoryIndex = categoryTable.indexPathForSelectedRow() {
          var categoryToPass = allItems.categories[categoryIndex.row]
          destinationController.passedCategory = categoryToPass
          destinationController.passedList = passedList
        }
      }
    }
  }


}
