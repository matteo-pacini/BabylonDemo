import Foundation
@testable import Core
import RxSwift
import RxCocoa

class PostDetailViewModelMock: PostDetailViewModelType, PostDetailViewModelOutputs {
    
    var outputs: PostDetailViewModelOutputs { return self }

    let title: Driver<String> = Driver.just("detail.title")
    let author: Driver<String> = Driver.just("detail.author")
    let description: Driver<String> = Driver.just("detail.description")
    let progressHud: Driver<MBProgressHUDModel> = Driver.just(.hidden)
    let numberOfComments: Driver<String> = Driver.just("detail.comments")
    
}
