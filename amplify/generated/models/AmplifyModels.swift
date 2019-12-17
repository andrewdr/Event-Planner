// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "b1ec8112520f9be5e47452aa779510e2"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: CreateEvent.self)
  }
}