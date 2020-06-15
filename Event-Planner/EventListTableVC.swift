//
//  EventListTableVC.swift
//  Event-Planner
//
//  Created by The Clout on 4/5/20.
//  Copyright © 2020 Draper Web Services. All rights reserved.
//

import UIKit
import CoreData

class EventCell: UITableViewCell{
    
    @IBOutlet weak var eventCellName: UILabel!
    @IBOutlet weak var eventCellDate: UILabel!
    @IBOutlet weak var eventCellStartTime: UILabel!
    
}

class EventListTableVC: UITableViewController{
    

    @IBOutlet var eventListTableView: UITableView!

    
    var event: [NSManagedObject] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        eventListTableView.dataSource = self
        eventListTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchEventData()
        eventListTableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//         print(event.count)
        
        return event.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
    
        let eventData = event[indexPath.row]
        
//        print(eventData)
        
        cell.eventCellName.text = eventData.value(forKey: "eventName") as? String
        cell.eventCellDate.text = ((eventData.value(forKey: "eventDate") as? String)! + " -")
        cell.eventCellStartTime.text = eventData.value(forKey: "eventStartTime") as? String
        
        return cell
    }
    
    //    Mark: - Delete Core Data (Delete Event)
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let confirmationAlert = UIAlertController(title: "Delete Event?", message: "Are you sure you want to delete this event?", preferredStyle: .alert)
              
        confirmationAlert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {(action) -> Void in
            
            if editingStyle == . delete {
                        
                let eventData = self.event[indexPath.row]
            
                    managedContext.delete(eventData)
                    self.event.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                        
                    appDelegate.saveContext()
                }
            }))
        
              confirmationAlert.addAction(UIAlertAction(title: "No", style: .cancel))
                 
              self.present(confirmationAlert, animated: true, completion: nil)

    }
    
    //    Mark: - Fetch Core Data
    
    func fetchEventData(){
        
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"EventInfo")
        
        appDelegate.saveContext()

        do {
            
        let result = try managedContext.fetch(fetchRequest)

        event = (result as? [NSManagedObject])!
        } catch let error as NSError{
            
            print("Fetch Request Failed \(error)")
            
        }
        
        for data in event {
            print(data.value(forKey: "eventName") as! String)
//            print(data.value(forKey: "eventDate") as! String)
//            print(data.value(forKey: "eventDescription") as! String)
//            print(data.value(forKey: "eventStartTime") as! String)
//            print(data.value(forKey: "eventEndTime") as! String)
//            print(data.value(forKey: "eventVenue") as! String)
//            print(data.value(forKey: "eventAddress") as! String)
//
        }
        
    }
    
    // MARK: - Segue To Event Detail View
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewEventDetails"{
            let destinationVC = segue.destination as? EventDetailTableVC
            
            if let indexPath = eventListTableView?.indexPath(for: sender as! UITableViewCell) {
                
                let eventData = event[indexPath.row]
                
                print(eventData)
                
                destinationVC?.eventNameData = (eventData.value(forKey: "eventName") as? String)!
                destinationVC?.eventDateData = (eventData.value(forKey: "eventDate") as? String)!
                destinationVC?.eventStartTimeData = (eventData.value(forKey: "eventStartTime") as? String)!
                destinationVC?.eventEndTimeData = (eventData.value(forKey: "eventEndTime") as? String)!
                destinationVC?.eventDescriptionData = (eventData.value(forKey: "eventDescription") as? String)!
                destinationVC?.eventVenueData = (eventData.value(forKey: "eventVenue") as? String)!
                destinationVC?.eventAddressData = (eventData.value(forKey: "eventAddress") as? String)!
                
                }
            
            }
       }
    

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


    

}
