// swiftlint:disable all
import Amplify
import Foundation

public struct CreateEvent: Model {
  public let id: String
  public var eventName: String
  public var eventDescription: String
  public var eventDate: Date
  public var eventStartTime: Date
  public var eventEndTime: Date
  public var eventLocationName: String
  public var eventAddress: String
  
  public init(id: String = UUID().uuidString,
      eventName: String,
      eventDescription: String,
      eventDate: Date,
      eventStartTime: Date,
      eventEndTime: Date,
      eventLocationName: String,
      eventAddress: String) {
      self.id = id
      self.eventName = eventName
      self.eventDescription = eventDescription
      self.eventDate = eventDate
      self.eventStartTime = eventStartTime
      self.eventEndTime = eventEndTime
      self.eventLocationName = eventLocationName
      self.eventAddress = eventAddress
  }
}