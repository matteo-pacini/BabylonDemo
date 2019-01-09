import Foundation
@testable import Core
import RxSwift
import RxCocoa

class PostsTableViewCellViewModelMock: PostsTableViewCellViewModelType,
PostsTableViewCellViewModelInputs,
PostsTableViewCellViewModelOutputs {
    
    var inputs: PostsTableViewCellViewModelInputs { return self }
    var outputs: PostsTableViewCellViewModelOutputs { return self }
    
    let title: Driver<String> = Driver.just("title")

    var tappedCalled = 0
    func tapped() {
        tappedCalled += 1
    }

}
