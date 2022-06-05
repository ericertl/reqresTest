//
//  ReqresService.swift
//  reqresTest
//
//  Created by Eric Ertl on 05/06/2022.
//

import Foundation

final class ReqresService {
    weak var delegate: InternetConnectionProtocol?
}

// MARK: Public methods.
extension ReqresService {
    func getUsers(page: Int, completion: ((Result<[User], Error>) -> ())? = nil) {
        if let internetConnection = delegate?.hasInternetConnection(), !internetConnection {
            completion?(.failure(NetworkLayerError.noInternetConnection))
            return
        }
        
        NetworkLayer.request(router: Router.getUsers(page: page)) { (result: Result<Users, Error>) in
            switch result {
            case .success(let users):
                completion?(.success(users.data))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func getUser(userId: Int, completion: ((Result<User, Error>) -> ())? = nil) {
        if let internetConnection = delegate?.hasInternetConnection(), !internetConnection {
            completion?(.failure(NetworkLayerError.noInternetConnection))
            return
        }
        
        NetworkLayer.request(router: Router.getUser(userId: userId)) { (result: Result<SingleUser, Error>) in
            switch result {
            case .success(let singleUser):
                completion?(.success(singleUser.data))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
    
    func deleteUser(userId: Int, completion: ((Result<Void, Error>) -> ())? = nil) {
        if let internetConnection = delegate?.hasInternetConnection(), !internetConnection {
            completion?(.failure(NetworkLayerError.noInternetConnection))
            return
        }
        
        NetworkLayer.request(router: Router.deleteUser(userId: userId)) {  (result: Result<NoReply, Error>) in
            switch result {
            case .success(_):
                completion?(.success(Void()))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
