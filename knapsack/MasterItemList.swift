//
//  MasterItemList.swift
//  knapsack
//
//  Created by manatee on 8/4/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import Foundation
import RealmSwift

class DataManager {
  class func populateRealm() -> Void {
    let realm = Realm()
    
    let masterCategories = MasterItemList().categories
    let masterItems = MasterItemList().itemList
    
    let masterListWithAllItems = ItemList()
    masterListWithAllItems.id = "1"
    masterListWithAllItems.listName = "Master Item List"
    realm.write {
      realm.add(masterListWithAllItems)
      println("added master list")
    }
    
    for category in masterCategories {
      var categoryList = masterItems[category]!
      for item in categoryList {
        var categoryItem = item
        
        var newItem = Item()
        newItem.id = NSUUID().UUIDString
        newItem.itemCategory = category
        newItem.itemName = item
        
        realm.write {
          masterListWithAllItems.items.append(newItem)
          println("added \(newItem.itemName)")
        }
      }
    }
    
  }
}
