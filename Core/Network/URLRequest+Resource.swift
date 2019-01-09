import Foundation

extension URLRequest {
    
    init<T>(resource: Resource<T>, baseURL: URL) where T: Decodable {
        
        guard let urlComponents = URLComponents(string: baseURL.appendingPathComponent(resource.endpoint).absoluteString) else {
            fatalError("BaseURL \(baseURL.appendingPathComponent(resource.endpoint).absoluteString) is malformed.")
        }
        
        guard let url = urlComponents.url else {
            fatalError("URL \(urlComponents.debugDescription) is malformed.")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = resource.method.rawValue
        
        self = request
    }
    
}
