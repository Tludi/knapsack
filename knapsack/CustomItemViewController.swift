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
  var realm = try! Realm()
  let customList = try! Realm().objects(ItemList).filter("id = '2'").first!

  
  @IBOutlet weak var customItemTable: UITableView!
  @IBOutlet weak var testLabel: UILabel!

  @IBOutlet weak var addItemField: UITextField!
  
  @IBAction func addItemButton(sender: UIButton) {
    testLabel.text = addItemField.text!
    
    let realm = try! Realm()
    
    let newItem = Item()
    newItem.id = NSUUID().UUIDString
    newItem.itemCategory = "custom items"
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
  
  
  
  
  //*** Edit and Delete Custom Items

  func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
  }
  
  
  
  //  Trip table cell actions - Edit, Delete
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    
    
    
    
    // Delete trip functions
    let deleteCellAction = UITableViewRowAction(style: .Normal, title: "    ") { (action:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
      print("delete action")
      let deleteAlert = UIAlertController(title: "Confirm Delete", message: "Selected Trip Will be DELETED!", preferredStyle: .Alert)
      deleteAlert.addAction(UIAlertAction(title: "Delete", style: .Default, handler: { (action: UIAlertAction) in
        try! self.realm.write {
          let selectedItem = self.customList.items[indexPath.row]
          self.realm.delete(selectedItem)
        }
        
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
      }))
      deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction) in
        return
      }))
      self.presentViewController(deleteAlert, animated: true, completion: nil)
    }
    
    let deleteImage = UIImage(named: "deleteBoxSM.png")!
    deleteCellAction.backgroundColor = UIColor(patternImage: deleteImage)
    
    // first item in array is far right in cell
    return [deleteCellAction]
  }



}
