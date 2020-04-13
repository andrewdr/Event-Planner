//
//  EventDetailTableVC.swift
//  Event-Planner
//
//  Created by The Clout on 4/12/20.
//  Copyright © 2020 Draper Web Services. All rights reserved.
//

import UIKit

class EventDetailTableVC: UITableViewController {
    
    
    var eventNameData = String()
    var eventDateData = String()
    var eventStartTimeData = String()
    var eventEndTimeData = String()
    var eventDescriptionData = String()
    var eventVenueData = String()
    var eventAddressData = String()
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventStartTime: UILabel!
    @IBOutlet weak var eventEndTime: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    @IBOutlet weak var eventVenue: UILabel!
    @IBOutlet weak var eventAddress: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventName.text = eventNameData
        eventDate.text = eventDateData
        eventStartTime.text = "\(eventStartTimeData) " + " - "
        eventEndTime.text = eventEndTimeData
        eventDescription.text = eventDescriptionData
        eventVenue.text = eventVenueData
        eventAddress.text = eventAddressData
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
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
