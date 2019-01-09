import Foundation

public protocol WebserviceType {
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> Void) where T: Codable
    func clear()
}

public final class Webservice: WebserviceType {
    
    private let baseURL: URL
    private var session: URLSession
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    public func load<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> Void) where T: Codable {
        let request = URLRequest(resource: resource, baseURL: baseURL)
        session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(Webservice.Error.local(error!.localizedDescription)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200 ... 299 ~= httpResponse.statusCode else {
                completion(.failure(Webservice.Error.remote(error!.localizedDescription)))
                return
            }
            do {
                let model: T = try resource.decoder(data)
                completion(.success(model))
            } catch {
                completion(.failure(Webservice.Error.deserialisation(error.localizedDescription)))
            }
        }.resume()
    }

    
    public func clear() {
        session.invalidateAndCancel()
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
}

extension Webservice {
    
    public enum Error: Swift.Error, Equatable {
        case local(String)
        case remote(String)
        case deserialisation(String)
        
        public static func == (lhs: Webservice.Error, rhs: Webservice.Error) -> Bool {
            switch (lhs, rhs) {
            case let (.local(lhsMessage), .local(rhsMessage)):
                return lhsMessage == rhsMessage
            case let (.remote(lhsMessage), .remote(rhsMessage)):
                return lhsMessage == rhsMessage
            case let (.deserialisation(lhsMessage), .deserialisation(rhsMessage)):
                return lhsMessage == rhsMessage
            default:
                return false
            }
        }
        
    }
    
}
