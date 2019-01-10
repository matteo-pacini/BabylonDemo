import Foundation

public protocol KeyValueCodableStorageType {
    func set<T:Encodable>(_ value: T?, forKey key: String) throws
    func value<T:Decodable>(forKey key: String) -> T?
    func removeAll()
}

extension UserDefaults: KeyValueCodableStorageType {
    
    public func set<T>(_ value: T?, forKey key: String) throws where T: Encodable {
        let archiver = NSKeyedArchiver(requiringSecureCoding: false)
        try archiver.encodeEncodable(value, forKey: key)
        archiver.finishEncoding()
        self.set(archiver.encodedData as Any?, forKey: key)
    }
    
    public func value<T>(forKey key: String) -> T? where T : Decodable {
        guard let data = value(forKey: key) as? Data else {
            return nil
        }
        let unarachiver = try? NSKeyedUnarchiver(forReadingFrom: data)
        return unarachiver?.decodeDecodable(T.self, forKey: key)
    }
    
    public func removeAll() {
        removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
}
