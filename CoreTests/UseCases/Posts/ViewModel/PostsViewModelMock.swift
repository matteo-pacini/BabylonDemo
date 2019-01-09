import Foundation
@testable import Core
import RxSwift
import RxCocoa

final class PostsViewModelMock: PostsViewModelType, PostsViewModelOutputs {
    
    var outputs: PostsViewModelOutputs { return self }
    
    let entries: Driver<[PostsTableViewCellViewModelType]>! = Driver.just([
        PostsTableViewCellViewModelMock(),
        PostsTableViewCellViewModelMock(),
        PostsTableViewCellViewModelMock()
    ])
    let title: Driver<String> = Driver.just("title")
    let progressHud: Driver<MBProgressHUDModel> = Driver.just(.hidden)

}
