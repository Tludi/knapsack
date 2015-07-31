//
//  NewTripViewController.swift
//  knapsack
//
//  Created by manatee on 7/26/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class NewTripViewController: UIViewController {

  let realm = Realm()
  var editedTrip = Trip()
  var editButtonLabel = "Oh No"
  
  @IBOutlet weak var tripDetailLabel: UILabel!
  @IBOutlet var newTripView: UIView!
  @IBOutlet weak var numberOfTrips: UILabel!
  @IBOutlet weak var tripNameField: UITextField!
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var nightsCount: UILabel!
  @IBOutlet weak var slider: UISlider!
  
  @IBAction func dateTextFieldEditing(sender: UITextField) {
    
    var datePickerView:UIDatePicker = UIDatePicker()
    
    datePickerView.datePickerMode = UIDatePickerMode.Date
    
    sender.inputView = datePickerView
    
    datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
  }
  
  @IBAction func nightsSlider(sender: UISlider) {
    var nights = Int(sender.value)
    nightsCount.text = "\(nights)"
  }
  
  @IBOutlet weak var addtripButtonLabel: UIButton!
  @IBAction func addTripButton(sender: UIButton) {
    println("pressed added trip")
    if var newTripName = tripNameField.text {
      let trip = Trip()
      trip.tripName = newTripName
      trip.startDate = dateTextField.text
      trip.numberOfDays = nightsCount.text!
      
      var newList = ItemList()
      newList.listName = "All Items"
      let newItem = Item()
      newItem.itemName = "Soap"
      newList.items.append(newItem)
      trip.lists.append(newList)
      realm.write {
        self.realm.add(trip)
        
      }
    }
    numberOfTrips.text = "\(realm.objects(Trip).count)"
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tripDetailLabel.text = editedTrip.tripName
    println(editedTrip.tripName)
    
    
    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "iPhone5bg.png")!)

    let trips = realm.objects(Trip)
    numberOfTrips.text = "\(trips.count)"
    
    var nights = Int(slider.value)
    nightsCount.text = "\(nights)"
  }
  
  override func viewWillAppear(animated: Bool) {
//    addtripButtonLabel.setTitle("\(editButtonLabel)", forState: .Normal)
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  

  /*
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
  }
  */
  
  func datePickerValueChanged(sender:UIDatePicker) {
    var dateFormatter = NSDateFormatter()
    
    dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
    dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
    dateTextField.text = dateFormatter.stringFromDate(sender.date)
  }

}
