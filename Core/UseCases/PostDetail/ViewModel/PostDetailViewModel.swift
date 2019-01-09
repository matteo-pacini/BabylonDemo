import Foundation
import RxSwift
import RxCocoa

protocol PostDetailViewModelOutputs {
    var title: Driver<String> { get }
    var author: Driver<String> { get }
    var description: Driver<String> { get }
    var progressHud: Driver<MBProgressHUDModel> { get }
    var numberOfComments: Driver<String> { get }
}

protocol PostDetailViewModelType {
    var outputs: PostDetailViewModelOutputs { get }
}

final class PostDetailViewModel: PostDetailViewModelType, PostDetailViewModelOutputs {
    
    var outputs: PostDetailViewModelOutputs { return self }
    
    let title: Driver<String>
    let author: Driver<String>
    let description: Driver<String>
    let progressHud: Driver<MBProgressHUDModel>
    let numberOfComments: Driver<String>
    
    private let post: Post
    private let userRepository: UserRepositoryType
    private let commentRepository: CommentRepositoryType
    
    init(post: Post,
         userRepository: UserRepositoryType,
         commentRepository: CommentRepositoryType) {
        
        self.post = post
        self.userRepository = userRepository
        self.commentRepository = commentRepository
        
        title = Driver.just("Post n. \(post.id)")
        
        let userEvents = userRepository.getUsers()
            .asObservable()
            .materialize()
            .share()
        
        let users = userEvents.filter {
            return $0.event.element != nil
        }.map {
            return $0.event.element!
        }
        
        let commentEvents = userEvents.flatMap { _ in
            commentRepository.getComments()
                .asObservable()
        }
        .materialize()
        .share()
        
        let comments = commentEvents.filter {
            return $0.event.element != nil
        }.map {
            return $0.event.element!
        }
        
        author = users.map { $0.filter { $0.id == post.userId } }
            .map { $0.first?.username ?? "Unknown user" }
            .startWith("Loading...")
            .asDriver(onErrorJustReturn: "Unknown user")
        
        numberOfComments = comments.map { $0.filter { $0.postId == post.id } }
            .map { "\($0.count) comments" }
            .startWith("Loading...")
            .asDriver(onErrorJustReturn: "0 comments")
        
        description = Driver.just(post.title)
        
        progressHud = Observable.merge(
                userEvents.map { _ in return MBProgressHUDModel(message: "Loading comments...") },
                commentEvents.map { _ in return MBProgressHUDModel.hidden }
            )
            .startWith(MBProgressHUDModel(message: "Loading users..."))
            .asDriver(onErrorJustReturn: .hidden)
        
    }
    
}
