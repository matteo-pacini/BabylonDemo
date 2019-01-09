import Foundation
@testable import Core
import RxSwift
import RxCocoa
import RxTest
import Quick
import Nimble

class PostsViewModelSpec: QuickSpec {
    
    override func spec() {
        
        var sut: PostsViewModelType!
        
        beforeEach {
            sut = PostsViewModelMock()
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
            
            it("sets the progress dialog") {
                let scheduler = TestScheduler(initialClock: 0)
                let recordedOutputs = scheduler.record(sut.outputs.progressHud)
                let expectedEvents = [
                    Recorded.next(0, MBProgressHUDModel.hidden),
                    Recorded.completed(0)
                ]
                XCTAssertEqual(recordedOutputs.events, expectedEvents)
            }
            
            it("sets 3 entries") {
                let scheduler = TestScheduler(initialClock: 0)
                let recordedOutputs = scheduler.record(sut.outputs.entries)
                expect(recordedOutputs.events.first?.value.element?.count).to(equal(3))
            }
        }
        
    }
    
}
