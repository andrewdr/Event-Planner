//
//  WeatherModel.swift
//  Event-Planner
//
//  Created by The Clout on 5/20/20.
//  Copyright © 2020 Draper Web Services. All rights reserved.
//

import Foundation
//import UIKit

struct Weather: Codable {
    
    struct WeatherData: Codable {
        
//        let id: Int?
        let main: String?
        let description: String?
        let icon: String?
    }
    
    let weather: [WeatherData]?
    
    struct Main: Codable {
        
//        let temp: Double?
        let temp_min: Double?
        let temp_max: Double?

    }
    
    let main: Main?
    let dt: Int?
//    let id: Int?
    let name: String?
    
}






