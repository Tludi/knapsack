//
//  CustomItemViewController.swift
//  
//
//  Created by manatee on 8/8/16.
//
//

import UIKit
import RealmSwift

class CustomItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  let customList = try! Realm().objects(ItemList).filter("id = '2'").first!

  
  @IBOutlet weak var customItemTable: UITableView!
  @IBOutlet weak var testLabel: UILabel!

  @IBOutlet weak var addItemField: UITextField!
  
  @IBAction func addItemButton(sender: UIButton) {
    testLabel.text = addItemField.text!
    
    let realm = try! Realm()
    
    let newItem = Item()
    newItem.id = NSUUID().UUIDString
    newItem.itemCategory = "custom"
    newItem.itemName = (addItemField.text?.capitalizedString)!
    
    try! realm.write {
      customList.items.append(newItem)
      print("added \(newItem.itemName)")
    }
  
    customItemTable.reloadData()
  }

  override func viewDidLoad() {
      super.viewDidLoad()

      testLabel.text = "test"
      // Do any additional setup after loading the view.
  }

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return customList.items.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("customItemCell", forIndexPath: indexPath)
    let customItems = customList.items
    let customItem = customItems[indexPath.row]
    let customItemLabel = cell.contentView.viewWithTag(1) as! UILabel
    customItemLabel.text = customItem.itemName
    
    return cell
  }
  

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */


}
