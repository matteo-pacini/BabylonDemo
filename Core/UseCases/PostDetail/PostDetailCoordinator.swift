import Foundation

public protocol PostDetailCoordinatorType {
    func start(on navigationController: UINavigationController, with post: Post)
}

public final class PostDetailCoordinator: PostDetailCoordinatorType {
    
    private weak var navigationController: UINavigationController!
    
    private let userRepository: UserRepositoryType
    private let commentRepository: CommentRepositoryType
    
    public init(userRepository: UserRepositoryType,
                commentRepository: CommentRepositoryType) {
        self.userRepository = userRepository
        self.commentRepository = commentRepository
    }
    
    public func start(on navigationController: UINavigationController,
                      with post: Post) {
        
        self.navigationController = navigationController
        
        let viewController: PostDetailViewController = .fromStoryboard()
        let viewModel = PostDetailViewModel(post: post,
                                            userRepository: userRepository,
                                            commentRepository: commentRepository)
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
