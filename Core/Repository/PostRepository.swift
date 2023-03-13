import Foundation
import RxSwift
import RxCocoa

public protocol PostRepositoryType {
    func getPosts(completion: @escaping (Result<[Post], Error>) -> Void)
}

extension Repository {
    
    public func getPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let resource = Resource<[Post]>(endpoint: "/posts")
        self.webservice.load(resource: resource, completion: completion)
    }
    
}

extension PostRepositoryType /* Rx */ {
    
    public func getPosts() -> Single<[Post]> {
        return Single.create { single in
            let disposable = Disposables.create()
            self.getPosts { result in
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
