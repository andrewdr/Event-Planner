//
//  EventModel.swift
//  Event-Planner
//
//  Created by The Clout on 2/17/20.
//  Copyright © 2020 Draper Web Services. All rights reserved.
//

import Foundation
import UIKit

struct Event{
    
    let eventName: String?
    let eventDescription: String?
    let eventDate: String?
    let eventStartTime: String?
    let eventEndTime: String?
    let eventVenue: String?
    let eventAddress: String?
    
    init( eventName: String? = nil, eventDescription: String? = nil, eventDate: String? = nil, eventStartTime: String? = nil, eventEndTime: String? = nil, eventVenue: String? = nil, eventAddress: String? = nil) {
        
        self.eventName = eventName
        self.eventDescription = eventDescription
        self.eventDate = eventDate
        self.eventStartTime = eventStartTime
        self.eventEndTime = eventEndTime
        self.eventVenue = eventVenue
        self.eventAddress = eventAddress
        
    }
    
    
    
}
