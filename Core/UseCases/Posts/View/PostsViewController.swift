import UIKit
import RxSwift
import RxCocoa

class PostsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = PostsDataSource()
    private let disposeBag = DisposeBag()
    
    var viewModel: PostsViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel.outputs)
        tableView.delegate = dataSource
    }
    
    func bind(_ outputs: PostsViewModelOutputs) {
        
        outputs.title
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        outputs.entries
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        outputs.progressHud
            .drive(rx.progressHUD)
            .disposed(by: disposeBag)
                
    }
    
}
