import Foundation
@testable import Core
import RxSwift
import RxCocoa
import Quick
import Nimble

class PostsViewControllerSpec: QuickSpec {
    
    override func spec() {
        var sut: PostsViewController!
        var viewModelMock: PostsViewModelType!
        
        beforeEach {
            viewModelMock = PostsViewModelMock()

            sut = .fromStoryboard() as PostsViewController
            sut.viewModel = viewModelMock
            sut.loadViewIfNeeded()
        }
        
        describe("viewDidLoad") {
            
            it("has a title") {
                expect(sut.navigationItem.title).to(equal("title"))
            }
            
            it("has three posts") {
                expect(sut.tableView.numberOfRows(inSection: 0)).to(equal(3))
            }
            
        }
        
        describe("posts") {
            
            context("tableview cell") {
                
                var cell: PostsTableViewCell!
                var cellModel: PostsTableViewCellViewModelMock!
                
                beforeEach {
                    cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? PostsTableViewCell
                    cellModel = cell.viewModel as? PostsTableViewCellViewModelMock
                }
                
                it("has a title") {
                    
                    expect(cell.titleLabel.text).to(equal("title"))
                    
                }
                
                it("calls the cell delegate then tapped") {
                    
                    expect(cellModel.tappedCalled).to(equal(0))
                    
                    sut.dataSource.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                    
                    expect(cellModel.tappedCalled).to(equal(1))
                    
                }
                
            }
            
        }
    
    }
    
}
