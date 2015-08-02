//
//  MasterItemViewController.swift
//  knapsack
//
//  Created by manatee on 7/30/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift



class MasterItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var realm = Realm()
  var trips = Realm().objects(Trip)
  
  var passedList = ItemList()
  
  var allItems = MasterItemList()
  
  @IBAction func addItemButton(sender: UIButton) {
    var firstTrip = trips.first!
    
    var itemToAdd = Item()

    println(passedList)
    
    itemToAdd.id = NSUUID().UUIDString
    itemToAdd.itemName = "Toothbrush"
    
    
    realm.write {
      self.passedList.items.append(itemToAdd)
    }
  }
  
  
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
      cell.textLabel?.text = item.capitalizedString
      return cell
    
    }



}
