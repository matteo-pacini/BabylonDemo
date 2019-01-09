import Foundation

public enum Result<T: Decodable> {
    case success(T)
    case failure(Error)
}
