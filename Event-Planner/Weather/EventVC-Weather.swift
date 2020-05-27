//
//  EventVC-Weather.swift
//  Event-Planner
//
//  Created by The Clout on 5/24/20.
//  Copyright © 2020 Draper Web Services. All rights reserved.
//

import Foundation

    
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
                        
                        print(error as Any)
                    }
                    
                }else{
                    
                    let error = NSError(domain: " ", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was not recieved from request"]) as Error
                    completion?(.failure(error))
                }
            }
         
         
        }
     
         task.resume()
        
    }
    
        func fetchWeather(){
            
            getWeatherData(for: 4684888){ (result) in
                
                switch result{
                    
                case .success(let weather):
                    currentWeather = [weather]
                    
                    let weatherUpdate = currentWeather[0]
                    
                    if let cityName = weatherUpdate.name{
                        
    //                    insert city name into app name variable
                        
                        print("The city name is \(cityName)")
                    
                        
                    }
                    
                case .failure(let error):
                    fatalError("Error: \(error.localizedDescription)")
                }
                
            }
        }
    


