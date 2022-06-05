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
}

extension UsersDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
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
    
}
