//
//  NewEventTableViewController.swift
//  Event-Planner
//
//  Created by The Clout on 2/16/20.
//  Copyright © 2020 Draper Web Services. All rights reserved.
//

import UIKit
import CoreData
import GooglePlaces

class NewEventTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate, GMSAutocompleteViewControllerDelegate{
    

    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var eventDate: UIDatePicker!
    @IBOutlet weak var eventStartTime: UIDatePicker!
    @IBOutlet weak var eventEndTime: UIDatePicker!
    @IBOutlet weak var eventVenue: UITextField!
    @IBOutlet weak var eventAddress: UITextView!
    @IBOutlet weak var createEventButtonOutlet: UIButton!
    
    var date: String?
    
//    Date Formatting
    @IBAction func dateSelected(_ sender: UIDatePicker) {
    
        eventDate?.datePickerMode = .date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "E, MMM d, yyy"
        
        date = dateFormatter.string(from: eventDate.date)
        
        createEventButtonOutlet.backgroundColor = UIColor.systemGreen

    }
    
//    Dismiss Keyboards for texviews
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            
            eventDescription.resignFirstResponder()
            eventAddress.resignFirstResponder()
            return false
        }
        return true
    }
    
//    Clears placeholder text on 'description'fields & launches Google Places
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == eventDescription {
            
            eventDescription.text = ""
                
         }
        
        if textView == eventAddress && eventAddress.text == ""{
            //        Show Google Places View
                    let autocompleteController = GMSAutocompleteViewController()
                    autocompleteController.delegate = self
                    present(autocompleteController, animated: true, completion: nil)

//            //        Specify the place data types to return
//                    let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue))!
//                    autocompleteController.placeFields = fields
//
//            //        Specify Filter
//                    let filter = GMSAutocompleteFilter()
//                    filter.type = .address
//                    autocompleteController.autocompleteFilter = filter

            //        Google Places View Styling
                    autocompleteController.primaryTextColor = UIColor.lightGray
                    autocompleteController.primaryTextHighlightColor = UIColor.systemBlue
                    autocompleteController.secondaryTextColor = UIColor.lightGray
        }
                    
    }
    
    
    var event: [NSManagedObject] = []
    
//  create event button
    @IBAction func createEventBtn(_ sender: Any) {
        
        eventStartTime?.datePickerMode = .time
        eventEndTime?.datePickerMode = .time
               
        let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
        
        if eventName.text == "" || eventDescription.text == "" || eventVenue.text == "" || eventAddress.text == ""{
            infoMissingAlert()
        }else if eventStartTime.date >= eventEndTime.date{
            print(eventStartTime.date)
            print(eventEndTime.date)
            
            timeConflictAlert()
        }else {
            eventCreatedAlert()
            addEvent()
            self.tabBarController?.selectedIndex = 0
        }
    }
    
