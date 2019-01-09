import Foundation
@testable import Core

extension Comment {
    
    static func fake() -> Comment {
        
        return Comment(postId: 1,
                       id: 1,
                       name: "name",
                       email: "email",
                       body: "body")
        
    }
    
}
