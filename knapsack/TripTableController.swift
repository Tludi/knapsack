//
//  TripTableController.swift
//  knapsack
//
//  Created by manatee on 7/25/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class TripTableController: UITableViewController {

  var staticTrips = ["Boston", "New York", "San Diego"]
  var allTrips = Realm().objects(Trip)
  
  
  @IBAction func clearTrips(sender: UIBarButtonItem) {
    clearDatabase()
  }
  
  @IBOutlet var tripTable: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Set the background image of the trips table
    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    tripTable.backgroundView = UIImageView(image: bgImage)
    
      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false

      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func viewWillAppear(animated: Bool) {
    self.tripTable.reloadData()
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
      return allTrips.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("tripCell", forIndexPath: indexPath) as! UITableViewCell
    let trip = allTrips[indexPath.row]
    // Trip Name
    var tripNameLabel = cell.contentView.viewWithTag(1) as! UILabel
    tripNameLabel.text = "\(trip.tripName)"
    // Trip Date
    var dateLabel = cell.contentView.viewWithTag(3) as! UILabel
    dateLabel.text = "\(trip.startDate)"
    // Trip Items
    var itemLabel = cell.contentView.viewWithTag(4) as! UILabel
    //    itemLabel.text = "\(trip.lists.count) items"
    itemLabel.text = "100 items"
    
//    cell.textLabel?.text = staticTrips[indexPath.row]
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showList" {
      if let destinationController = segue.destinationViewController as? TripListTableController {
        if let tripIndex = tripTable.indexPathForSelectedRow() {
          println("clicked show List")
          let trip = allTrips[tripIndex.row]
          destinationController.chosenTrip = trip
        }
      }
    }
//    if segue.identifier == "editTrip" {
//      println("clicked edit trip 1")
//      if let destinationController = segue.destinationViewController as? NewTripViewController {
//        println("clicked edit trip 2")
////        destinationController.editedTrip = trip
//        destinationController.editButtonLabel = "Edit Trip"
//        destinationController.addtripButtonLabel.setTitle("Edit Trip", forState: .Normal)
//        }
//      }
//    }
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
  func clearDatabase() {
    let realm = Realm()
    //let trip = Trip()
    realm.write {
      //*** disabled clearing database ***
      //*** uncommment to allow clearing database ***
      realm.deleteAll()
    }
    self.tripTable.reloadData()
  }

}
