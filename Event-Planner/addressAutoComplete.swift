//
//  addressAutoComplete.swift
//  Event-Planner
//
//  Created by The Clout on 5/7/20.
//  Copyright © 2020 Draper Web Services. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

    
class AddressAutoComplete: NewEventTableViewController, GMSAutocompleteResultsViewControllerDelegate {
    
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        print("Place Name: \(String(describing: place.name))")
        print("Place ID: \(String(describing: place.placeID))")
        
        eventAddress.text = String(describing:place.name)
        
        dismiss(animated: true, completion: nil)

    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        print("Error:", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController){
        dismiss(animated: true, completion: nil)
    }
    
    override func textViewDidBeginEditing(_ textView: UITextView) {
          
          if textView == eventAddress{
            
                  let autocompleteController = GMSAutocompleteResultsViewController()
                    autocompleteController.delegate = self

            //        Specify the place data types to return
                    let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue))!
                    autocompleteController.placeFields = fields
                    
            //        Specify Filter
                    let filter = GMSAutocompleteFilter()
                    filter.type = .address
                    autocompleteController.autocompleteFilter = filter
                    
            //        display the autocomplete view controller
                    present(autocompleteController, animated: true, completion: nil)
              
          }
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
  
    
//    @objc func autocompleteClicked(_ sender: UITextView){
//
//
//        let autocompleteController = GMSAutocompleteResultsViewController()
//        autocompleteController.delegate = self
//
////        Specify the place data types to return
//        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue))!
//        autocompleteController.placeFields = fields
//
////        Specify Filter
//        let filter = GMSAutocompleteFilter()
//        filter.type = .address
//        autocompleteController.autocompleteFilter = filter
//
////        display the autocomplete view controller
//        present(autocompleteController, animated: true, completion: nil)
//
//    }
    
    
    
}
