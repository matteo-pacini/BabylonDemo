import UIKit
import RxSwift
import RxCocoa

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    var viewModel: PostDetailViewModelType!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(viewModel.outputs)
    }
    
    private func bind(_ outputs: PostDetailViewModelOutputs) {
        
        outputs.title
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        outputs.author
            .drive(authorLabel.rx.text)
            .disposed(by: disposeBag)
        
        outputs.description
            .drive(descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        outputs.progressHud
            .drive(rx.progressHUD)
            .disposed(by: disposeBag)
        
        outputs.numberOfComments
            .drive(commentsLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
