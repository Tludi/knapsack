//
//  MasterItemViewController.swift
//  knapsack
//
//  Created by manatee on 7/30/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift



class MasterItemViewController: UIViewController {

  var realm = Realm()
  var trips = Realm().objects(Trip)
  
  var passedList = ItemList()
  
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

      // Do any additional setup after loading the view.
  }
  


}
