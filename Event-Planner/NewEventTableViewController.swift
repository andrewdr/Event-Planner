//
//  NewEventTableViewController.swift
//  Event-Planner
//
//  Created by The Clout on 2/16/20.
//  Copyright © 2020 Draper Web Services. All rights reserved.
//

import UIKit
import CoreData

class NewEventTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var eventDate: UIDatePicker!
    @IBOutlet weak var eventStartTime: UIDatePicker!
    @IBOutlet weak var eventEndTime: UIDatePicker!
    @IBOutlet weak var eventVenue: UITextField!
    @IBOutlet weak var eventAddress: UITextView!
    
    var date: String?
    
    @IBAction func dateSelected(_ sender: UIDatePicker) {
    
        eventDate?.datePickerMode = .date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "E, MMM d, yyy"
        
        date = dateFormatter.string(from: eventDate.date)

    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            eventDescription.resignFirstResponder()
            eventAddress.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
    var event: [NSManagedObject] = []
    
    
    @IBAction func createEventBtn(_ sender: Any) {
        addEvent()
    }
    
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
        
        do {
            try managedContext.save()
            
            event.append(events)
            
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

//         Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        eventName.delegate = self
        eventDescription.delegate = self
        eventVenue.delegate = self
        eventAddress.delegate = self
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
//        eventDescription.resignFirstResponder()
        eventVenue.resignFirstResponder()
//        eventAddress.resignFirstResponder()
        
        return true;
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        eventDescription.resignFirstResponder()
        eventAddress.resignFirstResponder()
        return true
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
