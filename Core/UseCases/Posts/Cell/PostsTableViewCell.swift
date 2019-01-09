import UIKit
import RxSwift
import RxCocoa

final class PostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    var viewModel: PostsTableViewCellViewModelType! {
        didSet {
            bind(viewModel.outputs)
        }
    }
    
    func bind(_ outputs: PostsTableViewCellViewModelOutputs) {
        
        outputs.title
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
}
