//
//  UsersViewModel.swift
//  reqresTest
//
//  Created by Eric Ertl on 05/06/2022.
//

import Foundation

final class UsersViewModel: NSObject {
    
    private var page: Int = 1
    private var total: Int = 0
    private weak var dataSource: GenericDataSource<User>?
    private let networkManager: NetworkManager = NetworkManager()
    
    var onErrorHandling: ((Error?) -> Void)?
    var onUserDeleted: ((Int) -> Void)?
    
    var hasMoreUsersToLoad: Bool {
        return dataSource?.data.value.count ?? 0 < total
    }
    
    init(dataSource: GenericDataSource<User>?) {
        self.dataSource = dataSource
    }
    
    func fetchUsers() {
        page = 1
        networkManager.reqresService.getUsers(page: page, completion: { [weak self] (result: Result<Users, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.dataSource?.data.value = users.data
                self.total = users.total
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        })
    }
    
    func fetchMoreUsers() {
        guard hasMoreUsersToLoad else {
            return
        }
        page = page + 1
        networkManager.reqresService.getUsers(page: page, completion: { [weak self] (result: Result<Users, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.dataSource?.data.value.append(contentsOf: users.data)
                self.total = users.total
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        })
    }
    
    func deleteUser(userId: Int) {
        networkManager.reqresService.deleteUser(userId: userId, completion: { [weak self] (result: Result<Void, Error>) in
            guard let self = self else { return }
            switch result {
            case .success():
                if let index = self.dataSource?.data.value.firstIndex(where: { $0.id == userId }) {
                    self.total = self.total - 1 // Quick fix the total, so we don´t show load more after deleting and max users where shown. This still can fail if we delete from the first fetch. This is also an issue as the api doesn´t really delete the user, so it always returns the same total
                    self.dataSource?.data.value.remove(at: index)
                }
                self.onUserDeleted?(userId)
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        })
    }
    
    func userViewModelForIndexPath(indexPath: IndexPath) -> UserViewModel? {
        guard let user = dataSource?.data.value[indexPath.row] else {
            return nil
        }
        return UserViewModel(user: user)
    }
}
