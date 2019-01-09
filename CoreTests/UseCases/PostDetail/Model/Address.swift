import Foundation
@testable import Core

extension Address {
    
    static func fake() -> Address {
        
        return Address(street: "street",
                       suite: "suite",
                       city: "city",
                       zipcode: "zipcode",
                       geo: Coordinates.fake())
        
    }

}

extension Address.Coordinates {
    
    static func fake() -> Address.Coordinates {
        
        return Address.Coordinates(lat: "lat", lng: "lng")
        
    }
    
}
