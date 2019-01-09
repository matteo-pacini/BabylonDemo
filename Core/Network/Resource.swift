import Foundation

// The rest of the methods has been omitted, for the sake of the demo
public enum HttpMethod: String {
    case get = "GET"
}

public struct Resource<T: Decodable> {
    
    typealias Endpoint = String
    
    let endpoint: Endpoint
    let method: HttpMethod
    let decoder: (Data) throws -> T
    
}

extension Resource {
    
    init(endpoint: Endpoint, method: HttpMethod = .get) {
        let decoder: (Data) throws -> T = { data in
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        }
        self.init(endpoint: endpoint, method: method, decoder: decoder)
    }
    
}
