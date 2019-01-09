import Foundation
@testable import Core
import RxSwift
import RxCocoa
import RxTest
import Quick
import Nimble

class PostsTableViewCellViewModelSpec: QuickSpec {
    
    override func spec() {
        
        var sut: PostsTableViewCellViewModelType!
        
        beforeEach {
            sut = PostsTableViewCellViewModelMock()
        }
        
        describe("init") {
            
            it("sets the title") {
                let scheduler = TestScheduler(initialClock: 0)
                let recordedOutputs = scheduler.record(sut.outputs.title)
                let expectedEvents = [
                    Recorded.next(0, "title"),
                    Recorded.completed(0)
                ]
                XCTAssertEqual(recordedOutputs.events, expectedEvents)
            }
            
        }
        
    }
}
