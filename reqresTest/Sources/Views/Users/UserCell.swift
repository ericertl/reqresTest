//
//  UserCell.swift
//  reqresTest
//
//  Created by Eric Ertl on 05/06/2022.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!{
        didSet {
            userImageView.isHidden = true
        }
    }
    
    var addButtonAction : (() -> Void)?
    
    var user: User? {
        didSet {
            guard let user = user else {
                return
            }

            nameLabel?.text = "\(user.firstName) \(user.lastName)"
            emailAddressLabel?.text = user.email
        }
    }
}