//    Creates Event, Adds event to core data an eventlisttables
    func addEvent(){
        
        dateSelected(eventDate)
        eventStartTime?.datePickerMode = .time
        eventEndTime?.datePickerMode = .time
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        let startTime = dateFormatter.string(from: eventStartTime.date)
        let endTime = dateFormatter.string(from: eventEndTime.date)
        
        let eventData = Event(eventName: eventName.text!, eventDescription: eventDescription.text!, eventDate: date , eventStartTime: startTime, eventEndTime: endTime, eventVenue: eventVenue.text!, eventAddress: eventAddress.text!)
        
        let eventViewModel = EventViewModel(event: eventData)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let eventEntity = NSEntityDescription.entity(forEntityName: "EventInfo", in: managedContext)!
        let events = NSManagedObject(entity: eventEntity, insertInto: managedContext)
        
        events.setValue(eventViewModel.eventName, forKey: "eventName")
        events.setValue(eventViewModel.eventDescription, forKey: "eventDescription")
        events.setValue(eventViewModel.eventDate, forKey: "eventDate")
        events.setValue(eventViewModel.eventStartTime, forKey: "eventStartTime")
        events.setValue(eventViewModel.eventEndTime, forKey: "eventEndTime")
        events.setValue(eventViewModel.eventVenue, forKey: "eventVenue")
        events.setValue(eventViewModel.eventAddress, forKey: "eventAddress")
        
        appDelegate.saveContext()
        
        resetEventInputFields()
        
        do {
            try managedContext.save()
            
            event.append(events)
            
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
//  This alert appears if event information is missing
    func infoMissingAlert(){
        
        var missingInfo: String = ""
        
        if eventName.text == "" || eventDescription.text == "" || eventVenue.text == "" || eventAddress.text == ""{
            
            if eventName.text == ""{
                missingInfo = "EVENT NAME"
            }else if eventDescription.text == ""{
                missingInfo = "DESCRIPTION"
            }else if eventVenue.text == ""{
                missingInfo = "EVENT VENUE"
            }else if eventAddress.text == ""{
                missingInfo = "ADDRESS"
            }

            let missingInfoAlert = UIAlertController(title: "\(missingInfo) MISSING", message: "Please complete the \(missingInfo) field", preferredStyle: .alert)
            
            missingInfoAlert.addAction(UIAlertAction(title: "Return to editing", style: .default))
            
            self.present(missingInfoAlert, animated: true, completion: nil)
            
        }
        
        eventStartTime?.datePickerMode = .time
        eventEndTime?.datePickerMode = .time
               
        let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
               
            if eventStartTime.date <= eventEndTime.date{
                   
                let timeConflictAlert = UIAlertController(title: "TIME CONFLICT", message: "Event 'End Time' must be after 'start time'", preferredStyle: .alert)
                   
                   timeConflictAlert.addAction(UIAlertAction(title: "Return to editing", style: .default, handler: nil))
                   
                   self.present(timeConflictAlert, animated: true, completion: nil)
               }
    }
    
//  Alert Triggered if Event End Time comes before the start time
    func timeConflictAlert(){
            
            let timeConflictAlert = UIAlertController(title: "TIME CONFLICT", message: "Event 'End Time' must be after 'start time'", preferredStyle: .alert)
            
            timeConflictAlert.addAction(UIAlertAction(title: "Return to editing", style: .default, handler: nil))
            
            self.present(timeConflictAlert, animated: true, completion: nil)
    }
    
//  Alert appears when an event is successfully created
    func eventCreatedAlert(){
        let alertController = UIAlertController(title: "Congratulations", message: "Your event has been created", preferredStyle: .alert)
           
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: {(action) -> Void in
            
//          turns 'create event' button back to blue
            self.createEventButtonOutlet.backgroundColor = UIColor.systemBlue
        }))
           
        self.present(alertController, animated: true, completion: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
         self.clearsSelectionOnViewWillAppear = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        eventName.delegate = self
        eventDescription.delegate = self
        eventVenue.delegate = self
        eventAddress.delegate = self
        
        eventDescription.layer.borderWidth = 1
        eventDescription.layer.borderColor = UIColor.systemGray.cgColor
        eventDescription.layer.cornerRadius = 5
        eventDescription.layer.opacity = 0.5
        
        eventAddress.layer.borderWidth = 1
        eventAddress.layer.borderColor = UIColor.systemGray.cgColor
        eventAddress.layer.cornerRadius = 5
        eventAddress.layer.opacity = 0.5
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
    
    // MARK: - Dismiss Keyboards
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        eventName.resignFirstResponder()
        eventVenue.resignFirstResponder()
        return true;
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        eventDescription.resignFirstResponder()
        eventAddress.resignFirstResponder()
        return true
    }
    
    func resetEventInputFields(){
        eventName.text = ""
        eventVenue.text = ""
    }
    
//  MARK: - Google Places Map Functions
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place Name: \(String(describing: place.name))")
        print("Formatted Address: \(String(describing: place.formattedAddress))")
        

        eventAddress.text = String(describing:place.formattedAddress)

        dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error:", error.localizedDescription)
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }

    

    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
