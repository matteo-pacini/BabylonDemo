import Foundation

public struct Post: Codable {
    public let userId: Int
    public let id: Int
    public let title: String
    public let body: String
}
