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

class EventListTableVC: UITableViewController {
    

    
    @IBOutlet var eventListTableView: UITableView!
    
    var eventViewModel = [EventViewModel]()
    
    var eventInfo: [NSManagedObject] = [EventInfo]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

       fetchEventData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventInfo.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
        
        let eventData = eventInfo[indexPath.row]
        
        cell.eventCellName.text = eventData.value(forKey: "eventName") as? String
        cell.eventCellDate.text = eventData.value(forKey: "eventDate") as? String
        cell.eventCellStartTime.text = eventData.value(forKey: "eventStartTime") as? String
        
        return cell
    }
    
    //    Mark: - Fetch Core Data
    
    func fetchEventData(){
        
        guard  let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"EventInfo")
        
        fetchRequest.fetchLimit = 3
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "eventName", ascending: false)]
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "eventDate", ascending: false)]
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "eventStartTime", ascending: false)]
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                print(data.value(forKey: "eventName") as! String)
                print(data.value(forKey: "eventDate") as! String)
                print(data.value(forKey: "eventStartTime") as! String)
            }
        } catch {
            
            print("Fetch Request Failed")
            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
