//
//  NewTripViewController.swift
//  View for Adding and Editing the Trip() model
//  knapsack
//
//  Created by manatee on 7/26/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import UIKit
import RealmSwift

class NewTripViewController: UIViewController {

  let realm = try! Realm()
  var editedTrip = Trip()
  var editToggle = false
  
  @IBOutlet weak var tripDetailLabel: UILabel!
  @IBOutlet var newTripView: UIView!
  @IBOutlet weak var tripNameField: UITextField!
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var nightsCount: UILabel!
  @IBOutlet weak var slider: UISlider!
  
  @IBAction func dateTextFieldEditing(sender: UITextField) {
    // configure the date picker
    let datePickerView:UIDatePicker = UIDatePicker()
    datePickerView.datePickerMode = UIDatePickerMode.Date
    sender.inputView = datePickerView
    datePickerView.addTarget(self, action: #selector(NewTripViewController.datePickerValueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    
    // The above code used to be the following. Changed by swift 2.2 and 3
    //  datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
  }
  
  @IBAction func nightsSlider(sender: UISlider) {
    let nights = Int(sender.value)
    nightsCount.text = "\(nights)"
  }
  
  @IBOutlet weak var addtripButtonLabel: UIButton!
  @IBAction func addTripButton(sender: UIButton) {
    
    // check if edit or add was selected in previous view
    if editToggle == true { // Edit existing Trip()
      try! realm.write {
        self.editedTrip.tripName = self.tripNameField.text!
        self.editedTrip.startDate = self.dateTextField.text!
        self.editedTrip.numberOfDays = self.nightsCount.text!
      }
      self.performSegueWithIdentifier("addTripButtonUnwind", sender: self)
    } else {  // add new Trip()
      if let newTripName = tripNameField.text {
        let masterList = try! Realm().objects(ItemList).filter("id = '1'")
        let masterItems = masterList[0].items
        
        // create new empty trip
        let trip = Trip()
        // set trip id
        trip.id = NSUUID().UUIDString
        // check for empty name
        if newTripName == "" {
          let noNameAlert = UIAlertController(title: "Trip Name", message: "Destination Can Not Be Blank", preferredStyle: .Alert)
          noNameAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction) in
            return
          }))
          self.presentViewController(noNameAlert, animated: true, completion: nil)
        } else if dateTextField.text! == "" {
          print("trip start date not chosen > '\(dateTextField.text!)'")
          let noDateAlert = UIAlertController(title: "Trip Date", message: "Select a Start Date", preferredStyle: .Alert)
          noDateAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction) in
            return
          }))
          self.presentViewController(noDateAlert, animated: true, completion: nil)
        } else {
          trip.tripName = newTripName
          trip.startDate = dateTextField.text!
          print("starDate after selection '\(trip.startDate)'")
          trip.numberOfDays = nightsCount.text!
          
          let newList = ItemList()
          newList.id = NSUUID().UUIDString
          newList.listName = "All Items"
          

          for item in masterItems {
            let newItem = Item()
            newItem.id = NSUUID().UUIDString
            newItem.itemCategory = item.itemCategory
            newItem.itemName = item.itemName
            newList.items.append(newItem)
          }

          trip.lists.append(newList)
          
          
          try! realm.write {
            self.realm.add(trip)
            
          }
          self.performSegueWithIdentifier("addTripButtonUnwind", sender: self)

        }
      }
    }

  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // checking if tripName has changed from default in the model
    // If tripName is not the default,
    // change check if changing default in model
    if editedTrip.tripName != "defaulttripname" {
      // populate data fields with existing data
      tripNameField.text = editedTrip.tripName
      dateTextField.text = editedTrip.startDate
      // convert String to Float
      let sliderValueConversion = NSNumberFormatter().numberFromString(editedTrip.numberOfDays)?.floatValue
      slider.value = sliderValueConversion!
      // set detail label to Edit 'Trip'
      tripDetailLabel.text = "Edit \(editedTrip.tripName)"
      // set the add button label to Edit Trip if editing
      addtripButtonLabel.setTitle("Edit Trip", forState: .Normal)
    } else {
//      println("no trip")
      tripDetailLabel.text = "Trip Details"
    }
    
    
//    let bgImage: UIImage = UIImage(named: "iPhone5bg.png")!
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "iPhone5bg.png")!)

//    let trips = realm.objects(Trip)
//    numberOfTrips.text = "\(trips.count)"
    
    let nights = Int(slider.value)
    nightsCount.text = "\(nights)"
  }
  
  override func viewWillAppear(animated: Bool) {
//    addtripButtonLabel.setTitle("\(editButtonLabel)", forState: .Normal)
  }


  


  
  func datePickerValueChanged(sender:UIDatePicker) {
    let dateFormatter = NSDateFormatter()
    
    dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
    dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
    dateTextField.text = dateFormatter.stringFromDate(sender.date)
  }

}
