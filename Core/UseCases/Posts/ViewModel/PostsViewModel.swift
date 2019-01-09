import Foundation
import RxSwift
import RxCocoa

protocol PostsViewModelOutputs {
    var title: Driver<String> { get }
    var entries: Driver<[PostsTableViewCellViewModelType]>! { get }
    var progressHud: Driver<MBProgressHUDModel> { get }
}

protocol PostsViewModelType {
    var outputs: PostsViewModelOutputs { get }
}

protocol PostsViewModelDelegate: class {
    func tapped(post: Post)
}

final class PostsViewModel: PostsViewModelType, PostsViewModelOutputs {
    
    weak var delegate: PostsViewModelDelegate?
    
    var outputs: PostsViewModelOutputs { return self }
    
    let title: Driver<String>
    var entries: Driver<[PostsTableViewCellViewModelType]>!
    let progressHud: Driver<MBProgressHUDModel>
    
    private let postRepository: PostRepositoryType
    
    private let disposeBag = DisposeBag()
    
    public init(postRepository: PostRepositoryType) {
        
        self.postRepository = postRepository
        
        title = Driver.just("Posts")
        
        let postEvents = postRepository.getPosts()
            .asObservable()
            .materialize()
            .share()
        
        let posts = postEvents.filter {
            return $0.event.element != nil
        }.map {
            return $0.event.element!
        }
        
        progressHud = postEvents.map { _ in return MBProgressHUDModel.hidden }
            .startWith(MBProgressHUDModel(message: "Loading posts..."))
            .asDriver(onErrorJustReturn: .hidden)
        
        additionalInit(posts)
        
    }
    
    private func additionalInit(_ posts: Observable<[Post]>) {
        
        entries = posts.map {
            self.viewModels(withPosts: $0, delegate: self)
        }
        .asDriver(onErrorJustReturn: [])
    }
    
    private func viewModels(withPosts posts: [Post],
                            delegate: PostsTableViewCellViewModelDelegate) -> [PostsTableViewCellViewModel] {
        
        return posts.map { post in
            let viewModel = PostsTableViewCellViewModel(post: post)
            viewModel.delegate = delegate
            return viewModel
        }
        
    }

}

extension PostsViewModel: PostsTableViewCellViewModelDelegate {
    
    func tapped(from viewModel: PostsTableViewCellViewModel) {
        delegate?.tapped(post: viewModel.post)
    }
    
}
