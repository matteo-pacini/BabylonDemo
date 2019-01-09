import Foundation
@testable import Core

extension Company {
    
    static func fake() -> Company {
        
        return Company(name: "name",
                       catchPhrase: "catchPhrase",
                       bs: "bs")
        
    }
    
}
