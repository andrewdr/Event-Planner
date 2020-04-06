//
//  SecondViewController.swift
//  Event-Planner
//
//  Created by The Clout on 12/5/19.
//  Copyright © 2019 Draper Web Services. All rights reserved.
//

import UIKit
import CoreData

//class EventCell: UITableViewCell{
//
//    @IBOutlet weak var eventCellName: UILabel!
//    @IBOutlet weak var eventCellDate: UILabel!
//    @IBOutlet weak var eventCellStartTime: UILabel!
//
//}

class SecondViewController: UITableViewController{
    
//    MARK: - Event Table Configuration
    
    var eventViewModel = [EventViewModel]()

    var eventInfo: [NSManagedObject] = [EventInfo]()
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchEventData()
        

        
        
    }
    
}

