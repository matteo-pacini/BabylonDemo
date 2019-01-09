import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

struct MBProgressHUDModel: Equatable {
    static let hidden = MBProgressHUDModel(message: nil)
    let message: String?
}

extension Reactive where Base: UIViewController {
    
    var progressHUD: Binder<MBProgressHUDModel> {
        return Binder(self.base) { viewController, model in
            if let message = model.message {
                let hud = MBProgressHUD.showAdded(to: viewController.view, animated: true)
                hud.label.text = message
            } else {
                MBProgressHUD.hide(for: viewController.view, animated: true)
            }
        }
    }
    
}
