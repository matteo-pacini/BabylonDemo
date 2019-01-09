import Foundation

public struct Comment: Codable {
    public let postId: Int
    public let id: Int
    public let name: String
    public let email: String
    public let body: String
}
