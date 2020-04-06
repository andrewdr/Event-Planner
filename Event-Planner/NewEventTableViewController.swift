//
//  NewEventTableViewController.swift
//  Event-Planner
//
//  Created by The Clout on 2/16/20.
//  Copyright © 2020 Draper Web Services. All rights reserved.
//

import UIKit
import CoreData

class NewEventTableViewController: UITableViewController {
    
    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var eventDate: UIDatePicker!
    @IBOutlet weak var eventStartTime: UIDatePicker!
    @IBOutlet weak var eventEndTime: UIDatePicker!
    @IBOutlet weak var eventVenue: UITextField!
    @IBOutlet weak var eventAddress: UITextField!
    
    var event: [NSManagedObject] = []
    
    
    @IBAction func createEventBtn(_ sender: Any) {
        addEvent()
    }
    
    func addEvent(){
        
        let eventData = Event(eventName: eventName.text!, eventDescription: eventDescription.text!, eventDate: String(eventDate.hashValue), eventStartTime: String(eventStartTime.hashValue) , eventEndTime: String(eventEndTime.hashValue) , eventVenue: eventVenue.text!, eventAddress: eventAddress.text!)
        
        let eventViewModel = EventViewModel(event: eventData)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let eventEntity = NSEntityDescription.entity(forEntityName: "EventInfo", in: managedContext)!
        
        let event = NSManagedObject(entity: eventEntity, insertInto: managedContext)
        
        event.setValue(eventViewModel.eventName, forKey: "eventName")
        event.setValue(eventViewModel.eventDescription, forKey: "eventDescription")
        event.setValue(eventViewModel.eventDate, forKey: "eventDate")
        event.setValue(eventViewModel.eventStartTime, forKey: "eventStartTime")
        event.setValue(eventViewModel.eventEndTime, forKey: "eventEndTime")
        event.setValue(eventViewModel.eventVenue, forKey: "eventVenue")
        event.setValue(eventViewModel.eventAddress, forKey: "eventAddress")
        
        do {
            try managedContext.save()
        } catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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