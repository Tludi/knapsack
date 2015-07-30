//
//  ListItemTableController.swift
//  knapsack
//
//  Created by manatee on 7/25/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit

class ListItemTableController: UITableViewController, ENSideMenuDelegate {

  var sectionNames = ["Clothes", "Bathroom"]
  var clothesListItems = ["Pants", "Coat", "Shirts", "Socks", "Shoes"]
  var bathroomListItems = ["toothbrush", "toothpaste", "pit stick", "soap"]
  var listName = "All Items"
  
  @IBAction func menuToggle(sender: UIBarButtonItem) {
    toggleSideMenuView()
    println("pressed toggle button")
  }
  
  @IBOutlet var listItemTable: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.sideMenuController()?.sideMenu?.delegate = self
    
    // Set the background image of the listItem table
    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    listItemTable.backgroundView = UIImageView(image: bgImage)
    
    
      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false

      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      // #warning Potentially incomplete method implementation.
      // Return the number of sections.
      return 2
  }

  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "\(sectionNames[section])"
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete method implementation.
      // Return the number of rows in the section.
    if section == 0 {
      return clothesListItems.count
    } else {
      return bathroomListItems.count
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("listItemCell", forIndexPath: indexPath) as! UITableViewCell
    if indexPath.section == 0 {
      let listItem = clothesListItems[indexPath.row]
      cell.textLabel?.text = listItem
    } else {
      let listItem = bathroomListItems[indexPath.row]
      cell.textLabel?.text = listItem
    }
    return cell
  }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
