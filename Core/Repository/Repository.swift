import Foundation

public protocol RepositoryType: PostRepositoryType, UserRepositoryType, CommentRepositoryType {
    
}

public final class Repository: RepositoryType {
        
    let webservice: WebserviceType
    
    public init(webservice: WebserviceType) {
        self.webservice = webservice
    }
    
}
