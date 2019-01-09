import Foundation

public protocol CoordinatorFactoryType {
    func makeApp() -> AppCoordinatorType
}

public class CoordinatorFactory: CoordinatorFactoryType {
    
    private let repository: RepositoryType
    
    public init(repository: RepositoryType) {
        self.repository = repository
    }
    
    public func makeApp() -> AppCoordinatorType {
        return AppCoordinator(postsCoordinator: makePosts())
    }
    
    public func makePosts() -> PostsCoordinatorType {
        return PostsCoordinator(postRepository: repository,
                                postDetailCoordinator: makePostDetail())
    }
    
    public func makePostDetail() -> PostDetailCoordinatorType {
        return PostDetailCoordinator(userRepository: repository,
                                     commentRepository: repository)
    }
}
