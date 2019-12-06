//
//  CreateEventController.swift
//  Event-Planner
//
//  Created by The Clout on 12/5/19.
//  Copyright © 2019 Draper Web Services. All rights reserved.
//

import UIKit

class CreateEventController: UIViewController {
    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var eventDate: UIDatePicker!
    @IBOutlet weak var eventStartTime: UIDatePicker!
    @IBOutlet weak var eventEndTime: UIDatePicker!
    @IBOutlet weak var eventLocationName: UITextField!
    @IBOutlet weak var eventAddress: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

