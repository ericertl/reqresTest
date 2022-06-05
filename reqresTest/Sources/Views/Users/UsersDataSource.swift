//
//  UsersDataSource.swift
//  reqresTest
//
//  Created by Eric Ertl on 05/06/2022.
//

import Foundation
import UIKit

class UsersDataSource: GenericDataSource<User> {
    private var imageLoader = ImageLoader()
    var onDeleteUser: ((User) -> Void)?
}

extension UsersDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = data.value.count
        if numberOfRows == 0 {
            tableView.setEmptyView(title: "There are no users.", message: "Looks like there are no users to display.")
        }
        else {
            tableView.restore()
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        let user = data.value[indexPath.row]
        cell.user = user
        cell.userImageView.isHidden = true
        
        if let avatar = user.avatar {
            imageLoader.obtainImageWithPath(imagePath: avatar.absoluteString) { (image) in
                if let updateCell = tableView.cellForRow(at: indexPath) as? UserCell {
                    updateCell.userImageView?.image = image
                    updateCell.userImageView?.isHidden = false
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let user = data.value[indexPath.row]
            onDeleteUser?(user)
        }
    }
}
