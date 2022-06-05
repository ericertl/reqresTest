//
//  Users.swift
//  reqresTest
//
//  Created by Eric Ertl on 05/06/2022.
//

import Foundation

struct Users: Codable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let data: [User]
}
