import Foundation
@testable import Core

extension User {
    
    static func fake() -> User {
        
        return User(id: 1,
                    name: "name",
                    username: "username",
                    email: "email",
                    address: Address.fake(),
                    phone: "phone",
                    website: "website",
                    company: Company.fake())
        
    }
    
}
