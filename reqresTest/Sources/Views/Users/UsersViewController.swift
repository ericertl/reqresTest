//
//  UsersViewController.swift
//  reqresTest
//
//  Created by Eric Ertl on 05/06/2022.
//

import UIKit

class UsersViewController: UITableViewController {
    private let dataSource = UsersDataSource()
    private lazy var viewModel : UsersViewModel = {
        let viewModel = UsersViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Users"
        
        setupRefreshControl()
        setupDataSource()
        
        viewModel.onErrorHandling = { [weak self] error in
            DispatchQueue.main.async {
                let controller = UIAlertController(title: "Oops", message: "Something went wrong!", preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                self?.present(controller, animated: true, completion: nil)
            }
        }
        
        viewModel.onUserDeleted = { userId in
            // Here could go a dismiss for a loading indicator while deleting
            print("user \(userId) deleted")
        }
        
        startRefreshingUsers()
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(getUsers(_:)), for: .valueChanged)
        refreshControl?.attributedTitle = NSAttributedString(string: "Getting Users...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    private func setupDataSource() {
        tableView.dataSource = dataSource
        dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
        dataSource.onDeleteUser = { [weak self] user in
            self?.viewModel.deleteUser(userId: user.id)
        }
    }
    
    @objc private func getUsers(_ sender: Any) {
        // Get Users Data
        viewModel.fetchUsers()
    }
    
    private func startRefreshingUsers() {
        refreshControl?.beginRefreshing()
        refreshControl?.sendActions(for: .valueChanged)
    }
}
