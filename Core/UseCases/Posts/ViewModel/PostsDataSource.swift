import Foundation
import RxSwift
import RxCocoa

final class PostsDataSource: NSObject,
RxTableViewDataSourceType,
UITableViewDelegate,
UITableViewDataSource {
    
    private var elements: [PostsTableViewCellViewModelType] = []
    
    func tableView(_ tableView: UITableView, observedEvent: Event<[PostsTableViewCellViewModelType]>) {
        elements = observedEvent.element ?? []
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.identifier) as? PostsTableViewCell else {
            fatalError("Could not dequeue a PostsTableViewCell!")
        }
        cell.viewModel = elements[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = elements[indexPath.row]
        viewModel.inputs.tapped()
    }
}
