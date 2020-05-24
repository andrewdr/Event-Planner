//
//  WeatherVC.swift
//  Event-Planner
//
//  Created by The Clout on 5/22/20.
//  Copyright © 2020 Draper Web Services. All rights reserved.
//

import UIKit

class WeatherVC: NewEventTableViewController {
    
    let API_Key = "5e1695060555c2b38f76321e76c34042"
       
       var currentWeather = [Weather]()
       
       enum Result<Value>{
           
           case success(Value)
           case failure(Error)
           
       }
       
       func getWeatherData(for id:Int, completion:((Result<Weather>) -> Void)?){
           
           // MARK - URL Creation
           var url_Components = URLComponents()
           
           url_Components.scheme = "https"
           url_Components.host = "api.openweathermap.org"
           url_Components.path = "/data/2.5/weather"
           
           let userIdItem = URLQueryItem(name: "id", value: "\(id)")
           let appIdItem = URLQueryItem(name: "appid", value: "\(API_Key)")
           
           url_Components.queryItems = [userIdItem, appIdItem]
           
           guard let url = url_Components.url else { fatalError("Could Not Create URL from Components")}
           
           // MARK - URL Session
           
           var request = URLRequest(url: url)
           
           request.httpMethod = "GET"
           
           let config = URLSessionConfiguration.default
           let session = URLSession(configuration: config)
           
           let task = session.dataTask(with: request){(data, response, error) in
               DispatchQueue.main.async {
                   
                   if let error = error{
                       
                       completion?(.failure(error))
                       
                   }else if let jsonData = data{
                       
                       let decoder = JSONDecoder()
                       
                       do {
                           
                           let weather = try decoder.decode(Weather.self, from: jsonData)
                           completion?(.success(weather))
                           
                           print(weather)
                           
                       }catch{
                           
                           completion?(.failure(error))
                       }
                       
                   }else{
                       
                       let error = NSError(domain: " ", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was not recieved from request"]) as Error
                       completion?(.failure(error))
                   }
               }
           }
           
           task.resume
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWeatherData(for: 4684888) {(result) in
            
            switch result{
                
            case.success(let: weather):
                self.currentWeather = [weather]
                
                let weatherUpdate = self.currentWeather[0]
                
                if let cityName = weatherUpdate.name{
                    
//                    self.city.text = cityName
                }
                
            case.failure(let error):
                fatalError("Error: \(error.localizedDescription)")
                
            }
            
        }


    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
