//
//  EventViewModel.swift
//  Event-Planner
//
//  Created by The Clout on 2/17/20.
//  Copyright © 2020 Draper Web Services. All rights reserved.
//

import Foundation

struct EventViewModel{
    
    let eventName: String?
    let eventDescription: String?
    let eventDate: String?
    let eventStartTime: String?
    let eventEndTime: String?
    let eventVenue: String?
    let eventAddress: String?
    
    init(event: Event) {
        
        eventName = event.eventName ?? "My Cool Event"
        eventDescription = event.eventDescription ?? "My Birthday Party"
        eventDate = event.eventDate ?? "10-14-2020"
        eventStartTime = event.eventStartTime ?? "12:00"
        eventEndTime = event.eventEndTime ?? "18:00"
        eventVenue = event.eventVenue ?? "My House"
        eventAddress = event.eventAddress ?? "123 Mainstreet, Dallas, TX 75234"
        
    }
    
}
