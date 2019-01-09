import Foundation

public struct Address: Codable {
    public let street: String
    public let suite: String
    public let city: String
    public let zipcode: String
    public let geo: Coordinates
}

public extension Address {
    
    struct Coordinates: Codable {
        public let lat: String
        public let lng: String
    }
    
}
