//
//  EventDetailTableVC.swift
//  Event-Planner
//
//  Created by The Clout on 4/12/20.
//  Copyright © 2020 Draper Web Services. All rights reserved.
//

import UIKit

class EventDetailTableVC: UITableViewController {
    
    @IBOutlet var eventDetailTableView: UITableView!
    
    
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
    @IBOutlet weak var eventWeather: UITextView!
    
    var highTemp: String?
    var lowTemp: String?
    var weatherDescription: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWeatherData(for: 4684888){ (result) in
                     
                     switch result{
                         
                     case .success(let weather):
                         currentWeather = [weather]
                         
                         print(currentWeather)
                         
                         let weatherUpdate = currentWeather[0]
                         
                         if let cityName = weatherUpdate.name{
                             
         //                    insert city name into app name variable
                             
                             print("The city name is \(cityName)")
                         
                         }
                         
                         if let getDescription = weatherUpdate.weather?.description{
                            self.weatherDescription = getDescription
                         }
                         
                         if let gethighTemp = weatherUpdate.main?.temp_max{
                            let kelvinToFar = (gethighTemp - 273.15) * 9/5 + 32
                            self.highTemp = String(format: "%.1f °F", kelvinToFar)
                        }
                         
                         if let getlowTemp = weatherUpdate.main?.temp_min{
                            let kelvinToFar = (getlowTemp - 273.15) * 9/5 + 32
                            self.lowTemp = String(format: "%.1f °F", kelvinToFar)
                         }
                        
                         self.eventWeather.text = "Current Weather \nHigh: \(String(self.highTemp ?? "Not Available")) \nLow: \(String(self.lowTemp ?? "Not Available"))"
                         
                     case .failure(let error):
                         fatalError("Error: \(error.localizedDescription)")
                     }
                 }
        
        eventName.text = eventNameData
        eventDate.text = eventDateData
        eventStartTime.text = "\(eventStartTimeData) " + " - "
        eventEndTime.text = eventEndTimeData
        eventDescription.text = eventDescriptionData
        eventVenue.text = eventVenueData
        eventAddress.text = eventAddressData
        
        
        eventDetailTableView.reloadData()
        eventDetailTableView.tableFooterView = UIView()
        
        
        
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        compareDates()
        
        return 7
    }
    
    func compareDates(){
        
        let currentUnformattedDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "E, MMM d, yyy"
        
        let currentDate = dateFormatter.string(from: currentUnformattedDate)
        
        if currentDate > eventDateData{
            
            print(currentDate, eventDateData)
            
            datePassedAlert()
        }
    }
    
    func datePassedAlert(){
        
        let datePassedAlert = UIAlertController(title: "Date Passed", message: "This event has passed, please remove this event.", preferredStyle: .alert)
        
        datePassedAlert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        self.present(datePassedAlert, animated: true, completion: nil)
        
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
