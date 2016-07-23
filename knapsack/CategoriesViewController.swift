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

  var realm = try! Realm()
  var trips = try! Realm().objects(Trip)
  
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
    let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) 
    let category = allItems.categories[indexPath.row]
    let categoryLabelName = cell.contentView.viewWithTag(1) as! UILabel
    
    categoryLabelName.text = category.capitalizedString
    
    // Image for Category
    // Image Icon needs to be named 'category'Icon
    let categoryImage = cell.contentView.viewWithTag(5) as! UIImageView
    print("\(category)Icon")
    //        categoryImage.image = UIImage(named: "clothingIcon")
    categoryImage.image = UIImage(named: "\(category)Icon")
    
    
    return cell
    
  }

  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showCategoryItems" {
      if let destinationController = segue.destinationViewController as? CategoryListViewController {
        if let categoryIndex = categoryTable.indexPathForSelectedRow {
          let categoryToPass = allItems.categories[categoryIndex.row]
          destinationController.passedCategory = categoryToPass
          destinationController.passedList = passedList
        }
      }
    }
  }


}
