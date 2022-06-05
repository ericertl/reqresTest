//
//  Router.swift
//  reqresTest
//
//  Created by Eric Ertl on 05/06/2022.
//

import Foundation

enum Router {
    
    case getUsers(page: Int)
    case getUser(userId: Int)
    
    var scheme: String {
        switch self {
        case .getUsers,
             .getUser:
            return "https"
        }
    }

    var host: String {
        switch self {
        case .getUsers,
             .getUser:
            return "reqres.in"
        }
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/api/users"
        case .getUser(let userId):
            return "/api/users/\(userId)"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getUsers(let page):
            return [
                URLQueryItem(name: "page", value: "\(page)")
            ]
        case .getUser:
            return []
        }
    }
    
    var method: String {
        switch self {
        case .getUsers,
             .getUser:
            return "GET"
        }
    }
    
}
