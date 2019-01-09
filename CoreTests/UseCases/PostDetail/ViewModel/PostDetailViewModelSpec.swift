import Foundation
@testable import Core
import RxSwift
import RxCocoa
import RxTest
import Quick
import Nimble

class PostDetailViewModelSpec: QuickSpec {

    override func spec() {
        
        var sut: PostDetailViewModelType!
        
        beforeEach {
            
            sut = PostDetailViewModelMock()
            
        }
        
        describe("init") {
            
            it("sets the title") {
                let scheduler = TestScheduler(initialClock: 0)
                let recordedOutputs = scheduler.record(sut.outputs.title)
                let expectedEvents = [
                    Recorded.next(0, "detail.title"),
                    Recorded.completed(0)
                ]
                XCTAssertEqual(recordedOutputs.events, expectedEvents)
            }
            
            it("sets the author") {
                let scheduler = TestScheduler(initialClock: 0)
                let recordedOutputs = scheduler.record(sut.outputs.author)
                let expectedEvents = [
                    Recorded.next(0, "detail.author"),
                    Recorded.completed(0)
                ]
                XCTAssertEqual(recordedOutputs.events, expectedEvents)
            }
            
            it("sets the description") {
                let scheduler = TestScheduler(initialClock: 0)
                let recordedOutputs = scheduler.record(sut.outputs.description)
                let expectedEvents = [
                    Recorded.next(0, "detail.description"),
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
            
            it("sets the number of comments") {
                let scheduler = TestScheduler(initialClock: 0)
                let recordedOutputs = scheduler.record(sut.outputs.numberOfComments)
                let expectedEvents = [
                    Recorded.next(0, "detail.comments"),
                    Recorded.completed(0)
                ]
                XCTAssertEqual(recordedOutputs.events, expectedEvents)
            }
            
        }
        
    }
    
}
