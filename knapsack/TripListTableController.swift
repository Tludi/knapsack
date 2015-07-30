//
//  TripListTableController.swift
//  knapsack
//
//  Created by manatee on 7/25/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class TripListTableController: UITableViewController {
  
  var lists = ["All Items", "Person 1", "person 2"]
  var chosenTrip = Trip()
  
  @IBOutlet var listTable: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Set the background image of the List table
    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    listTable.backgroundView = UIImageView(image: bgImage)
    self.title = "\(chosenTrip.tripName)Lists"
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
      return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete method implementation.
      // Return the number of rows in the section.
      return chosenTrip.lists.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! UITableViewCell
    let tripLists = chosenTrip.lists
    let tripList = tripLists[indexPath.row]
    
    // List Name
    var listNameLabel = cell.contentView.viewWithTag(1) as! UILabel
    println(tripList.listName)
    listNameLabel.text = "\(tripList.listName)"
    
    // Item Name
    var listItemNameLabel = cell.contentView.viewWithTag(2) as! UILabel
    listItemNameLabel.text = "\(tripList.items.count) items"
    
    return cell
  }



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
