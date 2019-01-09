import Foundation

public protocol PostsCoordinatorType {
    func start(on window: UIWindow)
}

public class PostsCoordinator: PostsCoordinatorType {
    
    private weak var navigationController: UINavigationController!
    
    private let postRepository: PostRepositoryType
    private let postDetailCoordinator: PostDetailCoordinatorType

    public init(postRepository: PostRepositoryType,
                postDetailCoordinator: PostDetailCoordinatorType) {
        self.postRepository = postRepository
        self.postDetailCoordinator = postDetailCoordinator
    }
    
    public func start(on window: UIWindow) {
        
        let viewController: PostsViewController = .fromStoryboard()
        let viewModel = PostsViewModel(postRepository: postRepository)
        viewModel.delegate = self
        viewController.viewModel = viewModel
        
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        
        window.backgroundColor = .white
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
    
}

extension PostsCoordinator: PostsViewModelDelegate {
    
    func tapped(post: Post) {
        
        postDetailCoordinator.start(on: navigationController, with: post)
        
    }
    
}
