// swiftlint:disable all
import Amplify
import Foundation

extension CreateEvent {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case eventName
    case eventDescription
    case eventDate
    case eventStartTime
    case eventEndTime
    case eventLocationName
    case eventAddress
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let createEvent = CreateEvent.keys
    
    model.pluralName = "CreateEvents"
    
    model.fields(
      .id(),
      .field(createEvent.eventName, is: .required, ofType: .string),
      .field(createEvent.eventDescription, is: .required, ofType: .string),
      .field(createEvent.eventDate, is: .required, ofType: .date),
      .field(createEvent.eventStartTime, is: .required, ofType: .time),
      .field(createEvent.eventEndTime, is: .required, ofType: .time),
      .field(createEvent.eventLocationName, is: .required, ofType: .string),
      .field(createEvent.eventAddress, is: .required, ofType: .string)
    )
    }
}