import Foundation
import RxSwift
import RxCocoa

public protocol UserRepositoryType {
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

extension Repository {
    
    public func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let resource = Resource<[User]>(endpoint: "/users")
        self.webservice.load(resource: resource, completion: completion)
    }
    
}

extension UserRepositoryType /* Rx */ {
    
    public func getUsers() -> Single<[User]> {
        return Single.create { single in
            let disposable = Disposables.create()
            self.getUsers { result in
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
