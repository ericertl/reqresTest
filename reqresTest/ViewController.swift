//
//  ViewController.swift
//  reqresTest
//
//  Created by Eric Ertl on 05/06/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let viewModel = UsersViewModel()
        viewModel.fetchUsers()
    }


}

