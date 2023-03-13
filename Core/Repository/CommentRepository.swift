import Foundation
import RxSwift
import RxCocoa

public protocol CommentRepositoryType {
    func getComments(completion: @escaping (Result<[Comment], Error>) -> Void)
}

extension Repository {
    
    public func getComments(completion: @escaping (Result<[Comment], Error>) -> Void) {
        let resource = Resource<[Comment]>(endpoint: "/comments")
        self.webservice.load(resource: resource, completion: completion)
    }
    
}

extension CommentRepositoryType /* Rx */ {
    
    public func getComments() -> Single<[Comment]> {
        return Single.create { single in
            let disposable = Disposables.create()
            self.getComments { result in
                switch result {
                case .success(let result):
                    single(.success(result))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return disposable
        }
    }
    
}
