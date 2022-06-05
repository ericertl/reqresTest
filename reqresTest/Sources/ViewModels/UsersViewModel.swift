//
//  UsersViewModel.swift
//  reqresTest
//
//  Created by Eric Ertl on 05/06/2022.
//

import Foundation

struct UsersViewModel {
    weak var dataSource: GenericDataSource<User>?
    private let networkManager: NetworkManager = NetworkManager()
    
    var onErrorHandling: ((Error?) -> Void)?
    var onUserDeleted: ((Int) -> Void)?
    
    // MARK: - Fetch Users
    
    func fetchUsers(page: Int = 1) {
        networkManager.reqresService.getUsers(page: page, completion: { (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                self.dataSource?.data.value = users
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        })
    }
    
    func deleteUser(userId: Int) {
        networkManager.reqresService.deleteUser(userId: userId, completion: { (result: Result<Void, Error>) in
            switch result {
            case .success():
                if let index = self.dataSource?.data.value.firstIndex(where: { $0.id == userId }) {
                    self.dataSource?.data.value.remove(at: index)
                }
                self.onUserDeleted?(userId)
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        })
    }
}
