import UIKit

public protocol AppCoordinatorType {
    func start(on window: UIWindow)
}

public class AppCoordinator: AppCoordinatorType {
            
    private let postsCoordinator: PostsCoordinatorType
    
    public init(postsCoordinator: PostsCoordinatorType) {
        self.postsCoordinator = postsCoordinator
    }
    
    public func start(on window: UIWindow) {
        
        self.postsCoordinator.start(on: window)
        
    }
}
