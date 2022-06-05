//
//  User.swift
//  reqresTest
//
//  Created by Eric Ertl on 05/06/2022.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: URL?
}
