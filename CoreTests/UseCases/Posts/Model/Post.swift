import Foundation
@testable import Core

extension Post {
    
    static func fake() -> Post {
        return Post(userId: 1,
                    id: 1,
                    title: "title",
                    body: "body")
    }
    
}
