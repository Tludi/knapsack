//
//  NewListViewController.swift
//  knapsack
//
//  Created by manatee on 8/4/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift


class NewListViewController: UIViewController {
  let allLists = Realm().objects(ItemList)
  let masterList = Realm().objects(ItemList).filter("id = '1'")
  

  @IBOutlet weak var masterItemCount: UILabel!
  @IBOutlet weak var allListsCount: UILabel!
  @IBAction func populateMasterList(sender: UIButton) {
    checkForData()
  }
  
  @IBAction func deleteMasterList(sender: UIButton) {
    deleteMasterList()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    masterItemCount.text = "\(masterList.count)- Master List"
    allListsCount.text = "All Lists \(allLists.count)"
 
    
      // Do any additional setup after loading the view.
  }
  
  func checkForData() {
    if masterList.count == 0 {
      println("Master List Being Created")
      DataManager.populateRealm()
      masterItemCount.text = "\(masterList.count)"
      allListsCount.text = "All Lists \(allLists.count)"
    } else {
      var first = masterList.first!
      println("Master List Exists")
      println("\(first.items.count) items")
      masterItemCount.text = "\(masterList.count)-\(first.listName)"
    }
    
  }
  
  func deleteMasterList() {
    let realm = Realm()
    if masterList.count >= 1 {
      realm.write {
        realm.delete(self.masterList)
      }
      println("Deleted Master List")
    }
    masterItemCount.text = "\(masterList.count)"
    allListsCount.text = "All Lists \(allLists.count)"
  }


}
