import Foundation
@testable import Core
import RxSwift
import RxCocoa
import Quick
import Nimble

class PostDetailiewControllerSpec: QuickSpec {
    
    override func spec() {
        var sut: PostDetailViewController!
        var viewModelMock: PostDetailViewModelType!
        
        beforeEach {
            viewModelMock = PostDetailViewModelMock()
            
            sut = .fromStoryboard() as PostDetailViewController
            sut.viewModel = viewModelMock
            sut.loadViewIfNeeded()
        }
        
        describe("viewDidLoad") {
            
            it("has a title") {
                expect(sut.navigationItem.title).to(equal("detail.title"))
            }
        
            it("has an author") {
                expect(sut.authorLabel.text).to(equal("detail.author"))
            }
            
            it("has a description") {
                expect(sut.descriptionLabel.text).to(equal("detail.description"))
            }
            
            it("has a comment number") {
                expect(sut.commentsLabel.text).to(equal("detail.comments"))
            }
        }
        
    }
}
