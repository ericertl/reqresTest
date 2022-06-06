//
//  UserViewController.swift
//  reqresTest
//
//  Created by Eric Ertl on 05/06/2022.
//

import UIKit

class UserViewController: UIViewController {
    private var viewModel: UserViewModel
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initialSetup()
    }
}

// MARK:  Privates.
extension UserViewController {
    private func initialSetup() {
        title = "User detail"
        setupUI()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        
        let nameLabel = stackViewLabel(text: "Name: \(viewModel.user.firstName) \(viewModel.user.lastName)")
        let emailLabel = stackViewLabel(text: "Email: \(viewModel.user.email)")
        
        //Stack View
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 16.0
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
                                     stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     nameLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
                                     nameLabel.heightAnchor.constraint(equalToConstant: 20.0),
                                     emailLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
                                     emailLabel.heightAnchor.constraint(equalToConstant: 20.0),
        ])
    }
    
    private func stackViewLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
