import Foundation

// Simple cached web service, with no expiry mechanism
public final class CachedWebservice: WebserviceType {
    
    private let decorated: WebserviceType
    private let storage: StorageType
    
    public init(decorated: WebserviceType, storage: StorageType) {
        self.decorated = decorated
        self.storage = storage
    }
    
    public func load<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> Void) where T: Codable {
        let key = resource.endpoint
        guard let stored = storage.value(forKey: key) as T? else {
            self.decorated.load(resource: resource) { result in
                switch result {
                case .success(let value):
                    try? self.storage.set(value, forKey: key)
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            return
        }
        completion(.success(stored))
    }
    
    public func clear() {
        decorated.clear()
    }
}
